Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793C213C9CA;
	Thu, 25 Jul 2024 13:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721912647; cv=none; b=RJWWcBsHcnJs46bclmRALsOFaOCFmMFGE9sM83eC2nA7s3T9aFrf6Gou6vDg0AfRFkzgX8mmLLrSY2f3zjG8OZ6hOb1B28OOIxarJjSyDXBpvzeC1BSwtAFqDlKJBQIJCduN6NVdbCUUXsfmwlfL5JaKkcoju6sGo4MHDpuEVHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721912647; c=relaxed/simple;
	bh=0ux3gSZ0RwVHtg81k8EMXGBBrFxDRxwiJkb/a8kIDro=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hGVzfpmTxiz2f9Mf9ugtrRbeTarRA+vxENhTiI42OYzU/PPCJbyWR1Xtt2rUjawir3Lo+lL2cKxbQ2wLSWR1KDXUv8XWPa7xo5EJXrcGd//GdYwiHjlLJPp7mtfDT8fE/GQr4NNMLkXykASAWpYgKdeWWEUSUPn/r0CvApdWXBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYq6JMcu; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYq6JMcu"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc569440e1so8287985ad.3;
        Thu, 25 Jul 2024 06:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721912644; x=1722517444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=htR/TjEega3Xdoyd2U7cTKVJo8sifGC+rB79lc342S0=;
        b=cYq6JMcu2tCwmdZv4Vw4CApXcfomRibmCvquZRRaHrHh2qslsroL0LMRG9/vaBQ3NK
         jYIQPuv4vnD25n8kdfJi3pbuE4ZheLoJXJDez1HCan6Nj2Pphm8MTxX5f2nxNGz6ID3s
         W/KsYnutTqW/YMym0W/OhuRhCCa+G4vk5Uu3rbU8WNyg260b8ffMEeGPUfx/9KmkRO0h
         NFM0wYFnbQSRI77o7Bl1OZUu8L4hBEVXZUWlTxXH575eoeb+VWoiG50WkxF2u5ingart
         oDTgmKFzSDj8TU+oh16tkMzsSurEXU4ocF7oCxWIUGoKX+s4t3sBzdxUNEfMxgE2b/Rj
         HUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721912644; x=1722517444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htR/TjEega3Xdoyd2U7cTKVJo8sifGC+rB79lc342S0=;
        b=H6UKWtkQFCrCBIblbZi91AEDxNvQCXeJtR/etDksJ6hKOieLGmoojBmqz7tdGsYa+M
         fa5aah5t5jmgOKdYOAwcyDLdUyFzyOo0A5JsxL+qCGQ/ayPpsOZEPA1gqg37MzMUVnhN
         dmI3NfTAsu+f7ohYUxMFQKmHH95Wihb4wCJqg7BVLULfj+idR1PMjwekIJSveEpKRRaX
         GsmsW0GP6/oLMVVMKpUqLSVJEgzzqBi8/o3WiGHAfcKC3td62dRbtVmTYzC6TWqwKLjs
         pOM6mxfZQCb3v1ZgI6PZtpBme8WGZL9RbHnCd7QWSJXyPEe+mzgrpG8Oqzk8D2YEUbqB
         iwhw==
X-Forwarded-Encrypted: i=1; AJvYcCXZAmzsaV5/vpSx6iFJEaXWGx7E8nLEciOZG6pZTO0SNFC2mhXc8J6qxiMBE5oUeFUTMD4c9cVjqp+zkJh8I6XZWI/3cAYF3pWD06clUBc9U1GxdHX39hIT+cdF94rpOHJlluitXtA4XEc=
X-Gm-Message-State: AOJu0Yxh+oyAvBUHkQCOl4V/CqfNo39gcwwUmccnLO9hYUYDx2HtesmS
	Rp57wTPAowzbgnLZdgDrrrD3LqviZfKAMLme5czJHWHU7pFQgnoX
X-Google-Smtp-Source: AGHT+IFMmE+nocadv/NdjT7aJFWB1HBf8V3DC7AItFnPS0nDWB5PQLmaOSzRiNHRpf4bWxkkes37fw==
X-Received: by 2002:a17:902:ea11:b0:1fb:6663:b647 with SMTP id d9443c01a7336-1fed3870ecbmr33764625ad.3.1721912643414;
        Thu, 25 Jul 2024 06:04:03 -0700 (PDT)
Received: from Riyan.inspiron ([122.176.205.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fcc493sm13516995ad.282.2024.07.25.06.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 06:04:02 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH] staging: fbtft: Remove ftrace-like logging
Date: Thu, 25 Jul 2024 18:33:51 +0530
Message-Id: <20240725130351.14877-1-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adhere to Linux kernel coding style

Reported by checkpatch:

WARNING: Unnecessary ftrace-like logging - prefer using ftrace

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
 drivers/staging/fbtft/fb_ili9320.c  | 2 --
 drivers/staging/fbtft/fb_ra8875.c   | 7 -------
 drivers/staging/fbtft/fb_sh1106.c   | 3 ---
 drivers/staging/fbtft/fb_ssd1289.c  | 3 ---
 drivers/staging/fbtft/fb_ssd1306.c  | 3 ---
 drivers/staging/fbtft/fb_ssd1325.c  | 9 ---------
 drivers/staging/fbtft/fb_ssd1331.c  | 2 --
 drivers/staging/fbtft/fb_ssd1351.c  | 3 ---
 drivers/staging/fbtft/fb_uc1611.c   | 3 ---
 drivers/staging/fbtft/fbtft-bus.c   | 9 ---------
 drivers/staging/fbtft/fbtft-core.c  | 7 -------
 drivers/staging/fbtft/fbtft-sysfs.c | 4 ----
 12 files changed, 55 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ili9320.c b/drivers/staging/fbtft/fb_ili9320.c
index 0be7c2d51548..050fc2367c12 100644
--- a/drivers/staging/fbtft/fb_ili9320.c
+++ b/drivers/staging/fbtft/fb_ili9320.c
@@ -35,8 +35,6 @@ static int init_display(struct fbtft_par *par)
 	par->fbtftops.reset(par);
 
 	devcode = read_devicecode(par);
-	fbtft_par_dbg(DEBUG_INIT_DISPLAY, par, "Device code: 0x%04X\n",
-		      devcode);
 	if ((devcode != 0x0000) && (devcode != 0x9320))
 		dev_warn(par->info->device,
 			 "Unrecognized Device code: 0x%04X (expected 0x9320)\n",
diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb_ra8875.c
index 398bdbf53c9a..0ab1de6647d0 100644
--- a/drivers/staging/fbtft/fb_ra8875.c
+++ b/drivers/staging/fbtft/fb_ra8875.c
@@ -41,13 +41,6 @@ static int init_display(struct fbtft_par *par)
 {
 	gpiod_set_value(par->gpio.dc, 1);
 
-	fbtft_par_dbg(DEBUG_INIT_DISPLAY, par,
-		      "%s()\n", __func__);
-	fbtft_par_dbg(DEBUG_INIT_DISPLAY, par,
-		      "display size %dx%d\n",
-		par->info->var.xres,
-		par->info->var.yres);
-
 	par->fbtftops.reset(par);
 
 	if ((par->info->var.xres == 320) && (par->info->var.yres == 240)) {
diff --git a/drivers/staging/fbtft/fb_sh1106.c b/drivers/staging/fbtft/fb_sh1106.c
index 9685ca516a0e..e4c50c1ffed0 100644
--- a/drivers/staging/fbtft/fb_sh1106.c
+++ b/drivers/staging/fbtft/fb_sh1106.c
@@ -88,9 +88,6 @@ static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, int ye)
 
 static int blank(struct fbtft_par *par, bool on)
 {
-	fbtft_par_dbg(DEBUG_BLANK, par, "(%s=%s)\n",
-		      __func__, on ? "true" : "false");
-
 	write_reg(par, on ? 0xAE : 0xAF);
 
 	return 0;
diff --git a/drivers/staging/fbtft/fb_ssd1289.c b/drivers/staging/fbtft/fb_ssd1289.c
index f27bab38b3ec..255a6d21ca8e 100644
--- a/drivers/staging/fbtft/fb_ssd1289.c
+++ b/drivers/staging/fbtft/fb_ssd1289.c
@@ -93,9 +93,6 @@ static int set_var(struct fbtft_par *par)
 {
 	if (par->fbtftops.init_display != init_display) {
 		/* don't risk messing up register 11h */
-		fbtft_par_dbg(DEBUG_INIT_DISPLAY, par,
-			      "%s: skipping since custom init_display() is used\n",
-			      __func__);
 		return 0;
 	}
 
diff --git a/drivers/staging/fbtft/fb_ssd1306.c b/drivers/staging/fbtft/fb_ssd1306.c
index 6cf9df579e88..478d710469b9 100644
--- a/drivers/staging/fbtft/fb_ssd1306.c
+++ b/drivers/staging/fbtft/fb_ssd1306.c
@@ -148,9 +148,6 @@ static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, int ye)
 
 static int blank(struct fbtft_par *par, bool on)
 {
-	fbtft_par_dbg(DEBUG_BLANK, par, "(%s=%s)\n",
-		      __func__, on ? "true" : "false");
-
 	if (on)
 		write_reg(par, 0xAE);
 	else
diff --git a/drivers/staging/fbtft/fb_ssd1325.c b/drivers/staging/fbtft/fb_ssd1325.c
index 796a2ac3e194..256b0b87a930 100644
--- a/drivers/staging/fbtft/fb_ssd1325.c
+++ b/drivers/staging/fbtft/fb_ssd1325.c
@@ -72,10 +72,6 @@ static uint8_t rgb565_to_g16(u16 pixel)
 
 static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, int ye)
 {
-	fbtft_par_dbg(DEBUG_SET_ADDR_WIN, par,
-		      "%s(xs=%d, ys=%d, xe=%d, ye=%d)\n", __func__, xs, ys, xe,
-		      ye);
-
 	write_reg(par, 0x75);
 	write_reg(par, 0x00);
 	write_reg(par, 0x3f);
@@ -86,9 +82,6 @@ static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, int ye)
 
 static int blank(struct fbtft_par *par, bool on)
 {
-	fbtft_par_dbg(DEBUG_BLANK, par, "(%s=%s)\n",
-		      __func__, on ? "true" : "false");
-
 	if (on)
 		write_reg(par, 0xAE);
 	else
@@ -109,8 +102,6 @@ static int set_gamma(struct fbtft_par *par, u32 *curves)
 {
 	int i;
 
-	fbtft_par_dbg(DEBUG_INIT_DISPLAY, par, "%s()\n", __func__);
-
 	for (i = 0; i < GAMMA_LEN; i++) {
 		if (i > 0 && curves[i] < 1) {
 			dev_err(par->info->device,
diff --git a/drivers/staging/fbtft/fb_ssd1331.c b/drivers/staging/fbtft/fb_ssd1331.c
index ec5eced7f8cb..06b7056d6c71 100644
--- a/drivers/staging/fbtft/fb_ssd1331.c
+++ b/drivers/staging/fbtft/fb_ssd1331.c
@@ -167,8 +167,6 @@ static int set_gamma(struct fbtft_par *par, u32 *curves)
 
 static int blank(struct fbtft_par *par, bool on)
 {
-	fbtft_par_dbg(DEBUG_BLANK, par, "(%s=%s)\n",
-		      __func__, on ? "true" : "false");
 	if (on)
 		write_reg(par, 0xAE);
 	else
diff --git a/drivers/staging/fbtft/fb_ssd1351.c b/drivers/staging/fbtft/fb_ssd1351.c
index ca2cba2185ae..aa8c1ff2a13c 100644
--- a/drivers/staging/fbtft/fb_ssd1351.c
+++ b/drivers/staging/fbtft/fb_ssd1351.c
@@ -72,9 +72,6 @@ static int set_var(struct fbtft_par *par)
 
 	if (par->fbtftops.init_display != init_display) {
 		/* don't risk messing up register A0h */
-		fbtft_par_dbg(DEBUG_INIT_DISPLAY, par,
-			      "%s: skipping since custom init_display() is used\n",
-			       __func__);
 		return 0;
 	}
 
diff --git a/drivers/staging/fbtft/fb_uc1611.c b/drivers/staging/fbtft/fb_uc1611.c
index f61e373c75e9..ca35b386a12d 100644
--- a/drivers/staging/fbtft/fb_uc1611.c
+++ b/drivers/staging/fbtft/fb_uc1611.c
@@ -135,9 +135,6 @@ static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, int ye)
 
 static int blank(struct fbtft_par *par, bool on)
 {
-	fbtft_par_dbg(DEBUG_BLANK, par, "(%s=%s)\n",
-		      __func__, on ? "true" : "false");
-
 	if (on)
 		write_reg(par, 0xA8 | 0x00);
 	else
diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 3d422bc11641..30e436ff19e4 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -129,9 +129,6 @@ int fbtft_write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
 	int ret = 0;
 	size_t startbyte_size = 0;
 
-	fbtft_par_dbg(DEBUG_WRITE_VMEM, par, "%s(offset=%zu, len=%zu)\n",
-		      __func__, offset, len);
-
 	remain = len / 2;
 	vmem16 = (u16 *)(par->info->screen_buffer + offset);
 
@@ -182,9 +179,6 @@ int fbtft_write_vmem16_bus9(struct fbtft_par *par, size_t offset, size_t len)
 	int i;
 	int ret = 0;
 
-	fbtft_par_dbg(DEBUG_WRITE_VMEM, par, "%s(offset=%zu, len=%zu)\n",
-		      __func__, offset, len);
-
 	if (!par->txbuf.buf) {
 		dev_err(par->info->device, "%s: txbuf.buf is NULL\n", __func__);
 		return -1;
@@ -232,9 +226,6 @@ int fbtft_write_vmem16_bus16(struct fbtft_par *par, size_t offset, size_t len)
 {
 	u16 *vmem16;
 
-	fbtft_par_dbg(DEBUG_WRITE_VMEM, par, "%s(offset=%zu, len=%zu)\n",
-		      __func__, offset, len);
-
 	vmem16 = (u16 *)(par->info->screen_buffer + offset);
 
 	/* no need for buffered write with 16-bit bus */
diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 8e2fd0c0fee2..ffa524dc945e 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -215,8 +215,6 @@ static void fbtft_reset(struct fbtft_par *par)
 	if (!par->gpio.reset)
 		return;
 
-	fbtft_par_dbg(DEBUG_RESET, par, "%s()\n", __func__);
-
 	gpiod_set_value_cansleep(par->gpio.reset, 1);
 	usleep_range(20, 40);
 	gpiod_set_value_cansleep(par->gpio.reset, 0);
@@ -1052,8 +1050,6 @@ static int fbtft_verify_gpios(struct fbtft_par *par)
 	struct fbtft_platform_data *pdata = par->pdata;
 	int i;
 
-	fbtft_par_dbg(DEBUG_VERIFY_GPIOS, par, "%s()\n", __func__);
-
 	if (pdata->display.buswidth != 9 &&  par->startbyte == 0 &&
 	    !par->gpio.dc) {
 		dev_err(par->info->device,
@@ -1157,9 +1153,6 @@ int fbtft_probe_common(struct fbtft_display *display,
 	else
 		dev = &pdev->dev;
 
-	if (unlikely(display->debug & DEBUG_DRIVER_INIT_FUNCTIONS))
-		dev_info(dev, "%s()\n", __func__);
-
 	pdata = dev->platform_data;
 	if (!pdata) {
 		pdata = fbtft_properties_read(dev);
diff --git a/drivers/staging/fbtft/fbtft-sysfs.c b/drivers/staging/fbtft/fbtft-sysfs.c
index 39e8d28066cb..e45c90a03a90 100644
--- a/drivers/staging/fbtft/fbtft-sysfs.c
+++ b/drivers/staging/fbtft/fbtft-sysfs.c
@@ -27,13 +27,9 @@ int fbtft_gamma_parse_str(struct fbtft_par *par, u32 *curves,
 	int curve_counter, value_counter;
 	int _count;
 
-	fbtft_par_dbg(DEBUG_SYSFS, par, "%s() str=\n", __func__);
-
 	if (!str || !curves)
 		return -EINVAL;
 
-	fbtft_par_dbg(DEBUG_SYSFS, par, "%s\n", str);
-
 	tmp = kmemdup(str, size + 1, GFP_KERNEL);
 	if (!tmp)
 		return -ENOMEM;
-- 
2.39.2

