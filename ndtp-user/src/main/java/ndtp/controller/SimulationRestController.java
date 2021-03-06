package ndtp.controller;

import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import ndtp.config.PropertiesConfig;
import ndtp.domain.*;
import ndtp.persistence.CommentManageMapper;
import ndtp.persistence.StructPermissionMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;
import ndtp.service.CivilVoiceCommentService;
import ndtp.service.CivilVoiceService;
import ndtp.service.impl.SimuServiceImpl;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Slf4j
@RestController
@RequestMapping("/data/simulation-rest")
public class SimulationRestController {
	@Autowired
	private StructPermissionMapper structPermissionMapper;
	@Autowired
	private CommentManageMapper commentManageMapper;
	@Autowired
	private PropertiesConfig propertiesConfig;

	private static final long PAGE_ROWS = 5l;
	private static final long PAGE_LIST_COUNT = 5l;
	private final CivilVoiceService civilVoiceService;
	private final CivilVoiceCommentService civilVoiceCommentService;
	private final SimuServiceImpl simServiceImpl;
	String PREFIX_URL = "C:\\data\\mago3d\\normal-upload-data\\";
	String SAVE_PATH = "C:\\data\\mago3d\\normal-upload-data\\";

	public SimulationRestController(CivilVoiceService civilVoiceService, CivilVoiceCommentService civilVoiceCommentService, SimuServiceImpl simServiceImpl) {
		this.civilVoiceService = civilVoiceService;
		this.civilVoiceCommentService = civilVoiceCommentService;
		this.simServiceImpl = simServiceImpl;
	}

	@RequestMapping(value = "/select", method = RequestMethod.GET)
	@GetMapping(produces = MediaType.APPLICATION_JSON_VALUE)
	public Object select() {
		SimFileMaster sfm =  this.simServiceImpl.getSimFileMaster();
//		String resultFullPath = sfm.getSaveFilePath() + sfm.getSaveFileName();
		String resultFullPath = "C://data/Apartment_Building_26_obj/schoolphill.geojson";

		String os = System.getProperty("os.name").toLowerCase();
		if (os.contains("mac")) {
			resultFullPath = "/Users/junho/data/mago3d/building_obj/sejongbuilding.geojson";
		}
		File fi = new File(resultFullPath.trim());
		try {
			ObjectMapper mapper = new ObjectMapper();
			InputStream targetStream = new FileInputStream(fi);
			return mapper.readValue(targetStream, Object.class);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	@RequestMapping(value = "/drawGeojson", method = RequestMethod.GET)
	@GetMapping(produces = MediaType.APPLICATION_JSON_VALUE)
	public Object drawGeojson(String fileName) {
		String resultFullPath = propertiesConfig.getServiceFileBuildingobjDir() + fileName;

		String os = System.getProperty("os.name").toLowerCase();
		if (os.contains("mac")) {
			resultFullPath = "/Users/junho/data/mago3d/building_obj/" + fileName;
		}
		File fi = new File(resultFullPath.trim());
		try {
			ObjectMapper mapper = new ObjectMapper();
			InputStream targetStream = new FileInputStream(fi);
			return mapper.readValue(targetStream, Object.class);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

    @RequestMapping(value = "/cityConstProcUpload", method = RequestMethod.POST)
    public boolean cityConstProcUpload(SimFileMaster sfm) {
		System.out.println(sfm.toString());
		this.simServiceImpl.procConstProc(sfm);
		return true;
    }

	@RequestMapping(value = "/cityConstProcSelect", method = RequestMethod.GET)
	public List<F4DObject> cityConstProcSelect(SimFileMaster sfm) throws IOException {
		System.out.println(sfm.toString());
		sfm.setConsType(simServiceImpl.getConsTypeByConsTypeString(sfm.getConsTypeString()));
		sfm.setSaveFileType(simServiceImpl.getCityTypeByCityTypeString(sfm.getCityTypeString()));

		List<F4DObject> f4dObjList = new ArrayList<>();
		// Sejong Data Process
		if(sfm.getSaveFileType() == FileType.CONSTPROCSEJON || sfm.getSaveFileType() == FileType.CONSTPROCGEUMGANG) {
			var consBuildList = this.simServiceImpl.getConsBuildList(sfm)
					.stream().filter(obj -> obj.getSaveFileName().equals("relativePaths.json"))
					.collect(Collectors.toList());
			for( var obj : consBuildList) {
				F4DObject f4dObj = this.simServiceImpl.procF4DDataStrucreByPaths(obj.getSaveFilePath(), obj.getSaveFileName());
				f4dObj.setCons_ratio(obj.getConsRatio());
				f4dObj.setCons_type(sfm.getSaveFileType());
				f4dObj.setStep(obj.getConsType().getValue());
				f4dObjList.add(f4dObj);
			}
		} else if(sfm.getSaveFileType() == FileType.CONSTPROCSEJONALL) {
			var consBuildList = this.simServiceImpl.getConsBuildList(sfm)
					.stream().filter(obj -> obj.getSaveFileName().equals("lonsLats.json"))
					.collect(Collectors.toList());
			for (var obj : consBuildList) {
				var f4dObj = this.simServiceImpl.procF4DDataStrucreByPaths(obj.getSaveFilePath(), obj.getSaveFileName());
				f4dObj.setCons_ratio(obj.getConsRatio());
				f4dObj.setCons_type(FileType.CONSTPRO);
				f4dObj.setStep(obj.getConsType().getValue());
				f4dObjList.add(f4dObj);
			}
		} else {
				var consBuildList = this.simServiceImpl.getConsBuildList(sfm)
						.stream().filter(obj -> obj.getSaveFileName().equals("lonsLats.json"))
						.collect(Collectors.toList());
				for (var obj : consBuildList) {
					var f4dObj = this.simServiceImpl.procF4DDataStrucreByPaths(obj.getSaveFilePath(), obj.getSaveFileName());
					f4dObj.setCons_ratio(obj.getConsRatio());
					f4dObj.setCons_type(FileType.CONSTPRO);
					f4dObj.setStep(obj.getConsType().getValue());
					f4dObjList.add(f4dObj);
				}
			}
		return f4dObjList;
	}
	
    @RequestMapping(value = "/cityPlanUpload", method = RequestMethod.POST)
    public List<String> cityPlanUpload(MultipartFile[] files) {
    	List<String> result = this.simServiceImpl.procStroeShp(files, FileType.ECHODELTASHP);
		return result;
        // PROCESS...
    }
	
    @RequestMapping(value = "/buildAcceptUpload", method = RequestMethod.POST)
    public List<String> buildAcceptUpload(MultipartFile[] files) {
    	List<String> result = this.simServiceImpl.procStroeShp(files, FileType.ACCEPTBUILD);
		return result;
        // PROCESS...
    }
    
    @RequestMapping(value = "/cityPlanSelect", method = RequestMethod.GET)
    @GetMapping(produces = MediaType.APPLICATION_JSON_VALUE)
    public Object cityPlanSelect() {
    	SimFileMaster sfm =  this.simServiceImpl.getSimFileMaster();
    	String resultFullPath = sfm.getSaveFilePath() + sfm.getSaveFileName();
        File fi = new File(resultFullPath.trim());
        try {
            ObjectMapper mapper = new ObjectMapper();
            InputStream targetStream = new FileInputStream(fi);
            return mapper.readValue(targetStream, Object.class);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    @RequestMapping(value = "/cityPlanModelSelect", method = RequestMethod.GET)
    @GetMapping(produces = MediaType.APPLICATION_JSON_VALUE)
    public Object cityPlanModelSelect(String FileName, String preDir) {
//		String path1 = FileName.substring(0, FileName.lastIndexOf("."));
    	String resultFullPath = "C:\\data\\mago3d\\objects\\" + preDir + "\\" + FileName;
    	String os = System.getProperty("os.name").toLowerCase();
		if (os.contains("mac")) {
			resultFullPath = "/Users/junho/data/mago3d/objects/" + preDir + "/" + FileName;
		}
        File fi = new File(resultFullPath.trim());
        try {
            ObjectMapper mapper = new ObjectMapper();
            InputStream targetStream = new FileInputStream(fi);
            return mapper.readValue(targetStream, Object.class);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

	@RequestMapping(value = "/cityPlanModelSelect2", method = RequestMethod.GET)
	@GetMapping(produces = MediaType.APPLICATION_JSON_VALUE)
	public Object cityPlanModelSelect2(String FileName, String preDir, String preDir2) {
		String resultFullPath = "C:\\data\\mago3d\\building_obj\\" + preDir + "\\" + preDir2 + "\\" + FileName;
		String os = System.getProperty("os.name").toLowerCase();
		if (os.contains("mac")) {
			resultFullPath = "/Users/junho/data/mago3d/building_obj/" + preDir + "/" + preDir2 + "/" + FileName;
		}
		File fi = new File(resultFullPath.trim());
		try {
			ObjectMapper mapper = new ObjectMapper();
			InputStream targetStream = new FileInputStream(fi);
			return mapper.readValue(targetStream, Object.class);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	@RequestMapping(value = "/cityPlanModelSelect3", method = RequestMethod.GET)
	@GetMapping(produces = MediaType.APPLICATION_JSON_VALUE)
	public Object cityPlanModelSelect3(String FileName, String preDir) {
		String resultFullPath = "C:\\data\\mago3d\\building_obj\\" + preDir + "\\" + FileName;
		String os = System.getProperty("os.name").toLowerCase();
		if (os.contains("mac")) {
			resultFullPath = "/Users/junho/data/mago3d/building_obj/" + preDir + "/" + FileName;
		}
		File fi = new File(resultFullPath.trim());
		try {
			ObjectMapper mapper = new ObjectMapper();
			InputStream targetStream = new FileInputStream(fi);
			return mapper.readValue(targetStream, Object.class);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	@RequestMapping(value = "/getAccepBuildF4dJsonFile", method = RequestMethod.GET)
	@GetMapping(produces = MediaType.APPLICATION_JSON_VALUE)
	public Object getAccepBuildF4dJsonFile(String fileName) {
//    	String resultFullPath = "C:\\data\\Apartment_Building_26_obj\\Apartment_Building_26_obj.gltf";
		String resultFullPath = "C:\\data\\Apartment_Building_26_obj\\" + fileName;
		String os = System.getProperty("os.name").toLowerCase();
		if (os.contains("mac")) {
//			resultFullPath = "/Users/junho/data/mago3d/building_obj/Apartment_Building_26_obj.gltf";
			resultFullPath = "/Users/junho/data/mago3d/building_obj/CesiumMilkTruck.gltf";
		}
		File fi = new File(resultFullPath.trim());
		try {
			ObjectMapper mapper = new ObjectMapper();
			InputStream targetStream = new FileInputStream(fi);
			return mapper.readValue(targetStream, Object.class);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	@RequestMapping(value = "/getConsBuildF4dJsonFile", method = RequestMethod.GET)
	@GetMapping(produces = MediaType.APPLICATION_JSON_VALUE)
	public Object getConsBuildF4dJsonFile(String fileName) {
		// 세종인지 , 부산인지 먼저 선택 받아 그중 lonlats json만을 호출

		// 세종/부산 인지, 몇단계인지

		// mybatis에서는

		// 세종/부산, 면단계인지 정보를 통해 파일을 가져온다.

		// 가져온 파일에서 LonLats.json만을 추출한다.
		String resultFullPath = "C:\\data\\Apartment_Building_26_obj\\" + fileName;
		String os = System.getProperty("os.name").toLowerCase();
		if (os.contains("mac")) {
			resultFullPath = "/Users/junho/data/mago3d/building_obj/CesiumMilkTruck.gltf";
		}
		File fi = new File(resultFullPath.trim());
		try {
			ObjectMapper mapper = new ObjectMapper();
			InputStream targetStream = new FileInputStream(fi);
			return mapper.readValue(targetStream, Object.class);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}



	@RequestMapping(value = "/cityPlanResultInsert", method = RequestMethod.POST)
    public List<String> cityPlanResultInsert(CityPlanResult cityPlanResult) {
    	List<String> result = this.simServiceImpl.procCityPlanResult(cityPlanResult);
		return result;
    }

	/**
	 * 건축인허가 신청 등록 처리 로직
	 * @param mReq
	 * @return
	 */
	@RequestMapping(value = "/uploadBuildAccept", method = RequestMethod.POST)
	public StructPermission upload(MultipartHttpServletRequest mReq) {
		Map<String, MultipartFile> fileMap = mReq.getFileMap();
		Collection<MultipartFile> mFileCollection = fileMap.values();
		MultipartFile[] files = mFileCollection.toArray(MultipartFile[]::new);

		String constructor = mReq.getParameter("constructor");
		String constructor_type = mReq.getParameter("constructor_type");
		String birthday = mReq.getParameter("birthday");
		Float longitude = Float.parseFloat(mReq.getParameter("longitude"));
		Float latitude = Float.parseFloat(mReq.getParameter("latitude"));
		Float altitude = Float.parseFloat(mReq.getParameter("altitude"));
		Float heading = Float.parseFloat(mReq.getParameter("heading"));
		Float pitch = Float.parseFloat(mReq.getParameter("pitch"));
		Float roll = Float.parseFloat(mReq.getParameter("roll"));
		StructPermission spParam = StructPermission.builder()
				.constructor(constructor)
				.constructorType(constructor_type)
				.birthday(birthday)
				.longitude(longitude)
				.latitude(latitude)
				.altitude(altitude)
				.heading(heading)
				.pitch(pitch)
				.roll(roll)
				.build();

		StructPermission spNew = this.simServiceImpl.procAcceptBuild(files, spParam);
		return spNew;
	}

	@RequestMapping(value = "/getPermRequest", method = RequestMethod.POST)
	public List<StructPermission> getPermRequest(HttpServletRequest request, StructPermission sp) {
		List<StructPermission> result = structPermissionMapper.selectStructPermission(sp);
		return result;
	}

	@RequestMapping(value = "/putPemSend", method = RequestMethod.PUT)
	public StructPermission putPemSend(HttpServletRequest request, StructPermission sp) throws IOException {
		StructPermission oneResult = structPermissionMapper.putPermSend(sp);
		return oneResult;
	}

	// 지금
	@RequestMapping(value = "/getPermRequestByConstructor", method = RequestMethod.POST)
	public StructPermission getPermRequestByConstructor(HttpServletRequest request, StructPermission sp) throws IOException {
		StructPermission oneResult = structPermissionMapper.selectOne(sp);

		F4DObject f4dObject = this.simServiceImpl.procF4DDataStrucreByPaths(oneResult.getSaveModelFilePath(), oneResult.getSaveModelFileName());
		oneResult.setF4dObject(f4dObject);
		return oneResult;
	}
	@RequestMapping(value = "/getBatchAgendaChecked", method = RequestMethod.POST)
	public StructPermission getBatchAgendaChecked(HttpServletRequest request, StructPermission sp) throws IOException {
		StructPermission oneResult = structPermissionMapper.selectOne(sp);
		return oneResult;
	}
	@RequestMapping(value = "/saveBatchAgendaChecked", method = RequestMethod.POST)
	public int saveBatchAgendaChecked(HttpServletRequest request, StructPermission sp) throws IOException {
		int result = structPermissionMapper.updateBatchAgenda(sp);
		return result;
	}

	@RequestMapping(value = "/updateStructPermission", method = RequestMethod.POST)
	public int updateStructPermission(HttpServletRequest req) {
		String suitableCheck = req.getParameter("suitableCheck");
		if (suitableCheck.equals("false")) {
			return 0;
		}

		StructPermission sp = StructPermission.builder()
				.constructor(req.getParameter("constructor"))
				.constructorType(req.getParameter("constructor_type"))
				.build();

		int result = structPermissionMapper.updateStructPermission(sp);
		System.out.println(result);

		return result;
	}

	@RequestMapping(value = "/viewPdf", method = RequestMethod.POST)
	public String viewPdf(HttpServletRequest req) {
		String os = System.getProperty("os.name").toLowerCase();

		String projectPath = System.getProperty("user.dir");
		Integer permSeq = Integer.parseInt(req.getParameter("permSeq"));
		String oriFilePath = "";
		String copyFilePath = "";

		var structPermOne = new StructPermission().builder().permSeq(permSeq).build();

		StructPermission oneResult = structPermissionMapper.selectOne(structPermOne);

		if (os.contains("mac")) {
			oriFilePath = oneResult.getSaveFilePath() + oneResult.getSaveFileName();
			copyFilePath = projectPath + "/src/main/webapp/externlib/pdfjs/web/pdf_files/" + oneResult.getSaveFileName();
		} else {
			oriFilePath = oneResult.getSaveFilePath() + oneResult.getSaveFileName();
			copyFilePath = projectPath + "\\src\\main\\webapp\\externlib\\pdfjs\\web\\pdf_files\\" + oneResult.getSaveFileName();
		}

		Path source = Paths.get(oriFilePath);
		Path target = Paths.get(copyFilePath);

		// 사전체크
		if (source == null) {
			throw new IllegalArgumentException("source must be specified");
		}
		if (target == null) {
			throw new IllegalArgumentException("target must be specified");
		}
		if (Files.exists(target)) {
			return oneResult.getSaveFileName();
		}

		// 소스파일이 실제로 존재하는지 체크
		if (!Files.exists(source, new LinkOption[] {})) {
			throw new IllegalArgumentException("Source file doesn't exist: "
					+ source.toString());
		}

		try {
			Files.copy(source, target, StandardCopyOption.REPLACE_EXISTING); // 파일복사

		} catch (IOException e) {
			e.printStackTrace();
		}

//		Base64.Encoder encoder = Base64.getEncoder();
		if (Files.exists(target, new LinkOption[] {})) { // 파일이 정상적으로 생성이 되었다면
			// System.out.println("File Copied");
			return oneResult.getSaveFileName();
		} else {
//			System.out.println("File Copy Failed");
			return "false";
		}
	}

	@RequestMapping(value = "/getUserInfo", method = RequestMethod.POST)
	public String getUserInfo(HttpServletRequest req) {
		UserSession userSession = (UserSession)req.getSession().getAttribute(Key.USER_SESSION.name());
		String userID = userSession.getUserId();

		return userID;
	}

	@RequestMapping(value = "/commentList", method = RequestMethod.POST)
	public List<CommentManage> commentList(HttpServletRequest req, CommentManage cm) {
		List<CommentManage> res = commentManageMapper.selectCondition(cm);
		return res;
	}
	@RequestMapping(value = "/commentRegister", method = RequestMethod.POST)
	public List<CommentManage> commentRegister(HttpServletRequest req, CommentManage cm) {
		UserSession userSession = (UserSession)req.getSession().getAttribute(Key.USER_SESSION.name());
		String writer = userSession.getUserId();
		String commentTitle = cm.getCommentTitle();
		String commentContent = cm.getCommentContent();

		cm.setWriter(writer);
//		cm.setObjectName("testObject");
		int resultInsert = commentManageMapper.insertCommentManage(cm);

		List<CommentManage> res = commentManageMapper.selectCondition(cm);

		return res;
	}

	@RequestMapping(value = "/commentListConstructProcess", method = RequestMethod.POST)
	public List<CommentManage> commentListConstructProcess(HttpServletRequest req, CommentManage cm) {
		List<CommentManage> res = commentManageMapper.selectConditionObjectName(cm);
		return res;
	}
	@RequestMapping(value = "/commentRegisterConstructProcess", method = RequestMethod.POST)
	public List<CommentManage> commentRegisterConstructProcess(HttpServletRequest req, CommentManage cm) {
		UserSession userSession = (UserSession)req.getSession().getAttribute(Key.USER_SESSION.name());
		String writer = userSession.getUserId();
		String commentTitle = cm.getCommentTitle();
		String commentContent = cm.getCommentContent();

		cm.setWriter(writer);
//		cm.setObjectName("testObject");
		int resultInsert = commentManageMapper.insertCommentManage(cm);

		List<CommentManage> res = commentManageMapper.selectConditionObjectName(cm);

		return res;
	}

	private String genSaveFileName(String extName) {
		String fileName = "";

		Calendar calendar = Calendar.getInstance();
		fileName += calendar.get(Calendar.YEAR);
		fileName += calendar.get(Calendar.MONTH);
		fileName += calendar.get(Calendar.DATE);
		fileName += calendar.get(Calendar.HOUR);
		fileName += calendar.get(Calendar.MINUTE);
		fileName += calendar.get(Calendar.SECOND);
		fileName += calendar.get(Calendar.MILLISECOND);
		fileName += extName;

		return fileName;
	}

	private void writeFile(MultipartFile multipartFile, String saveFileName, String SAVE_PATH) throws IOException{
		this.genSaveFileName(SAVE_PATH);

		byte[] data = multipartFile.getBytes();
		FileOutputStream fos = new FileOutputStream(SAVE_PATH + "/" + saveFileName);
		fos.write(data);
		fos.close();
	}
}
