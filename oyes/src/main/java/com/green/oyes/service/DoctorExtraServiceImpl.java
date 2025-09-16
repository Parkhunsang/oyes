package com.green.oyes.service;

import com.green.oyes.dto.DoctorExtra;
import com.green.oyes.mapper.DoctorExtraMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DoctorExtraServiceImpl implements DoctorExtraService {

    @Autowired
    private DoctorExtraMapper dem;

    @Override
    public List<DoctorExtra> getDoctorExtra(int doctor_id) {
        return dem.getDoctorExtra(doctor_id);
    }
}