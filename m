Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7013A194AE6
	for <linux-fbdev@vger.kernel.org>; Sat, 25 Jul 2026 08:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784969240; cv=none; b=DX7LWumKOQ+I0094b9A+Qfxz60fJay7ml3BS9JCawPpJJ2yUFvE6yKaxqN0zWtKFJHRJWfcTQmotFfFlbYFDAEJVecBZUbPWZqPDEDQeyLaqZCHXlkKDA1NkGAiDUkPgRzqVIsRV1Mdqa8rIcoymGm14wXTNrInXY4KZYeu0EN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784969240; c=relaxed/simple;
	bh=87uE3+1MWKBH30S/pn6Z+e0Vh4c1f7Hn2MtsmKT9k/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BSmpzv7JA4zlJ7HIzs+YjFpho8myyJealEvHets9H+rFlIqwIDLoTsrkB1bqWtQcnkHUFEcYTbjecTZxqRPYxvPllSLU81vQYql6uPIkm5CbEWRdLeYWitVbZabXgHUW4gYwQetZFFCiBwbxXjoXU77SFNEB3XB77UWxaA6E9gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbIEM2Pq; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbIEM2Pq"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-ca80d708489so824889a12.1
        for <linux-fbdev@vger.kernel.org>; Sat, 25 Jul 2026 01:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784969238; x=1785574038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KmO9DP/Mwr2vrVuJ6JkOJCszunxgIku+lVRBnkJid0k=;
        b=NbIEM2PqlDhaJ88S0vMCWwzpzv8X7LdRVD0+oDir7aF/hwdIVpKSOcOMO/vuHEQHC+
         B7qt8rhMgZax8fDtUneiHb8urctLsgUTs8rBM1ITV3KlFoEVNV05LPGx1mzSHSF7ILuA
         5Be3wajwX3isjG6QHNdqV1H0k0CfFqKwJFx4DNzQM6OKVueJ48joMViHZ2rbQiA5WR7y
         ovEJ6mZP1FD5hTv0LBRfL8OuNzlC5YTRBDTBhkVkDYDku/XXLxw6P6AMrhOUB0RuVy6x
         h1B5LOl5/Fvt0qPK90yrhUNw+yjtkRlt8aNYMTwWY+iXbj1l6g+GcMPzlK14nvEo0eBK
         kQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784969238; x=1785574038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KmO9DP/Mwr2vrVuJ6JkOJCszunxgIku+lVRBnkJid0k=;
        b=Q2orxs4w2j9GZji4Rsjp1lAaV5/lEJwCkhNVGzWONasysMBePlhk89+5T7QOOlm4hl
         kCYwAx3xHq/Bpw9SUXmM9rXWtYXcVRFu21ef+Pxm2fARn4Mymbr6jlT7aN91QyS0nllR
         R0vdAwry272hnJWCRD6puCPpKILeUaDe5Be7D9l2Q73HaeH3+eoGDaktVYjR4IX82k0y
         V3ubDVoG6sCNmRW0AWHDr3godHT00AZoZMFWoXzgiSwNbF5681HNgfziZ5FJfVbqq0mh
         R7xIPsrT7OuN9eHJq1upr6sQIznQqhI6HTKh1MyGXLAVWr8/ZHamZr2j6JZ5Moh4JUVa
         q+Kg==
X-Gm-Message-State: AOJu0YyOaRGIR2AdQ6kP+IMoaJCclTsie+xx7y6N9WKzo+ywYcQFlQJ/
	4WifrrdwSB4+nCzVwPCymAveWcoglGJ4r495kGyl/J9xj5tPfJECPoJZ+H/2HoYo
X-Gm-Gg: AR+sD13enajCDzDUBBIUwIS8vwVK4Ev6Jz4wC90VpL3h4odvM8LTuUBIjGqJLB3auMe
	j+Lqg55+jH0DM7jaTQqcZd4d8rxMaMwbPuNco6QcOIG35evqG8zKTBrmb0yHBQr9RBqqanwuLOD
	yZ7L9dFfmUG8BYE9kfHEDpWZQBJ/pA/aB5trv5SEe+K32aNBPS7ITlJDIO1YLCn1CZXctSxPXgV
	csytr6GSAaKNpUVdtcGYj+ePwwBX5iTwYg6RVrIwCe6g0lzrHJAkU/3m1UacghRoltatpR5PNw8
	BvQ4fDZz5iwB+15UVGMXZQJUbbPQN2KsTWbqP9ZqI5VCeH6I9sHW6I6enxL7KIzxDrXlDbH01QH
	ZVqTb9GVAJl32V17YAoazrEsfNzpicFjF69/fQ+yTV7UIyWq4idFt9QtOg1Cu3jfsFNarclS92l
	jDIu+00o72cRO3
X-Received: by 2002:a05:6a21:4e01:b0:3b4:6af4:bdd5 with SMTP id adf61e73a8af0-3c67240d4c1mr3448262637.15.1784969237695;
        Sat, 25 Jul 2026 01:47:17 -0700 (PDT)
Received: from PC.. ([103.172.209.188])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d6ba579c3sm6232352c88.8.2026.07.25.01.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 01:47:17 -0700 (PDT)
From: Mohit Mishra <mishraloopmohit@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Mohit Mishra <mishraloopmohit@gmail.com>
Subject: [PATCH 1/2] staging: sm750fb: Remove dead VALIDATION_CHIP preprocessor blocks
Date: Sat, 25 Jul 2026 14:16:48 +0530
Message-ID: <20260725084649.106589-1-mishraloopmohit@gmail.com>
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
 drivers/staging/sm750fb/ddk750_power.c |  6 ---
 drivers/staging/sm750fb/ddk750_reg.h   | 60 ++++++--------------------
 3 files changed, 12 insertions(+), 58 deletions(-)

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
index eaba3bc2e01a..d617f554f58d 100644
--- a/drivers/staging/sm750fb/ddk750_power.c
+++ b/drivers/staging/sm750fb/ddk750_power.c
@@ -58,14 +58,8 @@ void sm750_set_power_mode(unsigned int mode)
 	/* Set up other fields in Power Control Register */
 	if (mode == POWER_MODE_CTRL_MODE_SLEEP) {
 		ctrl &= ~POWER_MODE_CTRL_OSC_INPUT;
-#ifdef VALIDATION_CHIP
-		ctrl &= ~POWER_MODE_CTRL_336CLK;
-#endif
 	} else {
 		ctrl |= POWER_MODE_CTRL_OSC_INPUT;
-#ifdef VALIDATION_CHIP
-		ctrl |= POWER_MODE_CTRL_336CLK;
-#endif
 	}
 
 	/* Program new power mode. */
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

