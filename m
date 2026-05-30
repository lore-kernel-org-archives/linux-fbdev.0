Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2284F279DC9
	for <linux-fbdev@vger.kernel.org>; Sat, 30 May 2026 22:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780179904; cv=none; b=E7Ccggn/R1pxzL/eA1JjjoT831Wv2P8sjnNt4ddsqdM/K19AKezIxMRqHK1pdP2NYAR0kZRS0oat9J0rfyv1PS2DPP5INOcFSNnHtF2V6VSwvH2gmCM+Wa0a5bSIxxkVkzJM5Rdg4KUtOT41sAK3ntZskhvRKWg6v0pYf+9V+Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780179904; c=relaxed/simple;
	bh=irRS0E0WNpV0JJa4KmvA6GS2V1l8IcIewGxGelaGXw4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m1ECFvI49KLhpku/jcHiYEBD5y4wHuKbS/EGZjddhuRVt6NWtcb8gSWBx4q6Ad/MWfMdoGlMV35VhRdvfcHtXJ/YsuzNbIAlWYQuQDnOA/iLq8e0w5gawmoKMoKrBtG+nkWxRj5OBS3XnY9sMaRuEchenUTi8sVE0WgqTSN1OD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=km8kRd9O; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="km8kRd9O"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-137dd51129bso530066c88.1
        for <linux-fbdev@vger.kernel.org>; Sat, 30 May 2026 15:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780179902; x=1780784702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=16XrvrNvVvEtWVpkr/gib/lTKnAIl2lm3W0ZrZwaDCw=;
        b=km8kRd9OLonpLT8KQl8BLQpAJ4riXvpO58f+LSPunObBas+lO/7StyoEiJlMy6k5A4
         Vc5eqFjM3trX7U9AG8PD0VsPRtuuwrzUv0BBiqGBoU8bZV0mwYU5X/k8p+pXW/lPdb6s
         CRkcUtbPNd42SkK9Zk+z/yxdyPNOW77/ayIY2c3196UqUsi8R1Xp85tp3TVGk/w7dmvt
         9CtcYsf3cuEFm5KoduEDDwiNG/nl1Grqw+DR5GPkGiZcM8AkJC0c3DqqI0ziF1M377Ix
         RpP0I2IhqKjWKj0ChPR6rQw1HNst9D+kjzF/4r+aa+QgGOV3QCyUgQMrc9fJE9VLD3Yz
         P1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780179902; x=1780784702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16XrvrNvVvEtWVpkr/gib/lTKnAIl2lm3W0ZrZwaDCw=;
        b=sNnXVa3nKkewBukZhbwxRqlobPey/RpSYiYfnbrgRLceDv2khszE9b2A5bGit54Rhs
         /2zqkWVnN+Zm1t4bXls56arWDDDxBvNxOhINetzHNDqZdJ1Oull7MZCrKGO2+gsiDyHK
         BFUiEGo2XmWzMvtauGSD65gxwhnBzWmfRmtd0hEcJrnFbPllBamQjrBmLm59mo9p1r+4
         Xxll/Ud77NUjylvT56sb5FLQK7ZTX7THn6SUs+FLylmaJQLDw063rSVhcFRbfbDVVcty
         2rRshX/G2MauqHnoLo1SpPFfgfeaxDxamMIlrYlV+w+lxqFgku0wONP37nurl8SM471S
         DHSw==
X-Forwarded-Encrypted: i=1; AFNElJ8KEuNvPjMB2nA1eyDvPJVy6YWjAXaKLvNFA1vyyT1FByI7fGkycAfRO1C4Ug2byXveGw7nYc3z2t9gqw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1beSgMLWM5Eegz1DZ6RFAZBpc7O7B/rESBpd2M8V6BaU7cmWV
	RtZT+sL9fnNkvDpxmkDPRblUBinTi6+BogtsYm/CUj50G2SI0jc7L1fC
X-Gm-Gg: Acq92OF9qlnyyppE6XGMyT0LyfvnqggM3EEoe0ZvHrMJv0N/yXbiOUV0ulFOQoDAnRg
	aQ5Yrdu4vSrvIkFajqQDNJ7yuWTYMuI4bE1AW8nAvE7AJt4IzLyaz+ELVGIEpUbcHbHBBw2g/VY
	RVBUpJ7b8Dyby9I9lbNkh6V6VU0ByWzFyL/t2jdmN70AY+oteQMDOAgnKqnenkM9Wms/MkdmDZl
	IYKDPpnd+h13zcjazx5n08f/uh4pBZmQo1Keme0bRlFPvzhQKh4WZnRx829mFAdasrxi23UJoLU
	XHVxWLxR5eL2ufDLQKRFbSi/EG/LNg9E7vgJH7jEW4/qWjsmsnFZyxXrjEEJWTGpXOt3xmNr85G
	ypFFlzVrF6qmJgnIN7AclOQO2rk6/MZDq854m2LLAoxp3f62Ke+tC0rgkFlfHsysY4TZZbAFZkE
	rDUOYXSRzShT0aVo1gj2vkcbz5G3LBjQ+ANCoegO4o4Io3Rotqz5r9c34Vu6kg8S1blQ==
X-Received: by 2002:a05:7022:11f:b0:134:d708:1a24 with SMTP id a92af1059eb24-137d412366amr2418768c88.17.1780179902065;
        Sat, 30 May 2026 15:25:02 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b3d8f839sm3558661c88.15.2026.05.30.15.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 15:25:01 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	error27@gmail.com,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] staging: sm750fb: remove duplicate init_status structure
Date: Sat, 30 May 2026 22:24:32 +0000
Message-Id: <20260530222432.4303-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct init_status duplicates struct initchip_param and is only used
within the sm750fb driver.

Replace the remaining users of struct init_status with
struct initchip_param, remove the duplicate structure and eliminate
the unnecessary cast in hw_sm750_inithw().

No functional change intended.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/staging/sm750fb/sm750.c    |  8 ++++----
 drivers/staging/sm750fb/sm750.h    | 12 ++----------
 drivers/staging/sm750fb/sm750_hw.c | 16 ++++++++--------
 3 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 89c811e0806c..5986dbef67c0 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -844,11 +844,11 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 
 	swap = 0;
 
-	sm750_dev->init_parm.chip_clk = 0;
-	sm750_dev->init_parm.mem_clk = 0;
-	sm750_dev->init_parm.master_clk = 0;
+	sm750_dev->init_parm.chip_clock = 0;
+	sm750_dev->init_parm.mem_clock = 0;
+	sm750_dev->init_parm.master_clock = 0;
 	sm750_dev->init_parm.power_mode = 0;
-	sm750_dev->init_parm.setAllEngOff = 0;
+	sm750_dev->init_parm.set_all_eng_off = 0;
 	sm750_dev->init_parm.reset_memory = 1;
 
 	/* defaultly turn g_hwcursor on for both view */
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index d2c522e67f26..81fbf32865c3 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef LYNXDRV_H_
 #define LYNXDRV_H_
+#include "ddk750_chip.h"
 
 #define FB_ACCEL_SMI 0xab
 
@@ -38,15 +39,6 @@ enum sm750_path {
 	sm750_pnc = 3,	/* panel and crt */
 };
 
-struct init_status {
-	ushort power_mode;
-	/* below three clocks are in unit of MHZ*/
-	ushort chip_clk;
-	ushort mem_clk;
-	ushort master_clk;
-	ushort setAllEngOff;
-	ushort reset_memory;
-};
 
 struct lynx_accel {
 	/* base virtual address of DPR registers */
@@ -102,7 +94,7 @@ struct sm750_dev {
 	/* locks*/
 	spinlock_t slock;
 
-	struct init_status init_parm;
+	struct initchip_param init_parm;
 	enum sm750_pnltype pnltype;
 	enum sm750_dataflow dataflow;
 	int nocrt;
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 34a837fb4b64..54c1b241ae6e 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -66,20 +66,20 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 
 int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 {
-	struct init_status *parm;
+	struct initchip_param *parm;
 
 	parm = &sm750_dev->init_parm;
-	if (parm->chip_clk == 0)
-		parm->chip_clk = (sm750_get_chip_type() == SM750LE) ?
+	if (parm->chip_clock == 0)
+		parm->chip_clock = (sm750_get_chip_type() == SM750LE) ?
 					       DEFAULT_SM750LE_CHIP_CLOCK :
 					       DEFAULT_SM750_CHIP_CLOCK;
 
-	if (parm->mem_clk == 0)
-		parm->mem_clk = parm->chip_clk;
-	if (parm->master_clk == 0)
-		parm->master_clk = parm->chip_clk / 3;
+	if (parm->mem_clock == 0)
+		parm->mem_clock = parm->chip_clock;
+	if (parm->master_clock == 0)
+		parm->master_clock = parm->chip_clock / 3;
 
-	ddk750_init_hw((struct initchip_param *)&sm750_dev->init_parm);
+	ddk750_init_hw(&sm750_dev->init_parm);
 	/* for sm718, open pci burst */
 	if (sm750_dev->devid == 0x718) {
 		poke32(SYSTEM_CTRL,
-- 
2.34.1

