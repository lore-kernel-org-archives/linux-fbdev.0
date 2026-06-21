Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE5553E0B
	for <linux-fbdev@vger.kernel.org>; Sun, 21 Jun 2026 04:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782017631; cv=none; b=ZLaUWXEzD91VOr1HYQYp/f6kooLH9KDSE+8Ni7iyDBFTFFbwqjAF9hkL3adR4i4e/VIDErde84ml1CwN2jBxSYUV6Ec+JN3LN6+cpmblxm5XSr5ta6IEGo6FiF05C6G1MuUGMLVVuW0LC4tTBYRIkbeamzGL+DVq+nvu7neTbfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782017631; c=relaxed/simple;
	bh=ysODE48MG38Ze7E7lc6OSDgmmH6AUYqISUF/OUOmkLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a7AH0hfZR35P//349m3R0E9rWTabQufPzlY2zWUbPzHg/OHpO7SBxw4CV49S6/HLMZclbgC0GV7QDToAabj6eTFcaf7nR3QsapQ6Zm6Q/iwTp5G9vbauaPimTf/+PQKlr1HAtrGo6fHyzj22KYP0fLYoSDmmKMyA5Jvj9s6lMnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkI9G8PI; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkI9G8PI"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36babe2c4bdso1720444a91.1
        for <linux-fbdev@vger.kernel.org>; Sat, 20 Jun 2026 21:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782017629; x=1782622429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7G/nkYZdx0E/SLt2rECUHCRRofMdYVLWGsUUXwSGwrk=;
        b=hkI9G8PIevXko3h3BAcKsRww4I+lPKjetanLW4zX+iIQGrm5Fpvpt/cvMg4+3BmaAy
         SbFepdJrAYAHUi11ltR6VxD0muJrrdyPk8eJcOUP7YQZTFY4Fc/Al8cDjS6tGdWMxyTE
         vMbfiEsBp/iY4wi7ecGh9d87LU1cRCoizSL8iRn4hHfvMv8zRdu9sXR0w3+s3EEuIpMA
         6PNZO6wKMpKFPX3TmSiv/inZGATprJCgM3dgeIzOkz4cG7VQXEF82iwQPhxJ2GrLm3Oz
         Xllj1ewrq09RQ3gM/9yVn/WYyVv99Tq7tyq6vDm80Qj6nYGZgerFe39fv41S6nSinq8a
         OkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782017629; x=1782622429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7G/nkYZdx0E/SLt2rECUHCRRofMdYVLWGsUUXwSGwrk=;
        b=dFGZvwXOmvHxEWWbME+MDXPfcEz+b45XOt0G6v63qLWOgv52ZLNXg3c9BdGonVcJoF
         YZnSEP+/NUbW3qnj7Xpxw2TjgKyzgIvl/VoOgVVTP4Avc2BbQb88Qf2y2N9GXPtv434Y
         KlpUZxK5HyagQ9Ol+5O3T95ykTKgrPdZpMLsc89rCZSbcrvVG4KFpMCom+J85bEroAjj
         0VDgb+zr0Lkn9ubV6cs4X4z9Th6JLlw50dNK4ietlPDNgYyHFgsTN/WsH5pN2lTwEkai
         P4+X7wxiF2m14hO24q4aawYCjs4fsWsN/3d9nMViBaroW9PyAgBYOfZ/qxfh+NYN/SdR
         FLUw==
X-Forwarded-Encrypted: i=1; AHgh+RovmWTBtZ1O2LobJZQObkRpQXf2f83ETJTTrLgtJrML8ZD9TBH0LLEjDfNS9kj6g7OmFOLFEffcgfz8NA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5XiA8jlwVjquKKhNHrgov+4+S+862aXgPmFb9h7VGbiRw2OF7
	wHarEUUzqrhm0mENrV2XoeQejELF+7umtRAu01XYxBxCOQ+RQjLKeEfy
X-Gm-Gg: AfdE7cm8PEKbB4QDRJTusmWM8tt+fZ3+ZGsTLmFdz/MQt9cW9pm0onZ/xmhav39MZCt
	Fs28ALNLKTbumraahhdCRIwKC2EE/uXMWCgC4PMh6DB0HqqjQ1ydO0AvZCChTkcpuT3T/bQG1Qg
	rAiQp3WGboSTvtVlelREDkO/HFKJPKY/wHZrF7z9PEdaJl38HSXNVtNLytn4KcAM6t4hHMwwaCL
	f9t7BYZT/6gkOWzdDFFrsHV8Btnn9Q5YKxqhpRrJJ97y/jplFtR0lb5hHHNElml+lH4d7azWRbD
	YgNYwf4H/s/6eWjy+l4V9B31jbhYuOyzFzBi341n2CmSk3ZO0Bu+OVR6MP5cpc3Yr4WPJEncM09
	mR+j/5szbGxQ6xIEM5z1epgRZNFjg2BClbvmddSJ2JFd5NKnb651P97xX8/LziwN2TT6SRpwFVH
	4vQ0x81GHDumyRNgfLqrABACS6d5+xs6pySZZ2gvtOJFoRvsWfciePRyOF72Ej6bex4LqJrw4sW
	4KE0bGZpnmT0KwEGp1V5W6f8/DQM7a/qAWq1bhTxa1iNOd9ZHusMvnWlA==
X-Received: by 2002:a17:902:db0e:b0:2c6:8e82:977c with SMTP id d9443c01a7336-2c718cbdd0bmr100658595ad.15.1782017628373;
        Sat, 20 Jun 2026 21:53:48 -0700 (PDT)
Received: from kapoor.mahindrauniversity.edu.in ([122.184.65.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436f90d4sm36864575ad.34.2026.06.20.21.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 21:53:47 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>
Cc: linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [staging] staging: sm750fb: fix remaining CamelCase issues
Date: Sun, 21 Jun 2026 10:23:40 +0530
Message-ID: <20260621045340.65872-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Rename the remaining CamelCase variables and constants to follow
kernel coding style:
- powerMode → power_mode
- setAllEngOff → set_all_eng_off
- resetMemory → reset_memory
- sm750_doubleTFT → SM750_DOUBLE_TFT
- sm750_dualTFT → SM750_DUAL_TFT

Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 125ad1062..f034d3278 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -859,9 +859,9 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 	sm750_dev->init_parm.chip_clk = 0;
 	sm750_dev->init_parm.mem_clk = 0;
 	sm750_dev->init_parm.master_clk = 0;
-	sm750_dev->init_parm.powerMode = 0;
-	sm750_dev->init_parm.setAllEngOff = 0;
-	sm750_dev->init_parm.resetMemory = 1;
+	sm750_dev->init_parm.power_mode = 0;
+	sm750_dev->init_parm.set_all_eng_off = 0;
+	sm750_dev->init_parm.reset_memory = 1;
 
 	/* defaultly turn g_hwcursor on for both view */
 	g_hwcursor = 3;
@@ -880,9 +880,9 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 		} else if (!strncmp(opt, "nocrt", strlen("nocrt"))) {
 			sm750_dev->nocrt = 1;
 		} else if (!strncmp(opt, "36bit", strlen("36bit"))) {
-			sm750_dev->pnltype = sm750_doubleTFT;
+			sm750_dev->pnltype = SM750_DOUBLE_TFT;
 		} else if (!strncmp(opt, "18bit", strlen("18bit"))) {
-			sm750_dev->pnltype = sm750_dualTFT;
+			sm750_dev->pnltype = SM750_DUAL_TFT;
 		} else if (!strncmp(opt, "24bit", strlen("24bit"))) {
 			sm750_dev->pnltype = sm750_24TFT;
 		} else if (!strncmp(opt, "nohwc0", strlen("nohwc0"))) {
-- 
2.53.0

