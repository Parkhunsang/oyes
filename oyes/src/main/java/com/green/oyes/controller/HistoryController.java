package com.green.oyes.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HistoryController {

    @GetMapping("/about/history")
    public String history(@RequestParam(name = "period", required = false, defaultValue = "2024") String period,
            Model model) {
        String[] events;
        switch (period) {
            case "2023-2022":
                model.addAttribute("title", "2023~2022");
                events = new String[]{
                        "2023년 12월 2일 이머시특별관광원, 대동특별관 제2센터 개소식 개최",
                        "2023년 10월 7일 이머시병원 로봇수술센터, 로봇수술 5,000례 달성",
                        "2022년 11월 12일 이머시특별관광원, 대동특별교육연합본부 지정",
                        "2022년 9월 1일 이머시병원, AI 보이스와 연동된 아쿠센트 도입"
                };
                break;
            case "2021-2020":
                model.addAttribute("title", "2021~2020");
                events = new String[]{
                        "2021년 12월 2일 이머시특별관광원, 제2센터 개소식 개최",
                        "2021년 10월 26일 이머시특별관광원, 특별 심포지엄 개최",
                        "2020년 11월 12일 이머시특별관광원, 대동특별교육연합본부 지정",
                        "2020년 10월 7일 이머시병원 로봇수술센터, 로봇수술 5,000례 달성"
                };
                break;
            default: // 현재~2024
                model.addAttribute("title", "현재~2024");
                events = new String[]{
                        "2024년 12월 2일 이머시특별관광원, 대동특별관 제2센터 개소식 개최",
                        "2024년 10월 26일 이머시특별관광원, 이머 특별라이브 심포지엄 개최",
                        "2024년 9월 1일 이머시병원, AI 보이스와 연동된 아쿠센트 도입",
                        "2025년 4월 20일 이머시특별관광원, 국내 최초 '임상형' 승인",
                        "2025년 7월 4일 이머시병원, IRB 평가 인증 현판식 개최"
                };
        }
        model.addAttribute("events", events);
        return "about/history";
    }
}
