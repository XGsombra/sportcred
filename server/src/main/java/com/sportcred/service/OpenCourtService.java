package com.sportcred.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.DependsOn;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sportcred.dao.OpenCourtPostDao;
import com.sportcred.dao.TagDao;
import com.sportcred.dto.GetOpenCourtPostOutput;
import com.sportcred.entity.OpenCourtPost;
import com.sportcred.helper.Helper;

@Service
@DependsOn("recommendationService")
public class OpenCourtService {
	@Autowired
	private OpenCourtPostDao openCourtPostDao;
	
	@Autowired
    private LikesService likesService;

//	@Autowired
//	private ViewPostService viewPostService;

//	@Autowired
//	private TagsService tagsService;
	
	@Autowired
	private TagDao tagDao;
	
	@Autowired
	private RecommendationService recommendationService;
	
	@Value("${sportcred.files-location}")
	private String filesLocation;
	
	private String apiImagesLocation = "/open_court_posts/";
	
	private String getImagesLocation() {
		return filesLocation + apiImagesLocation;
	}
	
	public void dataSetup() throws IllegalStateException, IOException {
		recommendationService.setup();
		addPost(1L, "I think LeBron looks like sunflower in that game.", null);
		addPost(3L, "hoho I am fan of Bull", null);
		addPost(2L, "Lakers is good!!!!!! But I like James Harden", null);
		addPost(6L, "Lakers is bad, boo!!!", null);
		addPost(7L, "nice job lakers", null);
		addPost(7L, "This is just a random post that is not so related to NBA", null);
		addPost(8L, "haha lakers congrats on not getting into the final", null);
		addPost(2L, "I love lakers", null);
		addPost(2L, "Incredible!! Game between Lakers and Warriors ends 304:12.", null);
		addPost(2L, "Lakers players poisoned Warriors players before the game.", null);
		addPost(8L, "Lakers trading LeBron James to Warriors for Stephen Curry.", null);
		addPost(1L, "Lakers players poisoned Warriors players before the game.", null);
		addPost(3L, "Lakers planning on a 30-year contract with Ilir Dema, who is currently teaching CSCC01 in UTSC.", null);
		addPost(5L, "Warriors offer a 40-year contract to Ilir in competition with Lakers.", null);
		addPost(4L, "Jordan : Ilir deserves a 50-year contract.", null);
		addPost(2L, "Breaking: Anthony Davis : I want to play with Jacob, he is better than Jordan.", null);
		addPost(7L, "Ma Bao Guo told Jordan to behave himself.", null);
		addPost(7L, "Jordan from Bull is a 69-year-old comrade.", null);
		addPost(5L, "Anyone likes Kobe Bryant?", null);
		addPost(5L, "I wish Raptors traded Siakam", null);
		addPost(3L, "Stephen Curry is a xiaoxuesheng, he said woshi xiaoxuesheng kuli.", null);
		addPost(1L, "Idk man, just thinking about posting some soccer stuff here. Sergio Ramos!!", null);
		addPost(3L, "Giannis Adetuokunbo is a name that I can not spell.", null);
		addPost(3L, "Breaking: Giannis traded to Beijing Shougang!", null);
		addPost(2L, "Giannis is taller than me I think.", null);
		addPost(7L, "I love Davis eyebrow, wish I have that too.", null);
		addPost(8L, "Woj: Curry is not happy that Harden killed him, and he is asking for a challenge for that.", null);
		addPost(8L, "LeBron James got 206 points in one game, making him the second best player in basketball history.", null);
		addPost(3L, "'Kyrie Irving should join the Warriors', said his high school coach Xukun Cai.", null);
		addPost(9L, "LeBron James Harden is a weird name.", null);
	}
	
	/* post */
	public void addPost(Long userId, String content, MultipartFile[] pictures) throws IllegalStateException, IOException {
		OpenCourtPost post = new OpenCourtPost();
		post.setContent(content);
		post.setUserId(userId);
		post.setCreatedTime(new Date().getTime());
		post.setLikeCount(0L);
		Long postId = openCourtPostDao.save(post).getId();
		if(pictures != null) {
			for (int i = 0; i < pictures.length;i++) {
				File imageDir = new File(getImagesLocation() + postId.toString());
				imageDir.mkdirs();
				pictures[i].transferTo(new File(imageDir.getPath() + "/" + i + Helper.getExtension(
						pictures[i].getOriginalFilename())));
			}
		}
		recommendationService.addPostTags(post);
	}
	
	public void viewPost(Long postId, Long userId) {
		recommendationService.viewPost(postId, userId);
	}
	
//	public List<Long> getNewPosts (Long time) {
//		return openCourtPostDao.getNewPosts(time);
//	}

	public List<Long> getNewPostsWithRecommendation(Long uid, int postNum){
		return recommendationService.recommend(uid, postNum);
//		List<Long> postList = tagsService.getRecommendationPid(uid, time);
//		int rndPostNum = postNum - postList.size();
//		List<Long> allPost = openCourtPostDao.getNewPosts(time);
//		List<Long> viewedPost = viewPostService.getViewPostPidByUid(uid);
//		for (int i=1;i<rndPostNum;i++){
//			Random rand = new Random();
//			Long pid;
//			do {
//				pid = allPost.get(rand.nextInt(allPost.size()));
//			} while (postList.contains(pid) || viewedPost.contains(pid));
//			postList.add(pid);
//		}
//		for (Long pid:postList){
//			viewPostService.addViewPost(uid, pid);
//		}
//		return postList;
	}
	public OpenCourtPost findPostById(Long id)  {
		Optional<OpenCourtPost> post = openCourtPostDao.findById(id);
		if(post.isPresent()) {
			return post.get();
		} else {
			return null;
		}
	}
	
	public GetOpenCourtPostOutput getPost(Long postId, Long userId) {
		Optional<OpenCourtPost> optionalPost = openCourtPostDao.findById(postId);
		if(optionalPost.isEmpty()) return null;
		OpenCourtPost post = optionalPost.get();
		List<String> pictures = new ArrayList<String>();
		File[] imgs = new File(getImagesLocation() + postId.toString()).listFiles();
		if (imgs != null) {
			for (File f: imgs) {
				String pathString = apiImagesLocation + postId.toString() + "/" + f.getName();
				pictures.add(pathString);
			}
		}
		GetOpenCourtPostOutput result = new GetOpenCourtPostOutput();
		result.setContent(post.getContent());
		result.setCreatedTime(post.getCreatedTime());
		result.setLikeCount(post.getLikeCount());
		result.setLikeCondition(likesService.getLikeCondition("openCourtPost", postId, userId));
		result.setPictures(pictures);
		result.setPostId(postId);
		result.setUserId(post.getUserId());
		result.setTags(tagDao.getTagByPid(post.getId()));
		return result;
	}
}
