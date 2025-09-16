package com.green.oyes.service;

import com.green.oyes.dto.DoctorExtra;
import java.util.List;

public interface DoctorExtraService {
    List<DoctorExtra> getDoctorExtra(int doctor_id);
}