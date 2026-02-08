Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ACB1E2614
	for <linux-fbdev@vger.kernel.org>; Sun,  8 Feb 2026 02:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770519566; cv=none; b=dUk9roclZ649IuLtyBbey7xKHlQhp8oULVyJgYGaVg5grz2ZKjOLjo+XTJkGgyds6XQPL9PjejNqM3qLcYdyGmvPqsFyno9QkukCI59f8RZ4CTUQccSUiaoDCH6+SCQowTh5f6n8UDBbRzM+U3M6E1wyHrXrUQUYqZVjJv8aBto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770519566; c=relaxed/simple;
	bh=5ktLlNs9p52smUOOL/j03HPN/+bMWWMiLdu2P20m0qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vf3Im2GLiLrPjkSTaopPDYAPh2U22nGzzR0kkzfks/1JcsE12JikJjtzbV1W4k/qGbSGu3+RRgG1mZLS5W9NuNenK61OR4ozxmCl8G3OcqAXfDteCc2TuO2JkE3PGLbY9OcaQifYRLusKnE8DXYi45uzBV25dw/lb9TX/UhGBfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INnlTH8r; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INnlTH8r"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ba6aa57d5fso90507eec.1
        for <linux-fbdev@vger.kernel.org>; Sat, 07 Feb 2026 18:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770519565; x=1771124365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2UAppHtAnTnM+AkFjS4tVQDxSgK2eQZ+lc5Qc7Twng=;
        b=INnlTH8rDsgA/vrAtwr7d0ilRuNjDuvZZEEkxC1ceW0UcslAEcsoYU6DloyS2d1A2w
         ka4KEsjIegw742crp0cOg70lvhyNYPehXsONw4nQznNJKyJUj46s8SBLHVqIeqETDIfQ
         jy42Yt1oiGY2ffLj7AADFcxEGqcI2q6Sd8c/T+2Sx0NZgTFKbs272GO2azyy/XbKxg3j
         xNJWTYuhyI7/ho8Jwi49ypcZJWAEt3sqAtagkPT/Dq/PncfE1AyiyxfeKXAR5diOCsa3
         NE3mFaW0gPy0WU4Qvw84bVUwJgeXRI6i3YDgU6DX2Z4243dx1Blyxxs0Io7NTuvt7ltE
         DFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770519565; x=1771124365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K2UAppHtAnTnM+AkFjS4tVQDxSgK2eQZ+lc5Qc7Twng=;
        b=hesgRcId6OzYZEVUDzlTa1FeTfr8ckoghOsx4Kiz3D+IKolBWmkvzSCmxzhE9f1/2C
         TO/cisMonWZbe8QjuakcSXiHgLmx/k78Ub2vNfoXDJpUDzLh0gkIvvaRdC7fsnIKQFUy
         M828eftQfYwO9DbhCJBqhax1mHjA3rp8ESP3H/p6VNJPZjrnYR4E8q49X9mo3SsrtipS
         Jw5OTI81lD7PQ2IFveA42YBMstOkFbpEqCIfiBnUX9fdg2mqDm5J1eGeCUwOgQ8qIi9T
         4pkWOhGpArlbWOqpwRMpJ8rcd/qSNyud+4BK1NGVJMFRI44iTqsupWrNYyy6M/5fH5Kv
         55LQ==
X-Gm-Message-State: AOJu0Yz83ZJI0dWuVqnpBjf19sqPe5x0kHW5076PQe/QSiwg8KipC40k
	nj4pTgd1dH0M+/q1m01RTtW0YLfQZRRD6BLkkjSPjFkRteu2rAuw6do=
X-Gm-Gg: AZuq6aIXz/ycs/JpWXGFI4fKnGRSfAFhgAIcUMhce9CmbD6og0bc+KrdeuYeKZtRAmj
	9QIlVlw6YNva1amaehKHS01KGCoY0SSvmCTh2UHOkP7FV67ZTvWZ64bN52itTOa+sG/Ul+uQBzS
	fn4tqg4zDVFKnK2CiXiHLA28um89GsJv5bLjJneq8ghPWKCVGvAgMaaTM25Wriw9P6CC69q2ejm
	G18zwOfGoUOSHBIDlw4KPZKvXCAweI1XeznGwndE0JVl/Kpfo6uAmYQFJCfyk8OFnA4vktFEYVT
	C/O7/N36/u+7YQqLMQVgkMZgAshVv+ZPdnH477LN8+vYNFbP3BHpCBJpjAHBvNQuL0SBHfEnYEs
	rJ+w2Y412ZpdcOstPKLOITXmYsqrEic+uj609bYzqv2528adkEIMbl9FcAAlJFHMlYu1CspH55M
	aCcOiK78lc1DmxGagBAY1hNZY=
X-Received: by 2002:a05:7301:1004:b0:2b8:2910:dcb7 with SMTP id 5a478bee46e88-2b856484a7cmr3127076eec.17.1770519565106;
        Sat, 07 Feb 2026 18:59:25 -0800 (PST)
Received: from arch ([2601:647:6980:8130::698f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855ad8da2sm5306007eec.5.2026.02.07.18.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 18:59:24 -0800 (PST)
From: Shreyas Ravi <shreyasravi320@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shreyas Ravi <shreyasravi320@gmail.com>
Subject: [PATCH v2 1/2] staging: sm750fb: Fix CamelCase variable names
Date: Sat,  7 Feb 2026 18:59:18 -0800
Message-ID: <20260208025919.1614754-1-shreyasravi320@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026020717-unmarked-hundredth-6660@gregkh>
References: <2026020717-unmarked-hundredth-6660@gregkh>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename CamelCase variable names to snake_case to comply
with kernel coding style.

No functional changes

Signed-off-by: Shreyas Ravi <shreyasravi320@gmail.com>
---
 drivers/staging/sm750fb/sm750.c       |  34 +++----
 drivers/staging/sm750fb/sm750.h       |  16 ++--
 drivers/staging/sm750fb/sm750_accel.c | 130 +++++++++++++-------------
 drivers/staging/sm750fb/sm750_accel.h |  44 ++++-----
 drivers/staging/sm750fb/sm750_hw.c    |  26 +++---
 5 files changed, 125 insertions(+), 125 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index dec1f6b88a7d..1ed7ff57c142 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -624,27 +624,27 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 		output->paths = sm750_pnc;
 		crtc->channel = sm750_primary;
 		crtc->o_screen = 0;
-		crtc->v_screen = sm750_dev->pvMem;
+		crtc->v_screen = sm750_dev->p_v_mem;
 		pr_info("use simul primary mode\n");
 		break;
 	case sm750_simul_sec:
 		output->paths = sm750_pnc;
 		crtc->channel = sm750_secondary;
 		crtc->o_screen = 0;
-		crtc->v_screen = sm750_dev->pvMem;
+		crtc->v_screen = sm750_dev->p_v_mem;
 		break;
 	case sm750_dual_normal:
 		if (par->index == 0) {
 			output->paths = sm750_panel;
 			crtc->channel = sm750_primary;
 			crtc->o_screen = 0;
-			crtc->v_screen = sm750_dev->pvMem;
+			crtc->v_screen = sm750_dev->p_v_mem;
 		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_secondary;
 			/* not consider of padding stuffs for o_screen,need fix */
 			crtc->o_screen = sm750_dev->vidmem_size >> 1;
-			crtc->v_screen = sm750_dev->pvMem + crtc->o_screen;
+			crtc->v_screen = sm750_dev->p_v_mem + crtc->o_screen;
 		}
 		break;
 	case sm750_dual_swap:
@@ -652,7 +652,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 			output->paths = sm750_panel;
 			crtc->channel = sm750_secondary;
 			crtc->o_screen = 0;
-			crtc->v_screen = sm750_dev->pvMem;
+			crtc->v_screen = sm750_dev->p_v_mem;
 		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_primary;
@@ -660,7 +660,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 			 * need fix
 			 */
 			crtc->o_screen = sm750_dev->vidmem_size >> 1;
-			crtc->v_screen = sm750_dev->pvMem + crtc->o_screen;
+			crtc->v_screen = sm750_dev->p_v_mem + crtc->o_screen;
 		}
 		break;
 	default:
@@ -764,14 +764,14 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	 * must be set after crtc member initialized
 	 */
 	crtc->cursor.offset = crtc->o_screen + crtc->vidmem_size - 1024;
-	crtc->cursor.mmio = sm750_dev->pvReg +
+	crtc->cursor.mmio = sm750_dev->p_v_reg +
 		0x800f0 + (int)crtc->channel * 0x140;
 
 	pr_info("crtc->cursor.mmio = %p\n", crtc->cursor.mmio);
 	crtc->cursor.max_h = 64;
 	crtc->cursor.max_w = 64;
 	crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
-	crtc->cursor.vstart = sm750_dev->pvMem + crtc->cursor.offset;
+	crtc->cursor.vstart = sm750_dev->p_v_mem + crtc->cursor.offset;
 
 	memset_io(crtc->cursor.vstart, 0, crtc->cursor.size);
 	if (!g_hwcursor)
@@ -921,9 +921,9 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
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
@@ -942,11 +942,11 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 		} else if (!strncmp(opt, "nocrt", strlen("nocrt"))) {
 			sm750_dev->nocrt = 1;
 		} else if (!strncmp(opt, "36bit", strlen("36bit"))) {
-			sm750_dev->pnltype = sm750_doubleTFT;
+			sm750_dev->pnltype = sm750_double_tft;
 		} else if (!strncmp(opt, "18bit", strlen("18bit"))) {
-			sm750_dev->pnltype = sm750_dualTFT;
+			sm750_dev->pnltype = sm750_dual_tft;
 		} else if (!strncmp(opt, "24bit", strlen("24bit"))) {
-			sm750_dev->pnltype = sm750_24TFT;
+			sm750_dev->pnltype = sm750_24_tft;
 		} else if (!strncmp(opt, "nohwc0", strlen("nohwc0"))) {
 			g_hwcursor &= ~0x1;
 		} else if (!strncmp(opt, "nohwc1", strlen("nohwc1"))) {
@@ -1090,7 +1090,7 @@ static int lynxfb_pci_probe(struct pci_dev *pdev,
 		sm750_dev->mtrr.vram = arch_phys_wc_add(sm750_dev->vidmem_start,
 							sm750_dev->vidmem_size);
 
-	memset_io(sm750_dev->pvMem, 0, sm750_dev->vidmem_size);
+	memset_io(sm750_dev->p_v_mem, 0, sm750_dev->vidmem_size);
 
 	pci_set_drvdata(pdev, sm750_dev);
 
@@ -1121,8 +1121,8 @@ static void lynxfb_pci_remove(struct pci_dev *pdev)
 	sm750fb_framebuffer_release(sm750_dev);
 	arch_phys_wc_del(sm750_dev->mtrr.vram);
 
-	iounmap(sm750_dev->pvReg);
-	iounmap(sm750_dev->pvMem);
+	iounmap(sm750_dev->p_v_reg);
+	iounmap(sm750_dev->p_v_mem);
 	kfree(g_settings);
 }
 
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 67b9bfa23f41..14e0e7d75f7e 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -13,9 +13,9 @@
 #endif
 
 enum sm750_pnltype {
-	sm750_24TFT = 0,	/* 24bit tft */
-	sm750_dualTFT = 2,	/* dual 18 bit tft */
-	sm750_doubleTFT = 1,	/* 36 bit double pixel tft */
+	sm750_24_tft = 0,	/* 24bit tft */
+	sm750_dual_tft = 2,	/* dual 18 bit tft */
+	sm750_double_tft = 1,	/* 36 bit double pixel tft */
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
@@ -97,8 +97,8 @@ struct sm750_dev {
 	unsigned long vidreg_start;
 	__u32 vidmem_size;
 	__u32 vidreg_size;
-	void __iomem *pvReg;
-	unsigned char __iomem *pvMem;
+	void __iomem *p_v_reg;
+	unsigned char __iomem *p_v_mem;
 	/* locks*/
 	spinlock_t slock;
 
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 046b9282b24a..4dd9b910af13 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -27,7 +27,7 @@ static inline u32 read_dpr(struct lynx_accel *accel, int offset)
 	return readl(accel->dpr_base + offset);
 }
 
-static inline void write_dpPort(struct lynx_accel *accel, u32 data)
+static inline void write_dp_port(struct lynx_accel *accel, u32 data)
 {
 	writel(data, accel->dp_port_base);
 }
@@ -85,7 +85,7 @@ void sm750_hw_set2dformat(struct lynx_accel *accel, int fmt)
 }
 
 int sm750_hw_fillrect(struct lynx_accel *accel,
-		      u32 base, u32 pitch, u32 Bpp,
+		      u32 base, u32 pitch, u32 bytes_per_pixel,
 		      u32 x, u32 y, u32 width, u32 height,
 		      u32 color, u32 rop)
 {
@@ -102,14 +102,14 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
 
 	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, base); /* dpr40 */
 	write_dpr(accel, DE_PITCH,
-		  ((pitch / Bpp << DE_PITCH_DESTINATION_SHIFT) &
+		  ((pitch / bytes_per_pixel << DE_PITCH_DESTINATION_SHIFT) &
 		   DE_PITCH_DESTINATION_MASK) |
-		  (pitch / Bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
+		  (pitch / bytes_per_pixel & DE_PITCH_SOURCE_MASK)); /* dpr10 */
 
 	write_dpr(accel, DE_WINDOW_WIDTH,
-		  ((pitch / Bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
+		  ((pitch / bytes_per_pixel << DE_WINDOW_WIDTH_DST_SHIFT) &
 		   DE_WINDOW_WIDTH_DST_MASK) |
-		   (pitch / Bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr44 */
+		   (pitch / bytes_per_pixel & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr44 */
 
 	write_dpr(accel, DE_FOREGROUND, color); /* DPR14 */
 
@@ -132,13 +132,13 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
 /**
  * sm750_hw_copyarea
  * @accel: Acceleration device data
- * @sBase: Address of source: offset in frame buffer
- * @sPitch: Pitch value of source surface in BYTE
+ * @source_base: Address of source: offset in frame buffer
+ * @source_pitch: Pitch value of source surface in BYTE
  * @sx: Starting x coordinate of source surface
  * @sy: Starting y coordinate of source surface
- * @dBase: Address of destination: offset in frame buffer
- * @dPitch: Pitch value of destination surface in BYTE
- * @Bpp: Color depth of destination surface
+ * @dest_base: Address of destination: offset in frame buffer
+ * @dest_pitch: Pitch value of destination surface in BYTE
+ * @bytes_per_pixel: Color depth of destination surface
  * @dx: Starting x coordinate of destination surface
  * @dy: Starting y coordinate of destination surface
  * @width: width of rectangle in pixel value
@@ -146,21 +146,21 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
  * @rop2: ROP value
  */
 int sm750_hw_copyarea(struct lynx_accel *accel,
-		      unsigned int sBase, unsigned int sPitch,
+		      unsigned int source_base, unsigned int source_pitch,
 		      unsigned int sx, unsigned int sy,
-		      unsigned int dBase, unsigned int dPitch,
-		      unsigned int Bpp, unsigned int dx, unsigned int dy,
+		      unsigned int dest_base, unsigned int dest_pitch,
+		      unsigned int bytes_per_pixel, unsigned int dx, unsigned int dy,
 		      unsigned int width, unsigned int height,
 		      unsigned int rop2)
 {
-	unsigned int nDirection, de_ctrl;
+	unsigned int n_direction, de_ctrl;
 
-	nDirection = LEFT_TO_RIGHT;
+	n_direction = LEFT_TO_RIGHT;
 	/* Direction of ROP2 operation: 1 = Left to Right, (-1) = Right to Left */
 	de_ctrl = 0;
 
 	/* If source and destination are the same surface, need to check for overlay cases */
-	if (sBase == dBase && sPitch == dPitch) {
+	if (source_base == dest_base && source_pitch == dest_pitch) {
 		/* Determine direction of operation */
 		if (sy < dy) {
 			/*  +----------+
@@ -173,7 +173,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 			 *	+----------+
 			 */
 
-			nDirection = BOTTOM_TO_TOP;
+			n_direction = BOTTOM_TO_TOP;
 		} else if (sy > dy) {
 			/*  +----------+
 			 *  |D         |
@@ -185,7 +185,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 			 *	+----------+
 			 */
 
-			nDirection = TOP_TO_BOTTOM;
+			n_direction = TOP_TO_BOTTOM;
 		} else {
 			/* sy == dy */
 
@@ -198,7 +198,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 				 * +------+---+------+
 				 */
 
-				nDirection = RIGHT_TO_LEFT;
+				n_direction = RIGHT_TO_LEFT;
 			} else {
 			/* sx > dx */
 
@@ -210,12 +210,12 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 				 * +------+---+------+
 				 */
 
-				nDirection = LEFT_TO_RIGHT;
+				n_direction = LEFT_TO_RIGHT;
 			}
 		}
 	}
 
-	if ((nDirection == BOTTOM_TO_TOP) || (nDirection == RIGHT_TO_LEFT)) {
+	if ((n_direction == BOTTOM_TO_TOP) || (n_direction == RIGHT_TO_LEFT)) {
 		sx += width - 1;
 		sy += height - 1;
 		dx += width - 1;
@@ -234,14 +234,14 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	 * It is an address offset (128 bit aligned)
 	 * from the beginning of frame buffer.
 	 */
-	write_dpr(accel, DE_WINDOW_SOURCE_BASE, sBase); /* dpr40 */
+	write_dpr(accel, DE_WINDOW_SOURCE_BASE, source_base); /* dpr40 */
 
 	/*
 	 * 2D Destination Base.
 	 * It is an address offset (128 bit aligned)
 	 * from the beginning of frame buffer.
 	 */
-	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, dBase); /* dpr44 */
+	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, dest_base); /* dpr44 */
 
 	/*
 	 * Program pitch (distance between the 1st points of two adjacent lines).
@@ -249,9 +249,9 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	 * pixel values. Need Byte to pixel conversion.
 	 */
 	write_dpr(accel, DE_PITCH,
-		  ((dPitch / Bpp << DE_PITCH_DESTINATION_SHIFT) &
+		  ((dest_pitch / bytes_per_pixel << DE_PITCH_DESTINATION_SHIFT) &
 		   DE_PITCH_DESTINATION_MASK) |
-		  (sPitch / Bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
+		  (source_pitch / bytes_per_pixel & DE_PITCH_SOURCE_MASK)); /* dpr10 */
 
 	/*
 	 * Screen Window width in Pixels.
@@ -259,9 +259,9 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	 * for a given point.
 	 */
 	write_dpr(accel, DE_WINDOW_WIDTH,
-		  ((dPitch / Bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
+		  ((dest_pitch / bytes_per_pixel << DE_WINDOW_WIDTH_DST_SHIFT) &
 		   DE_WINDOW_WIDTH_DST_MASK) |
-		  (sPitch / Bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */
+		  (source_pitch / bytes_per_pixel & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */
 
 	if (accel->de_wait() != 0)
 		return -1;
@@ -277,7 +277,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 		  (height & DE_DIMENSION_Y_ET_MASK)); /* dpr08 */
 
 	de_ctrl = (rop2 & DE_CONTROL_ROP_MASK) | DE_CONTROL_ROP_SELECT |
-		((nDirection == RIGHT_TO_LEFT) ? DE_CONTROL_DIRECTION : 0) |
+		((n_direction == RIGHT_TO_LEFT) ? DE_CONTROL_DIRECTION : 0) |
 		DE_CONTROL_COMMAND_BITBLT | DE_CONTROL_STATUS;
 	write_dpr(accel, DE_CONTROL, de_ctrl); /* dpr0c */
 
@@ -299,38 +299,38 @@ static unsigned int de_get_transparency(struct lynx_accel *accel)
 /**
  * sm750_hw_imageblit
  * @accel: Acceleration device data
- * @pSrcbuf: pointer to start of source buffer in system memory
- * @srcDelta: Pitch value (in bytes) of the source buffer, +ive means top down
+ * @p_srcbuf: pointer to start of source buffer in system memory
+ * @src_delta: Pitch value (in bytes) of the source buffer, +ive means top down
  *	      and -ive mean button up
- * @startBit: Mono data can start at any bit in a byte, this value should be
+ * @start_bit: Mono data can start at any bit in a byte, this value should be
  *	      0 to 7
- * @dBase: Address of destination: offset in frame buffer
- * @dPitch: Pitch value of destination surface in BYTE
- * @bytePerPixel: Color depth of destination surface
+ * @dest_base: Address of destination: offset in frame buffer
+ * @dest_pitch: Pitch value of destination surface in BYTE
+ * @byte_per_pixel: Color depth of destination surface
  * @dx: Starting x coordinate of destination surface
  * @dy: Starting y coordinate of destination surface
  * @width: width of rectangle in pixel value
  * @height: height of rectangle in pixel value
- * @fColor: Foreground color (corresponding to a 1 in the monochrome data
- * @bColor: Background color (corresponding to a 0 in the monochrome data
+ * @fg_color: Foreground color (corresponding to a 1 in the monochrome data
+ * @bg_color: Background color (corresponding to a 0 in the monochrome data
  * @rop2: ROP value
  */
-int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
-		       u32 srcDelta, u32 startBit, u32 dBase, u32 dPitch,
-		       u32 bytePerPixel, u32 dx, u32 dy, u32 width,
-		       u32 height, u32 fColor, u32 bColor, u32 rop2)
+int sm750_hw_imageblit(struct lynx_accel *accel, const char *p_srcbuf,
+		       u32 src_delta, u32 start_bit, u32 dest_base, u32 dest_pitch,
+		       u32 byte_per_pixel, u32 dx, u32 dy, u32 width,
+		       u32 height, u32 fg_color, u32 bg_color, u32 rop2)
 {
-	unsigned int ulBytesPerScan;
-	unsigned int ul4BytesPerScan;
-	unsigned int ulBytesRemain;
+	unsigned int ul_bytes_per_scan;
+	unsigned int ul_4_bytes_per_scan;
+	unsigned int ul_bytes_remain;
 	unsigned int de_ctrl = 0;
-	unsigned char ajRemain[4];
+	unsigned char aj_remain[4];
 	int i, j;
 
-	startBit &= 7; /* Just make sure the start bit is within legal range */
-	ulBytesPerScan = (width + startBit + 7) / 8;
-	ul4BytesPerScan = ulBytesPerScan & ~3;
-	ulBytesRemain = ulBytesPerScan & 3;
+	start_bit &= 7; /* Just make sure the start bit is within legal range */
+	ul_bytes_per_scan = (width + start_bit + 7) / 8;
+	ul_4_bytes_per_scan = ul_bytes_per_scan & ~3;
+	ul_bytes_remain = ul_bytes_per_scan & 3;
 
 	if (accel->de_wait() != 0)
 		return -1;
@@ -345,7 +345,7 @@ int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
 	 * It is an address offset (128 bit aligned)
 	 * from the beginning of frame buffer.
 	 */
-	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, dBase);
+	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, dest_base);
 
 	/*
 	 * Program pitch (distance between the 1st points of two adjacent
@@ -353,9 +353,9 @@ int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
 	 * register uses pixel values. Need Byte to pixel conversion.
 	 */
 	write_dpr(accel, DE_PITCH,
-		  ((dPitch / bytePerPixel << DE_PITCH_DESTINATION_SHIFT) &
+		  ((dest_pitch / byte_per_pixel << DE_PITCH_DESTINATION_SHIFT) &
 		   DE_PITCH_DESTINATION_MASK) |
-		  (dPitch / bytePerPixel & DE_PITCH_SOURCE_MASK)); /* dpr10 */
+		  (dest_pitch / byte_per_pixel & DE_PITCH_SOURCE_MASK)); /* dpr10 */
 
 	/*
 	 * Screen Window width in Pixels.
@@ -363,17 +363,17 @@ int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
 	 * in frame buffer for a given point.
 	 */
 	write_dpr(accel, DE_WINDOW_WIDTH,
-		  ((dPitch / bytePerPixel << DE_WINDOW_WIDTH_DST_SHIFT) &
+		  ((dest_pitch / byte_per_pixel << DE_WINDOW_WIDTH_DST_SHIFT) &
 		   DE_WINDOW_WIDTH_DST_MASK) |
-		  (dPitch / bytePerPixel & DE_WINDOW_WIDTH_SRC_MASK));
+		  (dest_pitch / byte_per_pixel & DE_WINDOW_WIDTH_SRC_MASK));
 
 	 /*
 	  * Note: For 2D Source in Host Write, only X_K1_MONO field is needed,
 	  * and Y_K2 field is not used.
-	  * For mono bitmap, use startBit for X_K1.
+	  * For mono bitmap, use start_bit for X_K1.
 	  */
 	write_dpr(accel, DE_SOURCE,
-		  (startBit << DE_SOURCE_X_K1_SHIFT) &
+		  (start_bit << DE_SOURCE_X_K1_SHIFT) &
 		  DE_SOURCE_X_K1_MONO_MASK); /* dpr00 */
 
 	write_dpr(accel, DE_DESTINATION,
@@ -384,8 +384,8 @@ int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
 		  ((width << DE_DIMENSION_X_SHIFT) & DE_DIMENSION_X_MASK) |
 		  (height & DE_DIMENSION_Y_ET_MASK)); /* dpr08 */
 
-	write_dpr(accel, DE_FOREGROUND, fColor);
-	write_dpr(accel, DE_BACKGROUND, bColor);
+	write_dpr(accel, DE_FOREGROUND, fg_color);
+	write_dpr(accel, DE_BACKGROUND, bg_color);
 
 	de_ctrl = (rop2 & DE_CONTROL_ROP_MASK) |
 		DE_CONTROL_ROP_SELECT | DE_CONTROL_COMMAND_HOST_WRITE |
@@ -396,16 +396,16 @@ int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
 	/* Write MONO data (line by line) to 2D Engine data port */
 	for (i = 0; i < height; i++) {
 		/* For each line, send the data in chunks of 4 bytes */
-		for (j = 0; j < (ul4BytesPerScan / 4); j++)
-			write_dpPort(accel, *(unsigned int *)(pSrcbuf + (j * 4)));
+		for (j = 0; j < (ul_4_bytes_per_scan / 4); j++)
+			write_dp_port(accel, *(unsigned int *)(p_srcbuf + (j * 4)));
 
-		if (ulBytesRemain) {
-			memcpy(ajRemain, pSrcbuf + ul4BytesPerScan,
-			       ulBytesRemain);
-			write_dpPort(accel, *(unsigned int *)ajRemain);
+		if (ul_bytes_remain) {
+			memcpy(aj_remain, p_srcbuf + ul_4_bytes_per_scan,
+			       ul_bytes_remain);
+			write_dp_port(accel, *(unsigned int *)aj_remain);
 		}
 
-		pSrcbuf += srcDelta;
+		p_srcbuf += src_delta;
 	}
 
 	return 0;
diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
index 2c79cb730a0a..59e679961e96 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -190,19 +190,19 @@ void sm750_hw_set2dformat(struct lynx_accel *accel, int fmt);
 void sm750_hw_de_init(struct lynx_accel *accel);
 
 int sm750_hw_fillrect(struct lynx_accel *accel,
-		      u32 base, u32 pitch, u32 Bpp,
+		      u32 base, u32 pitch, u32 bytes_per_pixel,
 		      u32 x, u32 y, u32 width, u32 height,
 		      u32 color, u32 rop);
 
 /**
  * sm750_hm_copyarea
- * @sBase: Address of source: offset in frame buffer
- * @sPitch: Pitch value of source surface in BYTE
+ * @source_base: Address of source: offset in frame buffer
+ * @source_pitch: Pitch value of source surface in BYTE
  * @sx: Starting x coordinate of source surface
  * @sy: Starting y coordinate of source surface
- * @dBase: Address of destination: offset in frame buffer
- * @dPitch: Pitch value of destination surface in BYTE
- * @Bpp: Color depth of destination surface
+ * @dest_base: Address of destination: offset in frame buffer
+ * @dest_pitch: Pitch value of destination surface in BYTE
+ * @bytes_per_pixel: Color depth of destination surface
  * @dx: Starting x coordinate of destination surface
  * @dy: Starting y coordinate of destination surface
  * @width: width of rectangle in pixel value
@@ -210,34 +210,34 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
  * @rop2: ROP value
  */
 int sm750_hw_copyarea(struct lynx_accel *accel,
-		      unsigned int sBase, unsigned int sPitch,
+		      unsigned int source_base, unsigned int source_pitch,
 		      unsigned int sx, unsigned int sy,
-		      unsigned int dBase, unsigned int dPitch,
-		      unsigned int Bpp, unsigned int dx, unsigned int dy,
+		      unsigned int dest_base, unsigned int dest_pitch,
+		      unsigned int bytes_per_pixel, unsigned int dx, unsigned int dy,
 		      unsigned int width, unsigned int height,
 		      unsigned int rop2);
 
 /**
  * sm750_hw_imageblit
- * @pSrcbuf: pointer to start of source buffer in system memory
- * @srcDelta: Pitch value (in bytes) of the source buffer, +ive means top down
- *>-----      and -ive mean button up
- * @startBit: Mono data can start at any bit in a byte, this value should be
+ * @p_srcbuf: pointer to start of source buffer in system memory
+ * @src_delta: Pitch value (in bytes) of the source buffer, positive means top down
+ *>-----      and negative mean bottom up
+ * @start_bit: Mono data can start at any bit in a byte, this value should be
  *>-----      0 to 7
- * @dBase: Address of destination: offset in frame buffer
- * @dPitch: Pitch value of destination surface in BYTE
- * @bytePerPixel: Color depth of destination surface
+ * @dest_base: Address of destination: offset in frame buffer
+ * @dest_pitch: Pitch value of destination surface in BYTE
+ * @byte_per_pixel: Color depth of destination surface
  * @dx: Starting x coordinate of destination surface
  * @dy: Starting y coordinate of destination surface
  * @width: width of rectangle in pixel value
  * @height: height of rectangle in pixel value
- * @fColor: Foreground color (corresponding to a 1 in the monochrome data
- * @bColor: Background color (corresponding to a 0 in the monochrome data
+ * @fg_color: Foreground color (corresponding to a 1 in the monochrome data
+ * @bg_color: Background color (corresponding to a 0 in the monochrome data
  * @rop2: ROP value
  */
-int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
-		       u32 srcDelta, u32 startBit, u32 dBase, u32 dPitch,
-		       u32 bytePerPixel, u32 dx, u32 dy, u32 width,
-		       u32 height, u32 fColor, u32 bColor, u32 rop2);
+int sm750_hw_imageblit(struct lynx_accel *accel, const char *p_srcbuf,
+		       u32 src_delta, u32 start_bit, u32 dest_base, u32 dest_pitch,
+		       u32 byte_per_pixel, u32 dx, u32 dy, u32 width,
+		       u32 height, u32 fg_color, u32 bg_color, u32 rop2);
 
 #endif
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index a29faee91c78..4e2ca7263254 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -49,19 +49,19 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	}
 
 	/* now map mmio and vidmem */
-	sm750_dev->pvReg =
+	sm750_dev->p_v_reg =
 		ioremap(sm750_dev->vidreg_start, sm750_dev->vidreg_size);
-	if (!sm750_dev->pvReg) {
+	if (!sm750_dev->p_v_reg) {
 		pr_err("mmio failed\n");
 		ret = -EFAULT;
 		goto exit;
 	}
-	pr_info("mmio virtual addr = %p\n", sm750_dev->pvReg);
+	pr_info("mmio virtual addr = %p\n", sm750_dev->p_v_reg);
 
-	sm750_dev->accel.dpr_base = sm750_dev->pvReg + DE_BASE_ADDR_TYPE1;
-	sm750_dev->accel.dp_port_base = sm750_dev->pvReg + DE_PORT_ADDR_TYPE1;
+	sm750_dev->accel.dpr_base = sm750_dev->p_v_reg + DE_BASE_ADDR_TYPE1;
+	sm750_dev->accel.dp_port_base = sm750_dev->p_v_reg + DE_PORT_ADDR_TYPE1;
 
-	mmio750 = sm750_dev->pvReg;
+	mmio750 = sm750_dev->p_v_reg;
 	sm750_set_chip_type(sm750_dev->devid, sm750_dev->revid);
 
 	sm750_dev->vidmem_start = pci_resource_start(pdev, 0);
@@ -76,15 +76,15 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 		sm750_dev->vidmem_start, sm750_dev->vidmem_size);
 
 	/* reserve the vidmem space of smi adaptor */
-	sm750_dev->pvMem =
+	sm750_dev->p_v_mem =
 		ioremap_wc(sm750_dev->vidmem_start, sm750_dev->vidmem_size);
-	if (!sm750_dev->pvMem) {
-		iounmap(sm750_dev->pvReg);
+	if (!sm750_dev->p_v_mem) {
+		iounmap(sm750_dev->p_v_reg);
 		pr_err("Map video memory failed\n");
 		ret = -EFAULT;
 		goto exit;
 	}
-	pr_info("video memory vaddr = %p\n", sm750_dev->pvMem);
+	pr_info("video memory vaddr = %p\n", sm750_dev->p_v_mem);
 exit:
 	return ret;
 }
@@ -134,12 +134,12 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 		      ~(PANEL_DISPLAY_CTRL_DUAL_DISPLAY |
 			PANEL_DISPLAY_CTRL_DOUBLE_PIXEL);
 		switch (sm750_dev->pnltype) {
-		case sm750_24TFT:
+		case sm750_24_tft:
 			break;
-		case sm750_doubleTFT:
+		case sm750_double_tft:
 			val |= PANEL_DISPLAY_CTRL_DOUBLE_PIXEL;
 			break;
-		case sm750_dualTFT:
+		case sm750_dual_tft:
 			val |= PANEL_DISPLAY_CTRL_DUAL_DISPLAY;
 			break;
 		}
-- 
2.53.0

