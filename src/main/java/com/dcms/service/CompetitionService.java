package com.dcms.service;

import com.dcms.model.Competition;
import org.springframework.stereotype.Service;

@Service
public interface CompetitionService {
    Competition getLatestComp();
}
