package com.green.oyes.mapper;

import com.green.oyes.dto.DoctorExtra;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface DoctorExtraMapper {
    List<DoctorExtra> getDoctorExtra(int doctor_id);
}