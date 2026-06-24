Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606C130C144
	for <linux-fbdev@vger.kernel.org>; Wed, 24 Jun 2026 04:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782275152; cv=none; b=PRK487xMmFuo8ls0Hn7/qkWzv5a1mARfQxpwGMAKcMKnsB464X3dLUtjtzz8LY0Hlp7NMcd+ucf0FTu4cVVYOw+B+kzdQBVS6Tz5TM4JmJ7KSa+Bf9wxUQj959Co0u7IBEYs4P9TVk14mcOBltoiDAPeuXSPPz1kzjMN4e8pmEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782275152; c=relaxed/simple;
	bh=2Mf5YzI9FOUIILwcsDlxPx9GVkUDSpsOMBsA8x6mwQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMeGNsntKdC9C0091z5ks853PjO2NhjBqmEaFo9cGHvpnw8ZkcF/FPM2RbV2qDvTFwz1AiG1mkIYYXIi6nP757fIPI8GYw6rhGr0+sgRiYggQcllXdBSpnFMTd8r4K2mKoXdZWACZxKcCZfTAgrUeVYESa7GySI7aUx6DXB8UsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2n5rur8; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2n5rur8"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c85a2c012e5so220585a12.1
        for <linux-fbdev@vger.kernel.org>; Tue, 23 Jun 2026 21:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782275150; x=1782879950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKeA8pkNSXwNkj1KAdbmazDlkEII0Ozzls/ozBP1lc0=;
        b=i2n5rur8QAMaSRZ2XQJUoxJNetMYeVPgpe6oHtLt+GLDhMzIVmy+XppKaZjXq17esi
         4YyWkoEZNuQjD0phEyAAetZhr5wRFnc4sUqmxgQ16evS2uGhUUTyTjmeoVOwlj49BB2b
         MezdUELEodLadewSY/S0/UtvuX07qVEz32RiJObBiN66jpd/bld3LzkioBJiJZIUiXiH
         9Hj7zeySIeEcbzfPSU5x8IoMyKJtHcaqi6s/WWJVBIQlVdlCTUv5sSYmnAaVwwLRYMQ9
         35sgdrjLevAxo5Hxi0I4Pe/QDWh8ingMpwlsEc36kx2nDybUqy5khbSI26VTVxEDS7Jn
         Ysjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782275150; x=1782879950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wKeA8pkNSXwNkj1KAdbmazDlkEII0Ozzls/ozBP1lc0=;
        b=DLFX+ePtMHGI5n+qdFNc6W3o4NU+HYn0Pg/Z9Wu8ikPigJM08+y8KL6ghYcoJO3GTE
         QZwifrIcrw96zcNqiQ7zrvq+bZvXMTW/qNvYkkVJXmczWkziWiLzcsAfhk+oeWN6fWEX
         kcuI2gE5j+E0AdIPIbjNEELxykYPKQFgkBP/Lvom/pf42d95vpSNmiY+DeNAm+f8Ldvt
         KLG9HMNGaygOChAKl8oxj6BPFUhEndrMXtrd55L8EvTmkfuAI2Ot+nzYfHY3N3z7J8wr
         pDsOsJyco9vQAC2pIeftBX/PlwyZTdbbZs6EX+s2JbNcdSpx93R9f8pW4N6Wud+cnes7
         kquQ==
X-Gm-Message-State: AOJu0YxsEDOJz42VOAMNsO4JibckqbOqcbVQsdpV1D48Ugkiljcf2Iti
	YDREUpxwauEe+ThlXPG5PHmiIJk5O/UUxYPCVfhz5jW/mF2GOTpb9eY+
X-Gm-Gg: AfdE7ck8ol0Y1kj48i2/1IKoESDkZ0suTlwquNiuwDTm1QuHCVEijbnJHifpOcPIpPH
	Jh80CJB+vqnFMqiAPfw0o8UOZkRh12p89Fhes3KUFTe68cAV7N4xP9xEwqgKg5q+s5RKTFZ7XjT
	lBNbAvY1lQGWdbyNUIqfZ7Wj8xyYnX/WChuDh33riYhwqPCaTaFfVfwIeI6/TXz+maRV2mMSdB8
	c4TW3gOOumHkdDAvHt1pfAX697fJOw+F1ljCcU2QitsETgE/ycqre7BQBimw9UCjAwiiKaPaEM4
	ibwOfUiSObazHrb6e9/mqK88qw98VhLVo+nHb8+hTZPfFZxwR/og4VQA8zdzSzkCiBM3t4gpyrb
	f66G+Ksu/mC5Pm5V3bue5KKa6ugCQrzvqfOO/dX9s3x8u+lvJxcLIzlHDqzOpikJC/Y5DJIf+Cv
	Am+neGVz04t0J1t2GkiyZgzP+944RHfWUutSujFCtOqqleaggZFZoWuvpPqvGOq5kdJO98DRibC
	oiUBPIO+az6W6ZBXfw1Q+OMQpmoFXPC7yfY5NFVes1/ua6AsgLhcoUAXQEJLcHHd8Fn
X-Received: by 2002:a05:6a20:a111:b0:3b3:1ee3:2794 with SMTP id adf61e73a8af0-3bc51818e1bmr20766782637.5.1782275150486;
        Tue, 23 Jun 2026 21:25:50 -0700 (PDT)
Received: from kapoor.mahindrauniversity.edu.in ([122.184.65.229])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bc3743bbbsm10889998a12.14.2026.06.23.21.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 21:25:49 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v2] staging: sm750fb: fix remaining CamelCase issues
Date: Wed, 24 Jun 2026 09:55:43 +0530
Message-ID: <20260624042543.38925-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260621045340.65872-1-kapoorarnav43@gmail.com>
References: <20260621045340.65872-1-kapoorarnav43@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the remaining CamelCase variables and constants
to follow kernel coding style.

Rename:

* powerMode -> power_mode
* setAllEngOff -> set_all_eng_off
* resetMemory -> reset_memory
* sm750_doubleTFT -> SM750_DOUBLE_TFT
* sm750_dualTFT -> SM750_DUAL_TFT

Fix build errors by renaming the corresponding
declarations and enum values as well.

Reported-by: kernel test robot [lkp@intel.com](mailto:lkp@intel.com)
Closes: https://lore.kernel.org/oe-kbuild-all/202606240916.wIIrdOzC-lkp@intel.com/
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/staging/sm750fb/sm750.c    | 10 +++++-----
 drivers/staging/sm750fb/sm750.h    | 10 +++++-----
 drivers/staging/sm750fb/sm750_hw.c |  4 ++--
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 9f3e3d37e..858eda551 100644
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
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 67b9bfa23..9da154f1a 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -14,8 +14,8 @@
 
 enum sm750_pnltype {
 	sm750_24TFT = 0,	/* 24bit tft */
-	sm750_dualTFT = 2,	/* dual 18 bit tft */
-	sm750_doubleTFT = 1,	/* 36 bit double pixel tft */
+	SM750_DUAL_TFT = 2,	/* dual 18 bit tft */
+	SM750_DOUBLE_TFT = 1,	/* 36 bit double pixel tft */
 };
 
 /* vga channel is not concerned  */
@@ -39,13 +39,13 @@ enum sm750_path {
 };
 
 struct init_status {
-	ushort powerMode;
+	ushort power_mode;
 	/* below three clocks are in unit of MHZ*/
 	ushort chip_clk;
 	ushort mem_clk;
 	ushort master_clk;
-	ushort setAllEngOff;
-	ushort resetMemory;
+	ushort set_all_eng_off;
+	ushort reset_memory;
 };
 
 struct lynx_accel {
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index a2798d428..59fb3a207 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -130,10 +130,10 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 		switch (sm750_dev->pnltype) {
 		case sm750_24TFT:
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

