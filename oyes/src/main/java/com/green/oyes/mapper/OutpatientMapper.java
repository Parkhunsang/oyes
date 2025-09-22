package com.green.oyes.mapper;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.green.oyes.dto.Outpatient;

@Mapper
public interface OutpatientMapper {
	List<Outpatient> allDeptList();

	int insert(Outpatient outpatient);

	int insertC(Outpatient outpatient);

	List<Outpatient> select(String patient_id);

	int delete(int outpatient_no);
}
