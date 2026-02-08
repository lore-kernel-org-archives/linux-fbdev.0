Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58072E0B71
	for <linux-fbdev@vger.kernel.org>; Sun,  8 Feb 2026 18:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770576229; cv=none; b=uVeKWBGAmARs+xtFzvlWl2q58Yqw+fX1+vVXtRlcrPtsFy0nYYm2z/cV9hOGsh01zn/nzjRiu3EsO4pcQYAXn2yBBNwyGjNTpbt6qaiPwQ5LCFCcVNmGbrVlwqPKaRjEaojT+pNMoUxtbqa7/in+z5ytl9cLHrvgYL4l9q7iBoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770576229; c=relaxed/simple;
	bh=IPG39EmiAFIU1N1yFygi17LEFhtGUhrRN7ViGM3J6UA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqp0k+RR1vPaFxVUZLEgtnBeZ6zU6EbyDdlMUJzgI5OBTiPXQy7+epnGiIDax6GU2dV4v1qFL8Vv7qn50COZGMWX/4BCLWOdNJ4C3LYjnJ0nTGb1fFjeRt0Ztsw0SyaDEhi4A+6oURhMqSj1hBWO8AJQjzRZRByDCzf3/btHL6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLc8Wyjr; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLc8Wyjr"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-124a635476fso4976074c88.0
        for <linux-fbdev@vger.kernel.org>; Sun, 08 Feb 2026 10:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770576228; x=1771181028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hesCE33njiALK990vQilJYJRJ0u3PD+zd5giDtUEhfo=;
        b=VLc8WyjrfIbx4rLBZCjw5g62aIcHqY+sIQ1LsyFcoQ4aZUgR4KQZAF7KwxviRVPzuO
         cYcHj7BXAsjCLdMVO8L8sf5iOsMCCKc4a7dXPfZzpmYTGyUM7ElDTHh6LUaZKgT3gGJN
         xMMgcZFV+rUxmdh74nZTxLnyxTNbunCk6+KUFOmhVZCslTopyssXjhcGAvlNPGiHvWNu
         /ezTd0InSunkjd/hK1SDn2AgudUezXLJVAQ6AnypnObYC3LKbCtfRSFPVrJ9APygwFYS
         OKiRCyxq50BVm+KUOqXC6gaojfZZc8ihoEUcpRedie+8ZxrW1WIPUbJfVkS4VUFzeDaF
         N8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770576228; x=1771181028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hesCE33njiALK990vQilJYJRJ0u3PD+zd5giDtUEhfo=;
        b=HeDQbSS7yHNv7/7Cf8iyGo+JcAEeRVVt+iKlmjpY9a95fyLPbAEzEi2MvPlYvXbk3B
         uTtKhBcYR6oLf/sfqfpRwZHbQZZVwPCDhfNda+CRI8Q2drHB8UZx4WI0RZ3j48e8dm+t
         2dvyZnokAk6ibuw2+Ysyldb92Xf70vGpjBzmG3x2FSZh1N3imaKvEuT9YEscXsNOAphs
         XYXZe50Aam63kWJ1PfI2mC/Z+Z9ePY7xSIkhKmC5kpYIhrHWGV7LNmGKcuZsiK28ifry
         poTsrcllqTY0honsuxeaIlzyFIY1XkldkhnC93BSWEYarZME9UWbiTChaZFWtrJK6mK5
         JpDg==
X-Gm-Message-State: AOJu0Yx1FTH3UjwOEcpp7OX3GO04NeEOv0sTn57pMTOw2fuaXrJ6z3fc
	3UhrjcBUCgeqJKvlyUuBWRmhYZ2FV+w1kaeNLXtMuue6nQBKonR/aHs=
X-Gm-Gg: AZuq6aKk+2BKVLguHuZ+AQvdbT0Rebuud75FDm7AHVNvKp5w0ezTOYAcbaHhuczPykV
	M+cAajSkwkrOCES097x+Y0s9UBFF8GJWrjzcZK2icHwmqDJSrcPG7mO+6zMuaKrWO+zRox6mGp9
	oSUr7HLZML1uqafq1ZqpH+VSgneCZ6UMrwpV0W6yU0ctOyNG7j/TEAnEp0ljxBihCIDunoZcAmM
	Sv2wgoHIBwcAacdl7XGJ4SNzvrC2DXD/ly8AMFUolFn5IOGA/z15QAR1n3gEktpqIJ0FMTsLkGx
	k3FeYJOreilK/s27XCtV+5tZEN88W6YQdX3C8PRy5OFpz1vZhGm2BkdCYBkkGfdnqCNsiK02mBT
	rdesCwW3AU7VuXmudPwL9MyXA7VnjrRJ3Mtgus5yQxZkQpljZC6q+giRQOxCWv6d/WVaKmjMxxx
	LIKrZu2HxjOPNiEDh/ZIybr+s=
X-Received: by 2002:a05:7022:6712:b0:11e:3e9:3e8c with SMTP id a92af1059eb24-127040a3bf9mr5246881c88.49.1770576227759;
        Sun, 08 Feb 2026 10:43:47 -0800 (PST)
Received: from arch ([2601:647:6980:8130::7378])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1270d8e25f1sm5268865c88.9.2026.02.08.10.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 10:43:47 -0800 (PST)
From: Shreyas Ravi <shreyasravi320@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shreyas Ravi <shreyasravi320@gmail.com>
Subject: [PATCH v4 1/2] staging: sm750fb: Fix CamelCase variable names
Date: Sun,  8 Feb 2026 10:43:43 -0800
Message-ID: <20260208184344.657617-1-shreyasravi320@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026020842-litigator-flatworm-65d0@gregkh>
References: <2026020842-litigator-flatworm-65d0@gregkh>
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
Changes in v4:
- Fix merge conflicts (forgot to do in v3)

Changes in v3:
- Added changelog (missing in v2)

Changes in v2:
- Split original patch into two patches per Greg's feedback
- This patch only addresses CamelCase variable changes
---
 drivers/staging/sm750fb/sm750.c       | 34 ++++++++++-----------
 drivers/staging/sm750fb/sm750.h       | 16 +++++-----
 drivers/staging/sm750fb/sm750_accel.c | 22 +++++++-------
 drivers/staging/sm750fb/sm750_accel.h | 44 +++++++++++++--------------
 drivers/staging/sm750fb/sm750_hw.c    | 26 ++++++++--------
 5 files changed, 71 insertions(+), 71 deletions(-)

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
index 0f94d859e91c..b95b15128759 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
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
 
@@ -138,7 +138,7 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
  * @sy: Starting y coordinate of source surface
  * @dest_base: Address of destination: offset in frame buffer
  * @dest_pitch: Pitch value of destination surface in BYTE
- * @Bpp: Color depth of destination surface
+ * @bytes_per_pixel: Color depth of destination surface
  * @dx: Starting x coordinate of destination surface
  * @dy: Starting y coordinate of destination surface
  * @width: width of rectangle in pixel value
@@ -149,7 +149,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 		      unsigned int source_base, unsigned int source_pitch,
 		      unsigned int sx, unsigned int sy,
 		      unsigned int dest_base, unsigned int dest_pitch,
-		      unsigned int Bpp, unsigned int dx, unsigned int dy,
+		      unsigned int bytes_per_pixel, unsigned int dx, unsigned int dy,
 		      unsigned int width, unsigned int height,
 		      unsigned int rop2)
 {
@@ -249,9 +249,9 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	 * pixel values. Need Byte to pixel conversion.
 	 */
 	write_dpr(accel, DE_PITCH,
-		  ((dest_pitch / Bpp << DE_PITCH_DESTINATION_SHIFT) &
+		  ((dest_pitch / bytes_per_pixel << DE_PITCH_DESTINATION_SHIFT) &
 		   DE_PITCH_DESTINATION_MASK) |
-		  (source_pitch / Bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
+		  (source_pitch / bytes_per_pixel & DE_PITCH_SOURCE_MASK)); /* dpr10 */
 
 	/*
 	 * Screen Window width in Pixels.
@@ -259,9 +259,9 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	 * for a given point.
 	 */
 	write_dpr(accel, DE_WINDOW_WIDTH,
-		  ((dest_pitch / Bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
+		  ((dest_pitch / bytes_per_pixel << DE_WINDOW_WIDTH_DST_SHIFT) &
 		   DE_WINDOW_WIDTH_DST_MASK) |
-		  (source_pitch / Bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */
+		  (source_pitch / bytes_per_pixel & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */
 
 	if (accel->de_wait() != 0)
 		return -1;
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

