Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F7715C15F;
	Sat,  5 Apr 2025 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743858204; cv=none; b=Zu3LLsdSJIDv1Oj07lySMkr40TcyNSA+Rafr0UW+0esbc8KrTh//MsY9nmOx9x0V0ZCiP5HAhBxCGos9Wgr9ibgqKOSU3f8x278P3xGFbLcDxd7b+qVUrRaiA1DK84jPuyhOL9yDlysiwLLdiKPkJ5j1xnMRRgGe/hCH81eaVRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743858204; c=relaxed/simple;
	bh=QtQievvHKTKHD95vEVdc8kNiFwXouDDzKVexpbsiNz0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BIYFG0pa2iXsou9GthU9l4WM+ExSDP93ALQ635lms6zR/zRPIM1pMEA/QDD74P6rGsWfWUaJORKSAnIWqHq6Fkqapa86EFeuDmIDZjxwXYZeJAXV+JAkZGcLo44AZrnMIaiVZ2LIhcH+2OcykbYZUcBxP9IWCeo9C8lKnjVz5zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clCw5Oy1; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clCw5Oy1"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso2554163f8f.2;
        Sat, 05 Apr 2025 06:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743858201; x=1744463001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1M3H/KZ5Fz4RueCHGz59IJwoPyfMrGqEUU3429ZwWuw=;
        b=clCw5Oy1Lqsi//s5zFL6BwOUThkaqMl6UkDtukWRTuOfu5ZnnxAamxRKNENp1J3sQ1
         RF7/Yry6+fd9bRMu68fmFS3THntc140Gch8hZHSmWSyBNJAwEHodGjnRdQMEDFeLi4k+
         duqGwaViJ3q0DYCfYZM7VO/IWU8xhVhQs93wsyDod9dgUI8FPPc7Rbwt2n7srcnCOciZ
         9ViDv+8iMEJtkkCjhL+lDKwEv4gTdZSsIzYsVDLivLloB2qWmHx8ZK9b5OHTDuJ6WlIj
         eys+xvP/HzKLnAm4QvTsZYnUR92FIJu28WqKGzLDi/LCzMWXXv+o3rsYplByiwhEnTKj
         46zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743858201; x=1744463001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1M3H/KZ5Fz4RueCHGz59IJwoPyfMrGqEUU3429ZwWuw=;
        b=prWcqJNZiqS7XRa1q2a5shmYQQh+GYowpFKl0SBZRQlO+XsLKXgQaHUZyICcOhdqN8
         BC+RUnh2HrmYBimnG0jpdJ15D00AgnNRCDMHwZ75flPfHP0AmUuzREfbKDVE0G5wYp6W
         gfYZs3roRuDir6KBJVBPWB9muRvk3sR8pLvsojp25WZf9ySN0tBamK7KhBmkgEV0kKuv
         rxOzGgcwFSuyd7bdVGuEAVG3wZgeIPz6PLjQXZnXbi6Jdvox/8Bceyi1py4kMRZJ3YR2
         Z9iJR+LsafBlpckEq2gXZM4Zr6I6hUD6icNVoI8LfXStJzAssCujL3VCzbr3rwOdwXK1
         hfWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1gL1WZUCtA+0cnU/P80Y4kjzkUcX27zQ0triWHLouyc+tCL03KGu3w1AgUBLI2C+A5qbXsek/75Ba3Q==@vger.kernel.org, AJvYcCU2rCeHX1twiwusdWMChyIKHc+qajlF7ii6VIRNiwocPDbp71aFuiZg2ZtSUaYatuZZmflJ2wj6emAA6hM7@vger.kernel.org
X-Gm-Message-State: AOJu0YxWG2ulr5uGhVlj5Ogi21fUX59QxqDAVMHNUXqGFAtEbbTGTK77
	osSV6CzF7hPX/STnJHN1Bl/Hj/eHZ1t8UHyUnHoDiMdhgHhArSWt
X-Gm-Gg: ASbGncs+3Twf5ysQeKSM57cW3WvSLAIWnY01tzViAcCwGJVy8wfh8zgE4B2gzkYMySF
	+Pp9cgzRyHMhpjXGz54c/1UDkdIPTjadNw/zAMOk7tIUVFWzfU/sQxrWKre9dkwH5t9qq7eoyft
	rqXAOnMXVWEOzvD6O9MWbTgeM3Kc7wh/aU8+jUvnx6jgN16d7Xm0xPbr47pTpqHGCrWpHsrKkzi
	3TUhDtcc5CvA71eXtfmWE6mGx87HEIT4wQWNU4nabL+hyuQi2iHiTHZlNL9ZoXdbcRr1mgTrSBO
	j+eM/Qwk4T1USMWCj54kztWq2xY4CbNeH8wC
X-Google-Smtp-Source: AGHT+IF+s3ngLQLjDmaCQZkfAyv8IFOfnhZlhFOgK13MTqNkfKvCDs5Ab8dNtndxDF3lh5Pz44Y+YQ==
X-Received: by 2002:a05:6000:4012:b0:391:2d61:4561 with SMTP id ffacd0b85a97d-39d07ad4ce7mr4960096f8f.6.1743858200356;
        Sat, 05 Apr 2025 06:03:20 -0700 (PDT)
Received: from parrot ([105.112.71.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301b6321sm6733940f8f.44.2025.04.05.06.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 06:03:19 -0700 (PDT)
From: Richard Akintola <princerichard17a@gmail.com>
To: outreachy@lists.linux.dev
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Akintola <princerichard17a@gmail.com>
Subject: [PATCH 0/8] staging: sm750fb: change function naming style
Date: Sat,  5 Apr 2025 14:00:51 +0100
Message-Id: <cover.1743857160.git.princerichard17a@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Address checkpatch's "Avoid camelCase" for sm750fb module by changing
function name to conform to kernel code style.

The patches are required to be applied in sequence.

Richard Akintola (8):
  staging: sm750fb: change sii164GetDeviceID to snake_case
  staging: sm750fb: change sii164ResetChip to snake_case
  staging: sm750fb: change sii164SetPower to snake_case
  staging: sm750fb: change sii164GetChipString to snake_case
  staging: sm750fb: change sii164EnableHotPlugDetection to snake_case
  staging: sm750fb: change sii164IsConnected to snake_case
  staging: sm750fb: change sii164CheckInterrupt to snake_case
  staging: sm750fb: change sii164ClearInterrupt to snake_case

 drivers/staging/sm750fb/ddk750_dvi.c    | 16 +++++-----
 drivers/staging/sm750fb/ddk750_sii164.c | 42 ++++++++++++-------------
 drivers/staging/sm750fb/ddk750_sii164.h | 16 +++++-----
 3 files changed, 37 insertions(+), 37 deletions(-)

-- 
2.39.5

