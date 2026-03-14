Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FE731F986
	for <linux-fbdev@vger.kernel.org>; Sat, 14 Mar 2026 08:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773475791; cv=none; b=jDMDtpUab0tKNYw7wbrZVZ+vT2Bnh1C2kzuIAd+rPVPeOznFBS5CMmr2B2B+snDgh23igbydlw2yZmehc4N+24RA9G+O4dkUQIg97esgsWIa+Gl4F19jRKL5/bVrImp4litpD0KJrmV9X6rlZqX5YSvzMcg2PG1ZjmDMhj5ruz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773475791; c=relaxed/simple;
	bh=Qi1liB3/1EEqA+PyFSxv7Q8niNIJ2IjrvWqcGIQIK1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qopyjkS8q8nPx3hABaoKodYlhxBktJIbM/XpwKnw/290AVCcejX3uBfCW86DoOvNCNicvgF6xsVnou/frm0ZdFaP7gnCfoYsDZLH/N7pqWn2PjkgnazcbtFDwxYscAD8iA+ECaf6nw2Hhs1Zi9Ltx+UTAt9FWaFJW8khgpv7Vd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGYegrln; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGYegrln"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c2af7d09533so2308736a12.1
        for <linux-fbdev@vger.kernel.org>; Sat, 14 Mar 2026 01:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773475789; x=1774080589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xu7XjT6nGlxUJnW6WxPujTa3lgtVgoP7cgfnRGuX1Lc=;
        b=nGYegrlngAJYqGeHEnox1uH1lelv/rqw2c4wKerq3gP3h9FNiM5krVWmhye7p3yeFP
         bSXdfexD0CgGG5oKCDCuVl1WegctQbMakQCoL2fRG3KPeiwpxMM1NOZ8aVn6mXMImARn
         ITu+weCWxRWwB0HEfTtt8RHCCz/MA9X/Yb+cLSiSVUWGlfWTGPxF/fnK2ddMMC3LXcOQ
         TwryZtvGfwLScakKwLYlKp5yxn9z9vYXl/++76IJ4uMnR/dgha70mnJkQA3k64TJbptO
         aF52Ew39GXhy+IcCCfUWMIfjeOmijuB70WO99AkLCbPvqG6WGfUacOFE/unUbtnZAl3j
         p7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773475789; x=1774080589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xu7XjT6nGlxUJnW6WxPujTa3lgtVgoP7cgfnRGuX1Lc=;
        b=q2ikMDnQedn/UHldfimw/3VG7/nk3gFEjfxYiD1UN/b7lyZQ4kLBiyIfSXAt3Fm7Ng
         EVifvCylWpxovAwfz9+W5CLztFt+FfzziE6nq8MmJc/ZYxsCdNcV3I7gtx1SXijxuKmB
         mICPyAhtxDdKgFq+DHGPv0tuP8pRR/5ZdKF6KmWmllIg7Kfs+OstH7ntYl1r2lEpAJr9
         HvasGnroey4JQYIKETkUzYGy9eSPj5wK65bra6VmS3UlJhwbdjHvZyPOaZzVnEzJP+bS
         IGIrOyCNhAD1/7K/2AVcbdXk3aONMVeQn4lHJqgO1xg5RoqI7YozXY3LdYXhUDcferGz
         PUag==
X-Forwarded-Encrypted: i=1; AJvYcCWskcuQmO9KxX1DgCmeYaHRZ+ytMkxPLhIsTFca+7x13MgKEQQRMLJrzXjF/jiJo7pTDsALjRtxgWc8qQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YynUC2LMb/wmf+BL77SNIryZj2bVZPgtJDbxkFtSG6tOmS4YmL1
	T3EnV/d7vp+ZBc5/w6Udd9cpdfyFBhtLmbljE6ph3b1BHyooTFpooIz7eCSKctA2W2U=
X-Gm-Gg: ATEYQzxCfFCiDTHOHxNqyX6d/MPTzvhLfzN6YBTV2MhZBAGP3UFaVOMdti0MES9dNk0
	+xe5y3xemhrf8oZRz/4/090NckiKjTdrzJwjvoApLyaGw/BoFAh/pQZZEflYbOBF674gU6O24+P
	XQ5SEKBqwM7ZQIenhloLXUk3uG7fMyx+Bekf5eU175dkc8ts4PHkq3R+oyESBA8n5CH2zmWQKtR
	mWgwspZT65+WxSHi9E7n4KdRw8zRp1463ABF9HcwCNi0gIPdE6ET5txmFPMx7lVmREal+LeCl2V
	YzVnz6ha+X2nIzRQUrHdMrwJJ/RBUCa1LUCnl5Up2MyLDtNDeONhN0aHvGU1eLoroP78/HtRIAb
	mCFpXLEv9wKKGymA40lNiqOcLe2d+dH975X3m16PoHUhA0535WeXfFJ76Tl79bH6GfUTBvi9gud
	Dv7njc5wYV9p0zqDiXaCchbkXTWHJXDeAX
X-Received: by 2002:a05:6a21:7106:b0:398:7946:b70d with SMTP id adf61e73a8af0-398ecd617a1mr5324392637.51.1773475789383;
        Sat, 14 Mar 2026 01:09:49 -0700 (PDT)
Received: from fedora ([2409:40e5:1052:9a56:d0d2:2da5:541:7e3c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73eb9966d9sm3665378a12.11.2026.03.14.01.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 01:09:48 -0700 (PDT)
From: Shubham Chakraborty <chakrabortyshubham66@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Shubham Chakraborty <chakrabortyshubham66@gmail.com>
Subject: [PATCH 1/3] staging: sm750fb: Rename enum sm750_pnltype values to snake_case
Date: Sat, 14 Mar 2026 13:39:30 +0530
Message-ID: <20260314080934.135457-1-chakrabortyshubham66@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch renames the CamelCase enum values in sm750_pnltype to follow the Linux kernel coding style.

Signed-off-by: Shubham Chakraborty <chakrabortyshubham66@gmail.com>
---
 drivers/staging/sm750fb/sm750.c    | 6 +++---
 drivers/staging/sm750fb/sm750.h    | 6 +++---
 drivers/staging/sm750fb/sm750_hw.c | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index dec1f6b88a7d..729c34372a1e 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -942,11 +942,11 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 		} else if (!strncmp(opt, "nocrt", strlen("nocrt"))) {
 			sm750_dev->nocrt = 1;
 		} else if (!strncmp(opt, "36bit", strlen("36bit"))) {
-			sm750_dev->pnltype = sm750_doubleTFT;
+			sm750_dev->pnltype = SM750_DOUBLE_TFT;
 		} else if (!strncmp(opt, "18bit", strlen("18bit"))) {
-			sm750_dev->pnltype = sm750_dualTFT;
+			sm750_dev->pnltype = SM750_DUAL_TFT;
 		} else if (!strncmp(opt, "24bit", strlen("24bit"))) {
-			sm750_dev->pnltype = sm750_24TFT;
+			sm750_dev->pnltype = SM750_24TFT;
 		} else if (!strncmp(opt, "nohwc0", strlen("nohwc0"))) {
 			g_hwcursor &= ~0x1;
 		} else if (!strncmp(opt, "nohwc1", strlen("nohwc1"))) {
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 67b9bfa23f41..49a79d0a8a2e 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -13,9 +13,9 @@
 #endif
 
 enum sm750_pnltype {
-	sm750_24TFT = 0,	/* 24bit tft */
-	sm750_dualTFT = 2,	/* dual 18 bit tft */
-	sm750_doubleTFT = 1,	/* 36 bit double pixel tft */
+	SM750_24TFT = 0,	/* 24bit tft */
+	SM750_DUAL_TFT = 2,	/* dual 18 bit tft */
+	SM750_DOUBLE_TFT = 1,	/* 36 bit double pixel tft */
 };
 
 /* vga channel is not concerned  */
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index a29faee91c78..0e594734a8b9 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -134,12 +134,12 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 		      ~(PANEL_DISPLAY_CTRL_DUAL_DISPLAY |
 			PANEL_DISPLAY_CTRL_DOUBLE_PIXEL);
 		switch (sm750_dev->pnltype) {
-		case sm750_24TFT:
+		case SM750_24TFT:
 			break;
-		case sm750_doubleTFT:
+		case SM750_DOUBLE_TFT:
 			val |= PANEL_DISPLAY_CTRL_DOUBLE_PIXEL;
 			break;
-		case sm750_dualTFT:
+		case SM750_DUAL_TFT:
 			val |= PANEL_DISPLAY_CTRL_DUAL_DISPLAY;
 			break;
 		}
-- 
2.53.0

