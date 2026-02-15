Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1057D2BB13
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 23:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198437; cv=none; b=SXJeJqDd6z202kzXI3sge1z+OiGTgoPXr7fSKDxoOtfSaCTSmiWHSJVgRO/wYTy9E5ALRwby7+8qX4siNutSTdnaFKuy3qo1xaU9UyBuz8fkMRasVVisMSoNbBrXMi4+hsQ/cvWZZWEXWL4jtFBX6r0l5FAnLgzaao5ybDBXDZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198437; c=relaxed/simple;
	bh=9V9FlgwGcdhV6Cdnj72pIF0gK7a9clPzLHlm+LpXO+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZwgJUG/YBKl9GFC2zx3lmMRQ/dPKUoHanyuYWmX3gOHXqOWddZGUYAQc9tFIXqtRa2mey9yrPnkoc+9nMmB3WhKXrVD1Hqk4tT/qVULcaI5/wcLlopRBy3P0ny+LGDAl4dyuOxXUyN6maa5DkBIO1x0RSbqmJOVFU57eIK4ul3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=e1mwS9cu; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="e1mwS9cu"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-436e87589e8so3212385f8f.3
        for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 15:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771198433; x=1771803233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrwVUOM8wMmDxOUA15e1sYZ1kQqfQ5M9yviTDmJhfrE=;
        b=e1mwS9cugQZTIr0HlxjfNhzfFOkD7ztBU+e0i3KlACUpG2r4WwzCKTKXi/KotxKeun
         kGlzfAY09R3O2iXpSep1URJxNP4PotuhS6jmo8fuP6pIS+KjbMd3csUcAn7RlIpbKgrN
         dSWRGAhHhXJJAIS5zvUFbIqYjMPBf8FuTputxUVbZiTV2P4UDYAuAEh3qzLX/SWnYOmr
         zu0l0snuPtxJszhuD3evaIvVFsDAHwbfrnl9mSfqSMNdeHV3nty1U6f1tLEcviQKxAtQ
         R0GfP0MYnMFZn+DMXq0Xyccv0tFRZcJi/Y5fBJQz1FpxenGH56LPSlDHDWJr5z63IBOe
         gSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771198433; x=1771803233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LrwVUOM8wMmDxOUA15e1sYZ1kQqfQ5M9yviTDmJhfrE=;
        b=wsyU2u/ch0ljMjyuTIs/GP8KgMqhl0VG3RNUu80JZfkg4/9biJbN3QodzeeCDf3tSo
         l273EGyz+vnWVK3i6rau0SwFaEP+x7KiuZXdihqXNaMamF/gT5dULjGsRwIBTkyNSPj1
         NkuIcjBdqIN3ovLcc0kiaYdDmHqE2vMwFbDa+lXs4DYBXtvWsfiGRQGwmYHymp5+z4eh
         nvo7+ycYGt/wLPOPct1z2tZvW3kh+P8Mw5HJIiMMbvO7OXivZoaw97LpQNH97oxvCPuH
         stjz7NvWLan3xesSPXwxcZaZCACaf8+9uFeHQDHWPhyENnnB8P+iyqdECC79xiM6mKke
         vSrw==
X-Forwarded-Encrypted: i=1; AJvYcCWMFmppFgY43RVs6Ia3YQfauWX2xMhOdP1gT74RwHoLDHx2mH30UhDoRy0DLDOS1lWienSQ5i5HND+iDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxH3qT33lUpheKqPn99J6s6ToOLKvLVWQFKM6mwi8D24v+mAVVS
	42H6RRrh1huEKJQHTbmyl235y9yndMBlisEHkYRExslx3MnH/bgnZdfmsZxpOlmQgYM=
X-Gm-Gg: AZuq6aL6NooGLjM2WrPGN0OaJoqV8G6VMM1I2of0CG8j25X3GuYb4T8g+NLwvfoOkGs
	vjhv1SnipAfoyK+xkAzV1+E7P0LBpMxyGiItc34KnaV1VjjvFT538Yx0ChzqNQ9MjTlxw8U4M8B
	FRiM2lK/jYNqIlVSxIxBTxGfgZ4w6Aa+KVwR1x5acvAODvHt1/cEDp/A2jnWOGFSWO5cvnL6Sy+
	AfgOkJpECleKJ5P+9+AWl/LjhfTXLa6MiaqODEh4q7+xhrH7cye6ogc3M+3FEyC+IVWTk66Tyzc
	w907Waqqsu2tUU6V1psLKfKjPUt1sJWkixusomW5L+ziYtYqiaNLJqnH10I8gS9Z66GRQtypANc
	Eq/PBWChj+7ehu7bxeBpCA3P4tQaYzAEQxQdr+/wgkakkwsrsxMEz4FSCkjimg9WD7ojZSNDFme
	7lUUgN89Z9Vf04tyJ1NQjcMAQExppk5/YlnUaBDTU=
X-Received: by 2002:a05:6000:4284:b0:436:317b:f3bd with SMTP id ffacd0b85a97d-43797913e41mr16255247f8f.33.1771198433399;
        Sun, 15 Feb 2026 15:33:53 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43796a5acaasm20787309f8f.6.2026.02.15.15.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 15:33:52 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v5 6/7] fbdev: au1100fb: Fold au1100fb.h into its only user
Date: Mon, 16 Feb 2026 00:33:22 +0100
Message-ID: <365b70871f70073a04e22f60be8cc03e29c03946.1771198101.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771198101.git.u.kleine-koenig@baylibre.com>
References: <cover.1771198101.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=29869; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=9V9FlgwGcdhV6Cdnj72pIF0gK7a9clPzLHlm+LpXO+c=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpklfLMOHY3k4tlgQ0pCBOjFegV2wzWGx9vwlNV f1lXVQw61qJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaZJXywAKCRCPgPtYfRL+ TvF0CAC4edCQVcjSgnvkqFjeteKE2cVVhnyxeBwyZbIQwUza1v2hcUR1cZDDiGmiEVhGSiS6GHD EII8GWmNU/UHelxpd+2wCDOBrF6MuClt9CH21qvRu6EQsdjuEUv3fEcHdIuYOyRoB7a30P4Ijwi P5O8cSy7hHkD9Pnw8V9h3pGEYdaVgSkPqTbo6XnUihYTIFV4/muG2cTePJCwaAwuVrxnSKcwBxi IB8INv0eo+snrLETKncgjX6Uqj5muLvE23XRS81EnqkbDTzEy3qGf77lA+AL11OH0IGgbNZGI3g Tczt9+x54frw7ZlteiKThPAwlfdesJgdfr0EdSu5+fgxEL+5
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This gets rid of a header that is only used once. The copyrights and
license specifications are all already covered in the au1100fb.c file.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/video/au1100fb.c       |   0
 drivers/video/fbdev/au1100fb.c | 339 +++++++++++++++++++++++++++++-
 drivers/video/fbdev/au1100fb.h | 372 ---------------------------------
 3 files changed, 338 insertions(+), 373 deletions(-)
 create mode 100644 drivers/video/au1100fb.c
 delete mode 100644 drivers/video/fbdev/au1100fb.h

diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index f589f90cce2c..13605337d724 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -60,7 +60,344 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#include "au1100fb.h"
+#if defined(__BIG_ENDIAN)
+#define LCD_CONTROL_DEFAULT_PO LCD_CONTROL_PO_11
+#else
+#define LCD_CONTROL_DEFAULT_PO LCD_CONTROL_PO_00
+#endif
+#define LCD_CONTROL_DEFAULT_SBPPF LCD_CONTROL_SBPPF_565
+
+/********************************************************************/
+
+/* LCD controller restrictions */
+#define AU1100_LCD_MAX_XRES	800
+#define AU1100_LCD_MAX_YRES	600
+#define AU1100_LCD_MAX_BPP	16
+#define AU1100_LCD_MAX_CLK	48000000
+#define AU1100_LCD_NBR_PALETTE_ENTRIES 256
+
+/* Default number of visible screen buffer to allocate */
+#define AU1100FB_NBR_VIDEO_BUFFERS 4
+
+/********************************************************************/
+
+struct au1100fb_panel
+{
+	const char name[25];		/* Full name <vendor>_<model> */
+
+	u32   	control_base;		/* Mode-independent control values */
+	u32	clkcontrol_base;	/* Panel pixclock preferences */
+
+	u32	horztiming;
+	u32	verttiming;
+
+	u32	xres;		/* Maximum horizontal resolution */
+	u32 	yres;		/* Maximum vertical resolution */
+	u32 	bpp;		/* Maximum depth supported */
+};
+
+struct au1100fb_regs
+{
+	u32  lcd_control;
+	u32  lcd_intstatus;
+	u32  lcd_intenable;
+	u32  lcd_horztiming;
+	u32  lcd_verttiming;
+	u32  lcd_clkcontrol;
+	u32  lcd_dmaaddr0;
+	u32  lcd_dmaaddr1;
+	u32  lcd_words;
+	u32  lcd_pwmdiv;
+	u32  lcd_pwmhi;
+	u32  reserved[(0x0400-0x002C)/4];
+	u32  lcd_palettebase[256];
+};
+
+struct au1100fb_device {
+
+	struct fb_info info;			/* FB driver info record */
+
+	struct au1100fb_panel 	*panel;		/* Panel connected to this device */
+
+	struct au1100fb_regs* 	regs;		/* Registers memory map */
+	size_t       		regs_len;
+	unsigned int 		regs_phys;
+
+#ifdef CONFIG_PM
+	/* stores the register values during suspend */
+	struct au1100fb_regs	pm_regs;
+#endif
+
+	unsigned char* 		fb_mem;		/* FrameBuffer memory map */
+	size_t	      		fb_len;
+	dma_addr_t    		fb_phys;
+	int			panel_idx;
+	struct clk		*lcdclk;
+	struct device		*dev;
+};
+
+/********************************************************************/
+
+#define LCD_CONTROL                (AU1100_LCD_BASE + 0x0)
+  #define LCD_CONTROL_SBB_BIT      21
+  #define LCD_CONTROL_SBB_MASK     (0x3 << LCD_CONTROL_SBB_BIT)
+    #define LCD_CONTROL_SBB_1        (0 << LCD_CONTROL_SBB_BIT)
+    #define LCD_CONTROL_SBB_2        (1 << LCD_CONTROL_SBB_BIT)
+    #define LCD_CONTROL_SBB_3        (2 << LCD_CONTROL_SBB_BIT)
+    #define LCD_CONTROL_SBB_4        (3 << LCD_CONTROL_SBB_BIT)
+  #define LCD_CONTROL_SBPPF_BIT    18
+  #define LCD_CONTROL_SBPPF_MASK   (0x7 << LCD_CONTROL_SBPPF_BIT)
+    #define LCD_CONTROL_SBPPF_655    (0 << LCD_CONTROL_SBPPF_BIT)
+    #define LCD_CONTROL_SBPPF_565    (1 << LCD_CONTROL_SBPPF_BIT)
+    #define LCD_CONTROL_SBPPF_556    (2 << LCD_CONTROL_SBPPF_BIT)
+    #define LCD_CONTROL_SBPPF_1555   (3 << LCD_CONTROL_SBPPF_BIT)
+    #define LCD_CONTROL_SBPPF_5551   (4 << LCD_CONTROL_SBPPF_BIT)
+  #define LCD_CONTROL_WP           (1<<17)
+  #define LCD_CONTROL_WD           (1<<16)
+  #define LCD_CONTROL_C            (1<<15)
+  #define LCD_CONTROL_SM_BIT       13
+  #define LCD_CONTROL_SM_MASK      (0x3 << LCD_CONTROL_SM_BIT)
+    #define LCD_CONTROL_SM_0         (0 << LCD_CONTROL_SM_BIT)
+    #define LCD_CONTROL_SM_90        (1 << LCD_CONTROL_SM_BIT)
+    #define LCD_CONTROL_SM_180       (2 << LCD_CONTROL_SM_BIT)
+    #define LCD_CONTROL_SM_270       (3 << LCD_CONTROL_SM_BIT)
+  #define LCD_CONTROL_DB           (1<<12)
+  #define LCD_CONTROL_CCO          (1<<11)
+  #define LCD_CONTROL_DP           (1<<10)
+  #define LCD_CONTROL_PO_BIT       8
+  #define LCD_CONTROL_PO_MASK      (0x3 << LCD_CONTROL_PO_BIT)
+    #define LCD_CONTROL_PO_00        (0 << LCD_CONTROL_PO_BIT)
+    #define LCD_CONTROL_PO_01        (1 << LCD_CONTROL_PO_BIT)
+    #define LCD_CONTROL_PO_10        (2 << LCD_CONTROL_PO_BIT)
+    #define LCD_CONTROL_PO_11        (3 << LCD_CONTROL_PO_BIT)
+  #define LCD_CONTROL_MPI          (1<<7)
+  #define LCD_CONTROL_PT           (1<<6)
+  #define LCD_CONTROL_PC           (1<<5)
+  #define LCD_CONTROL_BPP_BIT      1
+  #define LCD_CONTROL_BPP_MASK     (0x7 << LCD_CONTROL_BPP_BIT)
+    #define LCD_CONTROL_BPP_1        (0 << LCD_CONTROL_BPP_BIT)
+    #define LCD_CONTROL_BPP_2        (1 << LCD_CONTROL_BPP_BIT)
+    #define LCD_CONTROL_BPP_4        (2 << LCD_CONTROL_BPP_BIT)
+    #define LCD_CONTROL_BPP_8        (3 << LCD_CONTROL_BPP_BIT)
+    #define LCD_CONTROL_BPP_12       (4 << LCD_CONTROL_BPP_BIT)
+    #define LCD_CONTROL_BPP_16       (5 << LCD_CONTROL_BPP_BIT)
+  #define LCD_CONTROL_GO           (1<<0)
+
+#define LCD_INTSTATUS              (AU1100_LCD_BASE + 0x4)
+#define LCD_INTENABLE              (AU1100_LCD_BASE + 0x8)
+  #define LCD_INT_SD               (1<<7)
+  #define LCD_INT_OF               (1<<6)
+  #define LCD_INT_UF               (1<<5)
+  #define LCD_INT_SA               (1<<3)
+  #define LCD_INT_SS               (1<<2)
+  #define LCD_INT_S1               (1<<1)
+  #define LCD_INT_S0               (1<<0)
+
+#define LCD_HORZTIMING             (AU1100_LCD_BASE + 0xC)
+  #define LCD_HORZTIMING_HN2_BIT   24
+  #define LCD_HORZTIMING_HN2_MASK  (0xFF << LCD_HORZTIMING_HN2_BIT)
+  #define LCD_HORZTIMING_HN2_N(N)  ((((N)-1) << LCD_HORZTIMING_HN2_BIT) & LCD_HORZTIMING_HN2_MASK)
+  #define LCD_HORZTIMING_HN1_BIT   16
+  #define LCD_HORZTIMING_HN1_MASK  (0xFF << LCD_HORZTIMING_HN1_BIT)
+  #define LCD_HORZTIMING_HN1_N(N)  ((((N)-1) << LCD_HORZTIMING_HN1_BIT) & LCD_HORZTIMING_HN1_MASK)
+  #define LCD_HORZTIMING_HPW_BIT   10
+  #define LCD_HORZTIMING_HPW_MASK  (0x3F << LCD_HORZTIMING_HPW_BIT)
+  #define LCD_HORZTIMING_HPW_N(N)  ((((N)-1) << LCD_HORZTIMING_HPW_BIT) & LCD_HORZTIMING_HPW_MASK)
+  #define LCD_HORZTIMING_PPL_BIT   0
+  #define LCD_HORZTIMING_PPL_MASK  (0x3FF << LCD_HORZTIMING_PPL_BIT)
+  #define LCD_HORZTIMING_PPL_N(N)  ((((N)-1) << LCD_HORZTIMING_PPL_BIT) & LCD_HORZTIMING_PPL_MASK)
+
+#define LCD_VERTTIMING             (AU1100_LCD_BASE + 0x10)
+  #define LCD_VERTTIMING_VN2_BIT   24
+  #define LCD_VERTTIMING_VN2_MASK  (0xFF << LCD_VERTTIMING_VN2_BIT)
+  #define LCD_VERTTIMING_VN2_N(N)  ((((N)-1) << LCD_VERTTIMING_VN2_BIT) & LCD_VERTTIMING_VN2_MASK)
+  #define LCD_VERTTIMING_VN1_BIT   16
+  #define LCD_VERTTIMING_VN1_MASK  (0xFF << LCD_VERTTIMING_VN1_BIT)
+  #define LCD_VERTTIMING_VN1_N(N)  ((((N)-1) << LCD_VERTTIMING_VN1_BIT) & LCD_VERTTIMING_VN1_MASK)
+  #define LCD_VERTTIMING_VPW_BIT   10
+  #define LCD_VERTTIMING_VPW_MASK  (0x3F << LCD_VERTTIMING_VPW_BIT)
+  #define LCD_VERTTIMING_VPW_N(N)  ((((N)-1) << LCD_VERTTIMING_VPW_BIT) & LCD_VERTTIMING_VPW_MASK)
+  #define LCD_VERTTIMING_LPP_BIT   0
+  #define LCD_VERTTIMING_LPP_MASK  (0x3FF << LCD_VERTTIMING_LPP_BIT)
+  #define LCD_VERTTIMING_LPP_N(N)  ((((N)-1) << LCD_VERTTIMING_LPP_BIT) & LCD_VERTTIMING_LPP_MASK)
+
+#define LCD_CLKCONTROL             (AU1100_LCD_BASE + 0x14)
+  #define LCD_CLKCONTROL_IB        (1<<18)
+  #define LCD_CLKCONTROL_IC        (1<<17)
+  #define LCD_CLKCONTROL_IH        (1<<16)
+  #define LCD_CLKCONTROL_IV        (1<<15)
+  #define LCD_CLKCONTROL_BF_BIT    10
+  #define LCD_CLKCONTROL_BF_MASK   (0x1F << LCD_CLKCONTROL_BF_BIT)
+  #define LCD_CLKCONTROL_BF_N(N)   ((((N)-1) << LCD_CLKCONTROL_BF_BIT) & LCD_CLKCONTROL_BF_MASK)
+  #define LCD_CLKCONTROL_PCD_BIT   0
+  #define LCD_CLKCONTROL_PCD_MASK  (0x3FF << LCD_CLKCONTROL_PCD_BIT)
+  #define LCD_CLKCONTROL_PCD_N(N)  (((N) << LCD_CLKCONTROL_PCD_BIT) & LCD_CLKCONTROL_PCD_MASK)
+
+#define LCD_DMAADDR0               (AU1100_LCD_BASE + 0x18)
+#define LCD_DMAADDR1               (AU1100_LCD_BASE + 0x1C)
+  #define LCD_DMA_SA_BIT           5
+  #define LCD_DMA_SA_MASK          (0x7FFFFFF << LCD_DMA_SA_BIT)
+  #define LCD_DMA_SA_N(N)          ((N) & LCD_DMA_SA_MASK)
+
+#define LCD_WORDS                  (AU1100_LCD_BASE + 0x20)
+  #define LCD_WRD_WRDS_BIT         0
+  #define LCD_WRD_WRDS_MASK        (0xFFFFFFFF << LCD_WRD_WRDS_BIT)
+  #define LCD_WRD_WRDS_N(N)        ((((N)-1) << LCD_WRD_WRDS_BIT) & LCD_WRD_WRDS_MASK)
+
+#define LCD_PWMDIV                 (AU1100_LCD_BASE + 0x24)
+  #define LCD_PWMDIV_EN            (1<<12)
+  #define LCD_PWMDIV_PWMDIV_BIT    0
+  #define LCD_PWMDIV_PWMDIV_MASK   (0xFFF << LCD_PWMDIV_PWMDIV_BIT)
+  #define LCD_PWMDIV_PWMDIV_N(N)   ((((N)-1) << LCD_PWMDIV_PWMDIV_BIT) & LCD_PWMDIV_PWMDIV_MASK)
+
+#define LCD_PWMHI                  (AU1100_LCD_BASE + 0x28)
+  #define LCD_PWMHI_PWMHI1_BIT     12
+  #define LCD_PWMHI_PWMHI1_MASK    (0xFFF << LCD_PWMHI_PWMHI1_BIT)
+  #define LCD_PWMHI_PWMHI1_N(N)    (((N) << LCD_PWMHI_PWMHI1_BIT) & LCD_PWMHI_PWMHI1_MASK)
+  #define LCD_PWMHI_PWMHI0_BIT     0
+  #define LCD_PWMHI_PWMHI0_MASK    (0xFFF << LCD_PWMHI_PWMHI0_BIT)
+  #define LCD_PWMHI_PWMHI0_N(N)    (((N) << LCD_PWMHI_PWMHI0_BIT) & LCD_PWMHI_PWMHI0_MASK)
+
+#define LCD_PALLETTEBASE                (AU1100_LCD_BASE + 0x400)
+  #define LCD_PALLETTE_MONO_MI_BIT      0
+  #define LCD_PALLETTE_MONO_MI_MASK     (0xF << LCD_PALLETTE_MONO_MI_BIT)
+  #define LCD_PALLETTE_MONO_MI_N(N)     (((N)<< LCD_PALLETTE_MONO_MI_BIT) & LCD_PALLETTE_MONO_MI_MASK)
+
+  #define LCD_PALLETTE_COLOR_RI_BIT     8
+  #define LCD_PALLETTE_COLOR_RI_MASK    (0xF << LCD_PALLETTE_COLOR_RI_BIT)
+  #define LCD_PALLETTE_COLOR_RI_N(N)    (((N)<< LCD_PALLETTE_COLOR_RI_BIT) & LCD_PALLETTE_COLOR_RI_MASK)
+  #define LCD_PALLETTE_COLOR_GI_BIT     4
+  #define LCD_PALLETTE_COLOR_GI_MASK    (0xF << LCD_PALLETTE_COLOR_GI_BIT)
+  #define LCD_PALLETTE_COLOR_GI_N(N)    (((N)<< LCD_PALLETTE_COLOR_GI_BIT) & LCD_PALLETTE_COLOR_GI_MASK)
+  #define LCD_PALLETTE_COLOR_BI_BIT     0
+  #define LCD_PALLETTE_COLOR_BI_MASK    (0xF << LCD_PALLETTE_COLOR_BI_BIT)
+  #define LCD_PALLETTE_COLOR_BI_N(N)    (((N)<< LCD_PALLETTE_COLOR_BI_BIT) & LCD_PALLETTE_COLOR_BI_MASK)
+
+  #define LCD_PALLETTE_TFT_DC_BIT       0
+  #define LCD_PALLETTE_TFT_DC_MASK      (0xFFFF << LCD_PALLETTE_TFT_DC_BIT)
+  #define LCD_PALLETTE_TFT_DC_N(N)      (((N)<< LCD_PALLETTE_TFT_DC_BIT) & LCD_PALLETTE_TFT_DC_MASK)
+
+/********************************************************************/
+
+/* List of panels known to work with the AU1100 LCD controller.
+ * To add a new panel, enter the same specifications as the
+ * Generic_TFT one, and MAKE SURE that it doesn't conflicts
+ * with the controller restrictions. Restrictions are:
+ *
+ * STN color panels: max_bpp <= 12
+ * STN mono panels: max_bpp <= 4
+ * TFT panels: max_bpp <= 16
+ * max_xres <= 800
+ * max_yres <= 600
+ */
+static struct au1100fb_panel known_lcd_panels[] =
+{
+	/* 800x600x16bpp CRT */
+	[0] = {
+		.name = "CRT_800x600_16",
+		.xres = 800,
+		.yres = 600,
+		.bpp = 16,
+		.control_base =	0x0004886A |
+			LCD_CONTROL_DEFAULT_PO | LCD_CONTROL_DEFAULT_SBPPF |
+			LCD_CONTROL_BPP_16 | LCD_CONTROL_SBB_4,
+		.clkcontrol_base = 0x00020000,
+		.horztiming = 0x005aff1f,
+		.verttiming = 0x16000e57,
+	},
+	/* just the standard LCD */
+	[1] = {
+		.name = "WWPC LCD",
+		.xres = 240,
+		.yres = 320,
+		.bpp = 16,
+		.control_base = 0x0006806A,
+		.horztiming = 0x0A1010EF,
+		.verttiming = 0x0301013F,
+		.clkcontrol_base = 0x00018001,
+	},
+	/* Sharp 320x240 TFT panel */
+	[2] = {
+		.name = "Sharp_LQ038Q5DR01",
+		.xres = 320,
+		.yres = 240,
+		.bpp = 16,
+		.control_base =
+		( LCD_CONTROL_SBPPF_565
+		| LCD_CONTROL_C
+		| LCD_CONTROL_SM_0
+			| LCD_CONTROL_DEFAULT_PO
+		| LCD_CONTROL_PT
+		| LCD_CONTROL_PC
+		| LCD_CONTROL_BPP_16 ),
+		.horztiming =
+		( LCD_HORZTIMING_HN2_N(8)
+		| LCD_HORZTIMING_HN1_N(60)
+		| LCD_HORZTIMING_HPW_N(12)
+		| LCD_HORZTIMING_PPL_N(320) ),
+		.verttiming =
+		( LCD_VERTTIMING_VN2_N(5)
+		| LCD_VERTTIMING_VN1_N(17)
+		| LCD_VERTTIMING_VPW_N(1)
+		| LCD_VERTTIMING_LPP_N(240) ),
+		.clkcontrol_base = LCD_CLKCONTROL_PCD_N(1),
+	},
+
+	/* Hitachi SP14Q005 and possibly others */
+	[3] = {
+		.name = "Hitachi_SP14Qxxx",
+		.xres = 320,
+		.yres = 240,
+		.bpp = 4,
+		.control_base =
+			( LCD_CONTROL_C
+			| LCD_CONTROL_BPP_4 ),
+		.horztiming =
+			( LCD_HORZTIMING_HN2_N(1)
+			| LCD_HORZTIMING_HN1_N(1)
+			| LCD_HORZTIMING_HPW_N(1)
+			| LCD_HORZTIMING_PPL_N(320) ),
+		.verttiming =
+			( LCD_VERTTIMING_VN2_N(1)
+			| LCD_VERTTIMING_VN1_N(1)
+			| LCD_VERTTIMING_VPW_N(1)
+			| LCD_VERTTIMING_LPP_N(240) ),
+		.clkcontrol_base = LCD_CLKCONTROL_PCD_N(4),
+	},
+
+	/* Generic 640x480 TFT panel */
+	[4] = {
+		.name = "TFT_640x480_16",
+		.xres = 640,
+		.yres = 480,
+		.bpp = 16,
+		.control_base = 0x004806a | LCD_CONTROL_DEFAULT_PO,
+		.horztiming = 0x3434d67f,
+		.verttiming = 0x0e0e39df,
+		.clkcontrol_base = LCD_CLKCONTROL_PCD_N(1),
+	},
+
+	 /* Pb1100 LCDB 640x480 PrimeView TFT panel */
+	[5] = {
+		.name = "PrimeView_640x480_16",
+		.xres = 640,
+		.yres = 480,
+		.bpp = 16,
+		.control_base = 0x0004886a | LCD_CONTROL_DEFAULT_PO,
+		.horztiming = 0x0e4bfe7f,
+		.verttiming = 0x210805df,
+		.clkcontrol_base = 0x00038001,
+	},
+};
+
+/********************************************************************/
+
+/* Inline helpers */
+
+#define panel_is_dual(panel)  (panel->control_base & LCD_CONTROL_DP)
+#define panel_is_active(panel)(panel->control_base & LCD_CONTROL_PT)
+#define panel_is_color(panel) (panel->control_base & LCD_CONTROL_PC)
+#define panel_swap_rgb(panel) (panel->control_base & LCD_CONTROL_CCO)
 
 #if defined(CONFIG_COMPILE_TEST) && !defined(CONFIG_MIPS)
 /* This is only defined to be able to compile this driver on non-mips platforms */
diff --git a/drivers/video/fbdev/au1100fb.h b/drivers/video/fbdev/au1100fb.h
deleted file mode 100644
index 80743b3e2376..000000000000
--- a/drivers/video/fbdev/au1100fb.h
+++ /dev/null
@@ -1,372 +0,0 @@
-/*
- * BRIEF MODULE DESCRIPTION
- *	Hardware definitions for the Au1100 LCD controller
- *
- * Copyright 2002 MontaVista Software
- * Copyright 2002 Alchemy Semiconductor
- * Author:	Alchemy Semiconductor, MontaVista Software
- *
- *  This program is free software; you can redistribute	 it and/or modify it
- *  under  the terms of	 the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the	License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED	  ``AS	IS'' AND   ANY	EXPRESS OR IMPLIED
- *  WARRANTIES,	  INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO	EVENT  SHALL   THE AUTHOR  BE	 LIABLE FOR ANY	  DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED	  TO, PROCUREMENT OF  SUBSTITUTE GOODS	OR SERVICES; LOSS OF
- *  USE, DATA,	OR PROFITS; OR	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN	 CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#ifndef _AU1100LCD_H
-#define _AU1100LCD_H
-
-#if defined(__BIG_ENDIAN)
-#define LCD_CONTROL_DEFAULT_PO LCD_CONTROL_PO_11
-#else
-#define LCD_CONTROL_DEFAULT_PO LCD_CONTROL_PO_00
-#endif
-#define LCD_CONTROL_DEFAULT_SBPPF LCD_CONTROL_SBPPF_565
-
-/********************************************************************/
-
-/* LCD controller restrictions */
-#define AU1100_LCD_MAX_XRES	800
-#define AU1100_LCD_MAX_YRES	600
-#define AU1100_LCD_MAX_BPP	16
-#define AU1100_LCD_MAX_CLK	48000000
-#define AU1100_LCD_NBR_PALETTE_ENTRIES 256
-
-/* Default number of visible screen buffer to allocate */
-#define AU1100FB_NBR_VIDEO_BUFFERS 4
-
-/********************************************************************/
-
-struct au1100fb_panel
-{
-	const char name[25];		/* Full name <vendor>_<model> */
-
-	u32   	control_base;		/* Mode-independent control values */
-	u32	clkcontrol_base;	/* Panel pixclock preferences */
-
-	u32	horztiming;
-	u32	verttiming;
-
-	u32	xres;		/* Maximum horizontal resolution */
-	u32 	yres;		/* Maximum vertical resolution */
-	u32 	bpp;		/* Maximum depth supported */
-};
-
-struct au1100fb_regs
-{
-	u32  lcd_control;
-	u32  lcd_intstatus;
-	u32  lcd_intenable;
-	u32  lcd_horztiming;
-	u32  lcd_verttiming;
-	u32  lcd_clkcontrol;
-	u32  lcd_dmaaddr0;
-	u32  lcd_dmaaddr1;
-	u32  lcd_words;
-	u32  lcd_pwmdiv;
-	u32  lcd_pwmhi;
-	u32  reserved[(0x0400-0x002C)/4];
-	u32  lcd_palettebase[256];
-};
-
-struct au1100fb_device {
-
-	struct fb_info info;			/* FB driver info record */
-
-	struct au1100fb_panel 	*panel;		/* Panel connected to this device */
-
-	struct au1100fb_regs* 	regs;		/* Registers memory map */
-	size_t       		regs_len;
-	unsigned int 		regs_phys;
-
-#ifdef CONFIG_PM
-	/* stores the register values during suspend */
-	struct au1100fb_regs	pm_regs;
-#endif
-
-	unsigned char* 		fb_mem;		/* FrameBuffer memory map */
-	size_t	      		fb_len;
-	dma_addr_t    		fb_phys;
-	int			panel_idx;
-	struct clk		*lcdclk;
-	struct device		*dev;
-};
-
-/********************************************************************/
-
-#define LCD_CONTROL                (AU1100_LCD_BASE + 0x0)
-  #define LCD_CONTROL_SBB_BIT      21
-  #define LCD_CONTROL_SBB_MASK     (0x3 << LCD_CONTROL_SBB_BIT)
-    #define LCD_CONTROL_SBB_1        (0 << LCD_CONTROL_SBB_BIT)
-    #define LCD_CONTROL_SBB_2        (1 << LCD_CONTROL_SBB_BIT)
-    #define LCD_CONTROL_SBB_3        (2 << LCD_CONTROL_SBB_BIT)
-    #define LCD_CONTROL_SBB_4        (3 << LCD_CONTROL_SBB_BIT)
-  #define LCD_CONTROL_SBPPF_BIT    18
-  #define LCD_CONTROL_SBPPF_MASK   (0x7 << LCD_CONTROL_SBPPF_BIT)
-    #define LCD_CONTROL_SBPPF_655    (0 << LCD_CONTROL_SBPPF_BIT)
-    #define LCD_CONTROL_SBPPF_565    (1 << LCD_CONTROL_SBPPF_BIT)
-    #define LCD_CONTROL_SBPPF_556    (2 << LCD_CONTROL_SBPPF_BIT)
-    #define LCD_CONTROL_SBPPF_1555   (3 << LCD_CONTROL_SBPPF_BIT)
-    #define LCD_CONTROL_SBPPF_5551   (4 << LCD_CONTROL_SBPPF_BIT)
-  #define LCD_CONTROL_WP           (1<<17)
-  #define LCD_CONTROL_WD           (1<<16)
-  #define LCD_CONTROL_C            (1<<15)
-  #define LCD_CONTROL_SM_BIT       13
-  #define LCD_CONTROL_SM_MASK      (0x3 << LCD_CONTROL_SM_BIT)
-    #define LCD_CONTROL_SM_0         (0 << LCD_CONTROL_SM_BIT)
-    #define LCD_CONTROL_SM_90        (1 << LCD_CONTROL_SM_BIT)
-    #define LCD_CONTROL_SM_180       (2 << LCD_CONTROL_SM_BIT)
-    #define LCD_CONTROL_SM_270       (3 << LCD_CONTROL_SM_BIT)
-  #define LCD_CONTROL_DB           (1<<12)
-  #define LCD_CONTROL_CCO          (1<<11)
-  #define LCD_CONTROL_DP           (1<<10)
-  #define LCD_CONTROL_PO_BIT       8
-  #define LCD_CONTROL_PO_MASK      (0x3 << LCD_CONTROL_PO_BIT)
-    #define LCD_CONTROL_PO_00        (0 << LCD_CONTROL_PO_BIT)
-    #define LCD_CONTROL_PO_01        (1 << LCD_CONTROL_PO_BIT)
-    #define LCD_CONTROL_PO_10        (2 << LCD_CONTROL_PO_BIT)
-    #define LCD_CONTROL_PO_11        (3 << LCD_CONTROL_PO_BIT)
-  #define LCD_CONTROL_MPI          (1<<7)
-  #define LCD_CONTROL_PT           (1<<6)
-  #define LCD_CONTROL_PC           (1<<5)
-  #define LCD_CONTROL_BPP_BIT      1
-  #define LCD_CONTROL_BPP_MASK     (0x7 << LCD_CONTROL_BPP_BIT)
-    #define LCD_CONTROL_BPP_1        (0 << LCD_CONTROL_BPP_BIT)
-    #define LCD_CONTROL_BPP_2        (1 << LCD_CONTROL_BPP_BIT)
-    #define LCD_CONTROL_BPP_4        (2 << LCD_CONTROL_BPP_BIT)
-    #define LCD_CONTROL_BPP_8        (3 << LCD_CONTROL_BPP_BIT)
-    #define LCD_CONTROL_BPP_12       (4 << LCD_CONTROL_BPP_BIT)
-    #define LCD_CONTROL_BPP_16       (5 << LCD_CONTROL_BPP_BIT)
-  #define LCD_CONTROL_GO           (1<<0)
-
-#define LCD_INTSTATUS              (AU1100_LCD_BASE + 0x4)
-#define LCD_INTENABLE              (AU1100_LCD_BASE + 0x8)
-  #define LCD_INT_SD               (1<<7)
-  #define LCD_INT_OF               (1<<6)
-  #define LCD_INT_UF               (1<<5)
-  #define LCD_INT_SA               (1<<3)
-  #define LCD_INT_SS               (1<<2)
-  #define LCD_INT_S1               (1<<1)
-  #define LCD_INT_S0               (1<<0)
-
-#define LCD_HORZTIMING             (AU1100_LCD_BASE + 0xC)
-  #define LCD_HORZTIMING_HN2_BIT   24
-  #define LCD_HORZTIMING_HN2_MASK  (0xFF << LCD_HORZTIMING_HN2_BIT)
-  #define LCD_HORZTIMING_HN2_N(N)  ((((N)-1) << LCD_HORZTIMING_HN2_BIT) & LCD_HORZTIMING_HN2_MASK)
-  #define LCD_HORZTIMING_HN1_BIT   16
-  #define LCD_HORZTIMING_HN1_MASK  (0xFF << LCD_HORZTIMING_HN1_BIT)
-  #define LCD_HORZTIMING_HN1_N(N)  ((((N)-1) << LCD_HORZTIMING_HN1_BIT) & LCD_HORZTIMING_HN1_MASK)
-  #define LCD_HORZTIMING_HPW_BIT   10
-  #define LCD_HORZTIMING_HPW_MASK  (0x3F << LCD_HORZTIMING_HPW_BIT)
-  #define LCD_HORZTIMING_HPW_N(N)  ((((N)-1) << LCD_HORZTIMING_HPW_BIT) & LCD_HORZTIMING_HPW_MASK)
-  #define LCD_HORZTIMING_PPL_BIT   0
-  #define LCD_HORZTIMING_PPL_MASK  (0x3FF << LCD_HORZTIMING_PPL_BIT)
-  #define LCD_HORZTIMING_PPL_N(N)  ((((N)-1) << LCD_HORZTIMING_PPL_BIT) & LCD_HORZTIMING_PPL_MASK)
-
-#define LCD_VERTTIMING             (AU1100_LCD_BASE + 0x10)
-  #define LCD_VERTTIMING_VN2_BIT   24
-  #define LCD_VERTTIMING_VN2_MASK  (0xFF << LCD_VERTTIMING_VN2_BIT)
-  #define LCD_VERTTIMING_VN2_N(N)  ((((N)-1) << LCD_VERTTIMING_VN2_BIT) & LCD_VERTTIMING_VN2_MASK)
-  #define LCD_VERTTIMING_VN1_BIT   16
-  #define LCD_VERTTIMING_VN1_MASK  (0xFF << LCD_VERTTIMING_VN1_BIT)
-  #define LCD_VERTTIMING_VN1_N(N)  ((((N)-1) << LCD_VERTTIMING_VN1_BIT) & LCD_VERTTIMING_VN1_MASK)
-  #define LCD_VERTTIMING_VPW_BIT   10
-  #define LCD_VERTTIMING_VPW_MASK  (0x3F << LCD_VERTTIMING_VPW_BIT)
-  #define LCD_VERTTIMING_VPW_N(N)  ((((N)-1) << LCD_VERTTIMING_VPW_BIT) & LCD_VERTTIMING_VPW_MASK)
-  #define LCD_VERTTIMING_LPP_BIT   0
-  #define LCD_VERTTIMING_LPP_MASK  (0x3FF << LCD_VERTTIMING_LPP_BIT)
-  #define LCD_VERTTIMING_LPP_N(N)  ((((N)-1) << LCD_VERTTIMING_LPP_BIT) & LCD_VERTTIMING_LPP_MASK)
-
-#define LCD_CLKCONTROL             (AU1100_LCD_BASE + 0x14)
-  #define LCD_CLKCONTROL_IB        (1<<18)
-  #define LCD_CLKCONTROL_IC        (1<<17)
-  #define LCD_CLKCONTROL_IH        (1<<16)
-  #define LCD_CLKCONTROL_IV        (1<<15)
-  #define LCD_CLKCONTROL_BF_BIT    10
-  #define LCD_CLKCONTROL_BF_MASK   (0x1F << LCD_CLKCONTROL_BF_BIT)
-  #define LCD_CLKCONTROL_BF_N(N)   ((((N)-1) << LCD_CLKCONTROL_BF_BIT) & LCD_CLKCONTROL_BF_MASK)
-  #define LCD_CLKCONTROL_PCD_BIT   0
-  #define LCD_CLKCONTROL_PCD_MASK  (0x3FF << LCD_CLKCONTROL_PCD_BIT)
-  #define LCD_CLKCONTROL_PCD_N(N)  (((N) << LCD_CLKCONTROL_PCD_BIT) & LCD_CLKCONTROL_PCD_MASK)
-
-#define LCD_DMAADDR0               (AU1100_LCD_BASE + 0x18)
-#define LCD_DMAADDR1               (AU1100_LCD_BASE + 0x1C)
-  #define LCD_DMA_SA_BIT           5
-  #define LCD_DMA_SA_MASK          (0x7FFFFFF << LCD_DMA_SA_BIT)
-  #define LCD_DMA_SA_N(N)          ((N) & LCD_DMA_SA_MASK)
-
-#define LCD_WORDS                  (AU1100_LCD_BASE + 0x20)
-  #define LCD_WRD_WRDS_BIT         0
-  #define LCD_WRD_WRDS_MASK        (0xFFFFFFFF << LCD_WRD_WRDS_BIT)
-  #define LCD_WRD_WRDS_N(N)        ((((N)-1) << LCD_WRD_WRDS_BIT) & LCD_WRD_WRDS_MASK)
-
-#define LCD_PWMDIV                 (AU1100_LCD_BASE + 0x24)
-  #define LCD_PWMDIV_EN            (1<<12)
-  #define LCD_PWMDIV_PWMDIV_BIT    0
-  #define LCD_PWMDIV_PWMDIV_MASK   (0xFFF << LCD_PWMDIV_PWMDIV_BIT)
-  #define LCD_PWMDIV_PWMDIV_N(N)   ((((N)-1) << LCD_PWMDIV_PWMDIV_BIT) & LCD_PWMDIV_PWMDIV_MASK)
-
-#define LCD_PWMHI                  (AU1100_LCD_BASE + 0x28)
-  #define LCD_PWMHI_PWMHI1_BIT     12
-  #define LCD_PWMHI_PWMHI1_MASK    (0xFFF << LCD_PWMHI_PWMHI1_BIT)
-  #define LCD_PWMHI_PWMHI1_N(N)    (((N) << LCD_PWMHI_PWMHI1_BIT) & LCD_PWMHI_PWMHI1_MASK)
-  #define LCD_PWMHI_PWMHI0_BIT     0
-  #define LCD_PWMHI_PWMHI0_MASK    (0xFFF << LCD_PWMHI_PWMHI0_BIT)
-  #define LCD_PWMHI_PWMHI0_N(N)    (((N) << LCD_PWMHI_PWMHI0_BIT) & LCD_PWMHI_PWMHI0_MASK)
-
-#define LCD_PALLETTEBASE                (AU1100_LCD_BASE + 0x400)
-  #define LCD_PALLETTE_MONO_MI_BIT      0
-  #define LCD_PALLETTE_MONO_MI_MASK     (0xF << LCD_PALLETTE_MONO_MI_BIT)
-  #define LCD_PALLETTE_MONO_MI_N(N)     (((N)<< LCD_PALLETTE_MONO_MI_BIT) & LCD_PALLETTE_MONO_MI_MASK)
-
-  #define LCD_PALLETTE_COLOR_RI_BIT     8
-  #define LCD_PALLETTE_COLOR_RI_MASK    (0xF << LCD_PALLETTE_COLOR_RI_BIT)
-  #define LCD_PALLETTE_COLOR_RI_N(N)    (((N)<< LCD_PALLETTE_COLOR_RI_BIT) & LCD_PALLETTE_COLOR_RI_MASK)
-  #define LCD_PALLETTE_COLOR_GI_BIT     4
-  #define LCD_PALLETTE_COLOR_GI_MASK    (0xF << LCD_PALLETTE_COLOR_GI_BIT)
-  #define LCD_PALLETTE_COLOR_GI_N(N)    (((N)<< LCD_PALLETTE_COLOR_GI_BIT) & LCD_PALLETTE_COLOR_GI_MASK)
-  #define LCD_PALLETTE_COLOR_BI_BIT     0
-  #define LCD_PALLETTE_COLOR_BI_MASK    (0xF << LCD_PALLETTE_COLOR_BI_BIT)
-  #define LCD_PALLETTE_COLOR_BI_N(N)    (((N)<< LCD_PALLETTE_COLOR_BI_BIT) & LCD_PALLETTE_COLOR_BI_MASK)
-
-  #define LCD_PALLETTE_TFT_DC_BIT       0
-  #define LCD_PALLETTE_TFT_DC_MASK      (0xFFFF << LCD_PALLETTE_TFT_DC_BIT)
-  #define LCD_PALLETTE_TFT_DC_N(N)      (((N)<< LCD_PALLETTE_TFT_DC_BIT) & LCD_PALLETTE_TFT_DC_MASK)
-
-/********************************************************************/
-
-/* List of panels known to work with the AU1100 LCD controller.
- * To add a new panel, enter the same specifications as the
- * Generic_TFT one, and MAKE SURE that it doesn't conflicts
- * with the controller restrictions. Restrictions are:
- *
- * STN color panels: max_bpp <= 12
- * STN mono panels: max_bpp <= 4
- * TFT panels: max_bpp <= 16
- * max_xres <= 800
- * max_yres <= 600
- */
-static struct au1100fb_panel known_lcd_panels[] =
-{
-	/* 800x600x16bpp CRT */
-	[0] = {
-		.name = "CRT_800x600_16",
-		.xres = 800,
-		.yres = 600,
-		.bpp = 16,
-		.control_base =	0x0004886A |
-			LCD_CONTROL_DEFAULT_PO | LCD_CONTROL_DEFAULT_SBPPF |
-			LCD_CONTROL_BPP_16 | LCD_CONTROL_SBB_4,
-		.clkcontrol_base = 0x00020000,
-		.horztiming = 0x005aff1f,
-		.verttiming = 0x16000e57,
-	},
-	/* just the standard LCD */
-	[1] = {
-		.name = "WWPC LCD",
-		.xres = 240,
-		.yres = 320,
-		.bpp = 16,
-		.control_base = 0x0006806A,
-		.horztiming = 0x0A1010EF,
-		.verttiming = 0x0301013F,
-		.clkcontrol_base = 0x00018001,
-	},
-	/* Sharp 320x240 TFT panel */
-	[2] = {
-		.name = "Sharp_LQ038Q5DR01",
-		.xres = 320,
-		.yres = 240,
-		.bpp = 16,
-		.control_base =
-		( LCD_CONTROL_SBPPF_565
-		| LCD_CONTROL_C
-		| LCD_CONTROL_SM_0
-			| LCD_CONTROL_DEFAULT_PO
-		| LCD_CONTROL_PT
-		| LCD_CONTROL_PC
-		| LCD_CONTROL_BPP_16 ),
-		.horztiming =
-		( LCD_HORZTIMING_HN2_N(8)
-		| LCD_HORZTIMING_HN1_N(60)
-		| LCD_HORZTIMING_HPW_N(12)
-		| LCD_HORZTIMING_PPL_N(320) ),
-		.verttiming =
-		( LCD_VERTTIMING_VN2_N(5)
-		| LCD_VERTTIMING_VN1_N(17)
-		| LCD_VERTTIMING_VPW_N(1)
-		| LCD_VERTTIMING_LPP_N(240) ),
-		.clkcontrol_base = LCD_CLKCONTROL_PCD_N(1),
-	},
-
-	/* Hitachi SP14Q005 and possibly others */
-	[3] = {
-		.name = "Hitachi_SP14Qxxx",
-		.xres = 320,
-		.yres = 240,
-		.bpp = 4,
-		.control_base =
-			( LCD_CONTROL_C
-			| LCD_CONTROL_BPP_4 ),
-		.horztiming =
-			( LCD_HORZTIMING_HN2_N(1)
-			| LCD_HORZTIMING_HN1_N(1)
-			| LCD_HORZTIMING_HPW_N(1)
-			| LCD_HORZTIMING_PPL_N(320) ),
-		.verttiming =
-			( LCD_VERTTIMING_VN2_N(1)
-			| LCD_VERTTIMING_VN1_N(1)
-			| LCD_VERTTIMING_VPW_N(1)
-			| LCD_VERTTIMING_LPP_N(240) ),
-		.clkcontrol_base = LCD_CLKCONTROL_PCD_N(4),
-	},
-
-	/* Generic 640x480 TFT panel */
-	[4] = {
-		.name = "TFT_640x480_16",
-		.xres = 640,
-		.yres = 480,
-		.bpp = 16,
-		.control_base = 0x004806a | LCD_CONTROL_DEFAULT_PO,
-		.horztiming = 0x3434d67f,
-		.verttiming = 0x0e0e39df,
-		.clkcontrol_base = LCD_CLKCONTROL_PCD_N(1),
-	},
-
-	 /* Pb1100 LCDB 640x480 PrimeView TFT panel */
-	[5] = {
-		.name = "PrimeView_640x480_16",
-		.xres = 640,
-		.yres = 480,
-		.bpp = 16,
-		.control_base = 0x0004886a | LCD_CONTROL_DEFAULT_PO,
-		.horztiming = 0x0e4bfe7f,
-		.verttiming = 0x210805df,
-		.clkcontrol_base = 0x00038001,
-	},
-};
-
-/********************************************************************/
-
-/* Inline helpers */
-
-#define panel_is_dual(panel)  (panel->control_base & LCD_CONTROL_DP)
-#define panel_is_active(panel)(panel->control_base & LCD_CONTROL_PT)
-#define panel_is_color(panel) (panel->control_base & LCD_CONTROL_PC)
-#define panel_swap_rgb(panel) (panel->control_base & LCD_CONTROL_CCO)
-
-#endif /* _AU1100LCD_H */
-- 
2.47.3

