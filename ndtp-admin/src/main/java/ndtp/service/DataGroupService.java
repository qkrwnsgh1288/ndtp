package ndtp.service;

import java.util.List;

import ndtp.domain.DataGroup;

public interface DataGroupService {
	
	/**
     * 데이터 그룹 목록
     * @return
     */
    List<DataGroup> getListDataGroup();

    /**
     * 데이터 그룹 등록
     * @param dataGroup
     * @return
     */
    int insertDataGroup(DataGroup dataGroup);
    
	/**
	 * 데이터 그룹 수정
	 * @param dataGroup
	 * @return
	 */
	int updateDataGroup(DataGroup dataGroup);
    
	/**
	 * 데이터 그룹 삭제
	 * @param dataGroupId
	 * @return
	 */
	int deleteDataGroup(int dataGroupId);
}
