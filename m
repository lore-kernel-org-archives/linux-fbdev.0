Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A438D3939C2
	for <linux-fbdev@vger.kernel.org>; Sat, 25 Jul 2026 09:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784970490; cv=none; b=ZRTii/c2P+UYo7o7FQJ/VMI7LsWwZylOjYM70Y3KO6bAc//KHUDz7ItWkLawZOPuetJwyI29xwy/5/Wzqoic4urnh3Dm4amp0gaAazBNlkaNIIVqJPq2fkIxtFvrORpu4my3ChklVBgHyDTv51e2wuwCYHmWfvaJG5BYfIQJTY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784970490; c=relaxed/simple;
	bh=b3Ei4yDhu8+sN+KMXTgoN3098ykJfdvBBKAFJJD6oBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VrQiDljQlNC0spIeopYh9TmQUOn+Wrn5L8Ot1NRBNkbjYCj/liF4sxU7r5dMbPtwl9qkoaGbbKpJLlvVBMoawBEhKPXIq9Nnrtlhh7Xyg25zWzhHk3UbTZw5gEIyqn4wCL64iXKrqtpOiVfkg/MjOEzlzRh0ZFNhEOIYLAdRjf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qefM63Mw; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qefM63Mw"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ceab75934dso15144995ad.2
        for <linux-fbdev@vger.kernel.org>; Sat, 25 Jul 2026 02:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784970488; x=1785575288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=27qNVhnhLo9MI5/hCuxgWLqJ/cIFuufs4pSj1XJHea0=;
        b=qefM63MwPQLhmql2wyv8xUNkYdBBobxelb0mWTw6/YGIsX6kNt7uMxdoHomt2SE6QL
         o7/Ahcm6WnRpV3EVBg6puwVOs9kB8YuUxz/J/w900byJYTconH4Jwp+I5ouzd0b5IGnu
         bOv14hpzFr9/rCeTpGQZIbgVlFbJXUktbmU1Pcys9S6ESCVJdf/rZQ7x6WOAckF+3bE4
         CsXMcfeBj1yWK9bSoaGQFmGJyIPclfLgrPiGjWLCfY2NKXxA5WALLz5lKkRBqi8s3pO4
         yyhku4rCF/9JrWNoZe2FiYMa83KdCGQ4bQCazTgAOOKUNcalUr2HlaOZ57MzYJ6FTGdw
         aVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784970488; x=1785575288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=27qNVhnhLo9MI5/hCuxgWLqJ/cIFuufs4pSj1XJHea0=;
        b=gjcmvTVJMYyXXRw/C1zyyzKx8wPUubnWZYSWJujbDn0q25MRfacGj3ep/Cx6GavE8L
         Cj5GcVvJ71zppghCndJ2XpNW6/5X251m/Hguz0iHuUKahry+Ew0jUzba1t37OIl5y3hi
         TsaKPDL4CH+v67E/hN0mq1R9y/gkATH/9UxJhf2DxMOZUoFIWjQ0i+bTtJyrEWMOlLeS
         jklXQVOUfBaccY5nujE8Udka4PqAbSB+wKE6dKhkqYfaEYVjikMa+wC3vM9Xjx9UOscM
         8gPfD/h3m2x8yPkQ6sob0RU1KJp62hI/KvSuvPK+bYrXfklBUeFGUhSsQaVSX8ar5MLN
         n5og==
X-Gm-Message-State: AOJu0YwlHEAiv6fL5s4Wd/eln0xGw44NXpra0GXuBIDxSKG+J+u28kGS
	X7yu7XnBJDnzv0SnWwipUajlHJEVNDiMhU1Bf8S1f0sGqrPG8JX1DXkY
X-Gm-Gg: AR+sD136c+0n5G/MHI7qSY0Gy3eSXUSuFK3S2Zs2jJShtPUbhWEzN3EbkqTBEj/bri6
	funuAbygUSrmzqH6FQcrQ+tpx++fMlM3S/O/gQcNhiD5bhe2cOgVYD/pS8R0AGEETiELwwoGhR3
	bL3OW2Fyl1lCRktng5Z2VNiS7iIeUqemNhMkpT5ml4TFYFJqP+GUYYxHDhTNAHCqepV8MPT7ree
	mIrzZ2boEkhzg5BuyneoFERpB1LC6uBwE0o4dAtSn1w3nn134Z2EWAJinLkLd8TNabcO3gBzXGt
	iFewphFUeh1yz0zAjOdKuimTDIADKAVEaDF+mUNkMHIjaqTQToNwi2C8H2/TG1SGCptO6MlYVQe
	dGunmG78jQTInw/6M1oRa97tpbnNBl26ePk6mgsc7lGxRuMa4P8emb4zQ0ZhTKI0NLw5ez/CqKz
	/Ztw==
X-Received: by 2002:a17:903:2385:b0:2be:3850:297e with SMTP id d9443c01a7336-2cfde866c11mr17308675ad.31.1784970487875;
        Sat, 25 Jul 2026 02:08:07 -0700 (PDT)
Received: from PC.. ([103.172.209.188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc447f6bsm9198169eec.12.2026.07.25.02.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 02:08:07 -0700 (PDT)
From: Mohit Mishra <mishraloopmohit@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Mohit Mishra <mishraloopmohit@gmail.com>
Subject: [PATCH v2 1/2] staging: sm750fb: Remove dead VALIDATION_CHIP preprocessor blocks
Date: Sat, 25 Jul 2026 14:37:48 +0530
Message-ID: <20260725090750.113598-1-mishraloopmohit@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macro VALIDATION_CHIP is not defined anywhere in the kernel source
tree. Hence, '#ifdef VALIDATION_CHIP' blocks are dead code, and '#ifndef
VALIDATION_CHIP' blocks are always active.

Remove the dead conditional blocks, keeping only the active paths, and
clean up the unused macro definitions.

This addresses the first task in the drivers/staging/sm750fb/TODO list:
"- refine the code and remove unused code".

Signed-off-by: Mohit Mishra <mishraloopmohit@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c  |  4 --
 drivers/staging/sm750fb/ddk750_power.c | 11 +----
 drivers/staging/sm750fb/ddk750_reg.h   | 60 ++++++--------------------
 3 files changed, 14 insertions(+), 61 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index aa78d0bc1d87..1b3d1467ddf0 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -360,9 +360,7 @@ unsigned int sm750_calc_pll_value(unsigned int request_orig,
 
 unsigned int sm750_format_pll_reg(struct pll_value *p_PLL)
 {
-#ifndef VALIDATION_CHIP
 	unsigned int POD = p_PLL->POD;
-#endif
 	unsigned int OD = p_PLL->OD;
 	unsigned int M = p_PLL->M;
 	unsigned int N = p_PLL->N;
@@ -374,9 +372,7 @@ unsigned int sm750_format_pll_reg(struct pll_value *p_PLL)
 	 * applied to any PLL in the calling function.
 	 */
 	return PLL_CTRL_POWER |
-#ifndef VALIDATION_CHIP
 		((POD << PLL_CTRL_POD_SHIFT) & PLL_CTRL_POD_MASK) |
-#endif
 		((OD << PLL_CTRL_OD_SHIFT) & PLL_CTRL_OD_MASK) |
 		((N << PLL_CTRL_N_SHIFT) & PLL_CTRL_N_MASK) |
 		((M << PLL_CTRL_M_SHIFT) & PLL_CTRL_M_MASK);
diff --git a/drivers/staging/sm750fb/ddk750_power.c b/drivers/staging/sm750fb/ddk750_power.c
index eaba3bc2e01a..36fde3bcf1b7 100644
--- a/drivers/staging/sm750fb/ddk750_power.c
+++ b/drivers/staging/sm750fb/ddk750_power.c
@@ -56,17 +56,10 @@ void sm750_set_power_mode(unsigned int mode)
 	}
 
 	/* Set up other fields in Power Control Register */
-	if (mode == POWER_MODE_CTRL_MODE_SLEEP) {
+	if (mode == POWER_MODE_CTRL_MODE_SLEEP)
 		ctrl &= ~POWER_MODE_CTRL_OSC_INPUT;
-#ifdef VALIDATION_CHIP
-		ctrl &= ~POWER_MODE_CTRL_336CLK;
-#endif
-	} else {
+	else
 		ctrl |= POWER_MODE_CTRL_OSC_INPUT;
-#ifdef VALIDATION_CHIP
-		ctrl |= POWER_MODE_CTRL_336CLK;
-#endif
-	}
 
 	/* Program new power mode. */
 	poke32(POWER_MODE_CTRL, ctrl);
diff --git a/drivers/staging/sm750fb/ddk750_reg.h b/drivers/staging/sm750fb/ddk750_reg.h
index fe412ead72e5..e49fd369b2ac 100644
--- a/drivers/staging/sm750fb/ddk750_reg.h
+++ b/drivers/staging/sm750fb/ddk750_reg.h
@@ -294,29 +294,15 @@
 
 #define CURRENT_GATE                                  0x000040
 #define CURRENT_GATE_MCLK_MASK                        (0x3 << 14)
-#ifdef VALIDATION_CHIP
-    #define CURRENT_GATE_MCLK_112MHZ                  (0x0 << 14)
-    #define CURRENT_GATE_MCLK_84MHZ                   (0x1 << 14)
-    #define CURRENT_GATE_MCLK_56MHZ                   (0x2 << 14)
-    #define CURRENT_GATE_MCLK_42MHZ                   (0x3 << 14)
-#else
-    #define CURRENT_GATE_MCLK_DIV_3                   (0x0 << 14)
-    #define CURRENT_GATE_MCLK_DIV_4                   (0x1 << 14)
-    #define CURRENT_GATE_MCLK_DIV_6                   (0x2 << 14)
-    #define CURRENT_GATE_MCLK_DIV_8                   (0x3 << 14)
-#endif
+#define CURRENT_GATE_MCLK_DIV_3                       (0x0 << 14)
+#define CURRENT_GATE_MCLK_DIV_4                       (0x1 << 14)
+#define CURRENT_GATE_MCLK_DIV_6                       (0x2 << 14)
+#define CURRENT_GATE_MCLK_DIV_8                       (0x3 << 14)
 #define CURRENT_GATE_M2XCLK_MASK                      (0x3 << 12)
-#ifdef VALIDATION_CHIP
-    #define CURRENT_GATE_M2XCLK_336MHZ                (0x0 << 12)
-    #define CURRENT_GATE_M2XCLK_168MHZ                (0x1 << 12)
-    #define CURRENT_GATE_M2XCLK_112MHZ                (0x2 << 12)
-    #define CURRENT_GATE_M2XCLK_84MHZ                 (0x3 << 12)
-#else
-    #define CURRENT_GATE_M2XCLK_DIV_1                 (0x0 << 12)
-    #define CURRENT_GATE_M2XCLK_DIV_2                 (0x1 << 12)
-    #define CURRENT_GATE_M2XCLK_DIV_3                 (0x2 << 12)
-    #define CURRENT_GATE_M2XCLK_DIV_4                 (0x3 << 12)
-#endif
+#define CURRENT_GATE_M2XCLK_DIV_1                     (0x0 << 12)
+#define CURRENT_GATE_M2XCLK_DIV_2                     (0x1 << 12)
+#define CURRENT_GATE_M2XCLK_DIV_3                     (0x2 << 12)
+#define CURRENT_GATE_M2XCLK_DIV_4                     (0x3 << 12)
 #define CURRENT_GATE_VGA                              BIT(10)
 #define CURRENT_GATE_PWM                              BIT(9)
 #define CURRENT_GATE_I2C                              BIT(8)
@@ -376,9 +362,6 @@
 #define MODE1_GATE_DMA                                BIT(0)
 
 #define POWER_MODE_CTRL                               0x00004C
-#ifdef VALIDATION_CHIP
-    #define POWER_MODE_CTRL_336CLK                    BIT(4)
-#endif
 #define POWER_MODE_CTRL_OSC_INPUT                     BIT(3)
 #define POWER_MODE_CTRL_ACPI                          BIT(2)
 #define POWER_MODE_CTRL_MODE_MASK                     (0x3 << 0)
@@ -400,15 +383,10 @@
 #define PLL_CTRL_BYPASS                               BIT(18)
 #define PLL_CTRL_POWER                                BIT(17)
 #define PLL_CTRL_INPUT                                BIT(16)
-#ifdef VALIDATION_CHIP
-    #define PLL_CTRL_OD_SHIFT                         14
-    #define PLL_CTRL_OD_MASK                          (0x3 << 14)
-#else
-    #define PLL_CTRL_POD_SHIFT                        14
-    #define PLL_CTRL_POD_MASK                         (0x3 << 14)
-    #define PLL_CTRL_OD_SHIFT                         12
-    #define PLL_CTRL_OD_MASK                          (0x3 << 12)
-#endif
+#define PLL_CTRL_POD_SHIFT                        14
+#define PLL_CTRL_POD_MASK                         (0x3 << 14)
+#define PLL_CTRL_OD_SHIFT                         12
+#define PLL_CTRL_OD_MASK                          (0x3 << 12)
 #define PLL_CTRL_N_SHIFT                              8
 #define PLL_CTRL_N_MASK                               (0xf << 8)
 #define PLL_CTRL_M_SHIFT                              0
@@ -422,8 +400,6 @@
 
 #define SCRATCH_DATA                                  0x00006c
 
-#ifndef VALIDATION_CHIP
-
 #define MXCLK_PLL_CTRL                                0x000070
 
 #define VGA_CONFIGURATION                             0x000088
@@ -431,8 +407,6 @@
 #define VGA_CONFIGURATION_PLL                         BIT(2)
 #define VGA_CONFIGURATION_MODE                        BIT(1)
 
-#endif
-
 #define GPIO_DATA                                       0x010000
 #define GPIO_DATA_31                                    BIT(31)
 #define GPIO_DATA_30                                    BIT(30)
@@ -1020,9 +994,7 @@
 #define CRT_DISPLAY_CTRL_CRTSELECT                    BIT(25)
 #define CRT_DISPLAY_CTRL_RGBBIT                       BIT(24)
 
-#ifndef VALIDATION_CHIP
     #define CRT_DISPLAY_CTRL_CENTERING                BIT(24)
-#endif
 #define CRT_DISPLAY_CTRL_LOCK_TIMING                  BIT(23)
 #define CRT_DISPLAY_CTRL_EXPANSION                    BIT(22)
 #define CRT_DISPLAY_CTRL_VERTICAL_MODE                BIT(21)
@@ -1121,22 +1093,17 @@
 
 /* This vertical expansion below start at 0x080240 ~ 0x080264 */
 #define CRT_VERTICAL_EXPANSION                        0x080240
-#ifndef VALIDATION_CHIP
     #define CRT_VERTICAL_CENTERING_VALUE_MASK         (0xff << 24)
-#endif
 #define CRT_VERTICAL_EXPANSION_COMPARE_VALUE_MASK     (0xff << 16)
 #define CRT_VERTICAL_EXPANSION_LINE_BUFFER_MASK       (0xf << 12)
 #define CRT_VERTICAL_EXPANSION_SCALE_FACTOR_MASK      0xfff
 
 /* This horizontal expansion below start at 0x080268 ~ 0x08027C */
 #define CRT_HORIZONTAL_EXPANSION                      0x080268
-#ifndef VALIDATION_CHIP
     #define CRT_HORIZONTAL_CENTERING_VALUE_MASK       (0xff << 24)
-#endif
 #define CRT_HORIZONTAL_EXPANSION_COMPARE_VALUE_MASK   (0xff << 16)
 #define CRT_HORIZONTAL_EXPANSION_SCALE_FACTOR_MASK    0xfff
 
-#ifndef VALIDATION_CHIP
     /* Auto Centering */
     #define CRT_AUTO_CENTERING_TL                     0x080280
     #define CRT_AUTO_CENTERING_TL_TOP_MASK            (0x7ff << 16)
@@ -1146,7 +1113,6 @@
     #define CRT_AUTO_CENTERING_BR_BOTTOM_MASK         (0x7ff << 16)
     #define CRT_AUTO_CENTERING_BR_BOTTOM_SHIFT        16
     #define CRT_AUTO_CENTERING_BR_RIGHT_MASK          0x7ff
-#endif
 
 /* sm750le new register to control panel output */
 #define DISPLAY_CONTROL_750LE			      0x80288
@@ -1326,9 +1292,7 @@
 #define ZV0_CAPTURE_BUF1_ADDRESS_ADDRESS_MASK           0x3ffffff
 
 #define ZV0_CAPTURE_BUF_OFFSET                          0x090014
-#ifndef VALIDATION_CHIP
     #define ZV0_CAPTURE_BUF_OFFSET_YCLIP_ODD_FIELD      (0x3ff << 16)
-#endif
 #define ZV0_CAPTURE_BUF_OFFSET_OFFSET_MASK              0xffff
 
 #define ZV0_CAPTURE_FIFO_CTRL                           0x090018
-- 
2.43.0

