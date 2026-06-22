Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5837E375F87
	for <linux-fbdev@vger.kernel.org>; Mon, 22 Jun 2026 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782141931; cv=none; b=diJ0gkOR6KBc3nNF1K3xKzytNwZekAiNHGVX5y0f6RcCK5JyJitG86s8ttN0zOnIi75/BK+OFkwBTRRTIxlDmN47K0Q5WZXXYNJcnNtWbITo9tZ4NGi0ego3p9+bGg5VKR4q3Oe+DWS7V4LIlyJ1ww13AIOQb3PB452/Yd32bfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782141931; c=relaxed/simple;
	bh=UCCfXZMcMcEqgqVI6OLL/m0AKWbn2PnFEVkzPy7MuGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVlnXw3zSITeUYm7uUiI7ndP4XVxym74j0o+l8Tt9ytIiLJCd03uuOx4U6cMOGu9obwSaGDv7g1KlV+s0euGODjDl5XPTjzsqYRnwylZRkBm9qn8p4Q6MigmAZ9xWQEYf9F8a9C5NAbJtVMdWk2Wj5iBoXenFHqdeiBFtpKqkY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Md8AR45t; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Md8AR45t"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490bc6a7958so41938065e9.1
        for <linux-fbdev@vger.kernel.org>; Mon, 22 Jun 2026 08:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782141928; x=1782746728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FubD6UUHNGPZZFitz5KoKNPu5pJn+5BFMUFMa6xOq3M=;
        b=Md8AR45t4S0mSvw/qz2aTM6kKpY4KTwdBJ91MOiDfzpHEM4J07ogCKohxYT5NsB4fS
         mhfJuDSFLgI6gtwxpl9nSFLogzlxsRqLim8dNAbpJb9Px99Xv2xqyBhBrB/kas3CbCSn
         x08qoTs/JiDuo46W/DMEbEvTwvIvNQxhmGSd4OWLovO/QN3XdXeIx2LvK/EGrwVaWqqB
         fk+oK/UnQEdoiO50iuGYhwdxdM/uYTITymlsDr9051kI2cNRHLJuR40ymaVgT0P6wCmx
         3XUkUETmPsP+L070v4kwu/EJx29p5JL40NpKvEmIjJ5cHhnjtaR9Phy5EmCQSp/r07Q5
         c0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782141928; x=1782746728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FubD6UUHNGPZZFitz5KoKNPu5pJn+5BFMUFMa6xOq3M=;
        b=kr0YCFj2uc6700QeIgRQIMXEsnWvzv/Pt1UMmwoydmmE4trqlM4oDlo3gbXQr53JXh
         hZlNPJJkKTFlSATPFeGNJ8YLf5N/z++f6/1R3KZp7q9Oki8x2jmXGFeYI7ocpaBlfjYz
         5OULgXLfUyY2vyr6HZYuAZWCF060b3XhCa16nCBpuTxGMh7XJDVCoK5cXiijAEqGs+2l
         FiOX0/MjbS9wdxfxATfsCKOp4GHm4j0sxMhUvRP4pqEvLlPBYe/e463fZsiOIn8RQRiL
         hPO4tkOOl0uj0ut0Gz+yg8kcnlURy0imsH+y2rzUYNSiEBoEco4vPBUE5QdV74SBAc6F
         bz0w==
X-Forwarded-Encrypted: i=1; AFNElJ9GoHl6t2VkmhU1llEeLyLQ9z+COPyCK4iimawwlQx6j7fMS4bpW6KKgCpydE1p+CBV80v8TydewmAy7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIYbxAQVTYuVpnn0OLyDwROscrCytX+MKpif7SSnf9lyKhkttn
	ub3KueiJgJm1zaKHtvhnNQ+iBTLY0sUdDG27gS0m4gggiV+2DOp+YIUv
X-Gm-Gg: AfdE7cnuiTBY5sKQlRxDQD+Nl7e5liYrdILkgEEd+LbVNMGSiC2371O4Y+i8ov21On5
	s/o4H1qZ/1NAcx1BBOXG5uTZokv9BcpnFLbLkGhpbfiqX0YBLGiYNN+IvdTjECXfRo9BPiaGbd+
	b4nJToHIEX0PW39f7PfcbRqKalP6qiFv/Qi/LLlh/HS0SkTy2PnHwEC9rzRZUVD48aKVouCziwi
	wWHtB0Yf2ppzRzEutSMeho+BPywUGNnLE0uq4Ns+ufdvKGFRPDsqoQe3VrrmxwIg9FKWA2lZ3R/
	d5czvM4XZHWdX3EgjsgZscbfhhdNvZCQ0zPxbNOPArCvcSlDe3sDlOCq2sW0WTKfJ8ORSDevglG
	XF5CXoAYxZgls6eDacoEVGV2/5rITyrrVgp66Bc7ZPTMjspMyuUBHsXuSIReMsMoCh8zf8d/qP9
	wd5RpOvXVRZuPocgs1IEBup+cbTKo=
X-Received: by 2002:a05:600d:4448:20b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-49240a09f71mr161160105e9.6.1782141927772;
        Mon, 22 Jun 2026 08:25:27 -0700 (PDT)
Received: from anthony.local ([2a06:c701:49b2:4c00:12ff:e0ff:fea5:3d2e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492492338dasm217883655e9.1.2026.06.22.08.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 08:25:27 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: javierm@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	deller@gmx.de
Cc: azuddinadam@gmail.com,
	chintanlike@gmail.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH v2 4/4] staging: fbtft: remove fb_ssd1351 driver
Date: Mon, 22 Jun 2026 18:25:06 +0300
Message-ID: <20260622152506.78627-5-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622152506.78627-1-amit.barzilai22@gmail.com>
References: <20260622152506.78627-1-amit.barzilai22@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SSD1351 support was added to the ssd130x DRM driver. To avoid
confusion and irrelevant updates, the staging fb_ssd1351 driver is
removed.

Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
---
 drivers/staging/fbtft/Kconfig      |   5 -
 drivers/staging/fbtft/Makefile     |   1 -
 drivers/staging/fbtft/fb_ssd1351.c | 240 -----------------------------
 3 files changed, 246 deletions(-)
 delete mode 100644 drivers/staging/fbtft/fb_ssd1351.c

diff --git a/drivers/staging/fbtft/Kconfig b/drivers/staging/fbtft/Kconfig
index 92943564cb91..c8ea1a0f3fb0 100644
--- a/drivers/staging/fbtft/Kconfig
+++ b/drivers/staging/fbtft/Kconfig
@@ -133,11 +133,6 @@ config FB_TFT_SSD1331
 	help
 	  Framebuffer support for SSD1331
 
-config FB_TFT_SSD1351
-	tristate "FB driver for the SSD1351 LCD Controller"
-	help
-	  Framebuffer support for SSD1351
-
 config FB_TFT_ST7735R
 	tristate "FB driver for the ST7735R LCD Controller"
 	help
diff --git a/drivers/staging/fbtft/Makefile b/drivers/staging/fbtft/Makefile
index e9cdf0f0a7da..c230bf008fc7 100644
--- a/drivers/staging/fbtft/Makefile
+++ b/drivers/staging/fbtft/Makefile
@@ -28,7 +28,6 @@ obj-$(CONFIG_FB_TFT_SSD1305)     += fb_ssd1305.o
 obj-$(CONFIG_FB_TFT_SSD1306)     += fb_ssd1306.o
 obj-$(CONFIG_FB_TFT_SSD1305)     += fb_ssd1325.o
 obj-$(CONFIG_FB_TFT_SSD1331)     += fb_ssd1331.o
-obj-$(CONFIG_FB_TFT_SSD1351)     += fb_ssd1351.o
 obj-$(CONFIG_FB_TFT_ST7735R)     += fb_st7735r.o
 obj-$(CONFIG_FB_TFT_ST7789V)     += fb_st7789v.o
 obj-$(CONFIG_FB_TFT_TINYLCD)     += fb_tinylcd.o
diff --git a/drivers/staging/fbtft/fb_ssd1351.c b/drivers/staging/fbtft/fb_ssd1351.c
deleted file mode 100644
index 6736b09b2f45..000000000000
--- a/drivers/staging/fbtft/fb_ssd1351.c
+++ /dev/null
@@ -1,240 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/backlight.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/spi/spi.h>
-#include <linux/delay.h>
-#include <linux/string_choices.h>
-
-#include "fbtft.h"
-
-#define DRVNAME		"fb_ssd1351"
-#define WIDTH		128
-#define HEIGHT		128
-#define GAMMA_NUM	1
-#define GAMMA_LEN	63
-#define DEFAULT_GAMMA	"0 2 2 2 2 2 2 2 " \
-			"2 2 2 2 2 2 2 2 " \
-			"2 2 2 2 2 2 2 2 " \
-			"2 2 2 2 2 2 2 2 " \
-			"2 2 2 2 2 2 2 2 " \
-			"2 2 2 2 2 2 2 2 " \
-			"2 2 2 2 2 2 2 2 " \
-			"2 2 2 2 2 2 2" \
-
-static void register_onboard_backlight(struct fbtft_par *par);
-
-static int init_display(struct fbtft_par *par)
-{
-	if (par->pdata &&
-	    par->pdata->display.backlight == FBTFT_ONBOARD_BACKLIGHT) {
-		/* module uses onboard GPIO for panel power */
-		par->fbtftops.register_backlight = register_onboard_backlight;
-	}
-
-	par->fbtftops.reset(par);
-
-	write_reg(par, 0xfd, 0x12); /* Command Lock */
-	write_reg(par, 0xfd, 0xb1); /* Command Lock */
-	write_reg(par, 0xae); /* Display Off */
-	write_reg(par, 0xb3, 0xf1); /* Front Clock Div */
-	write_reg(par, 0xca, 0x7f); /* Set Mux Ratio */
-	write_reg(par, 0x15, 0x00, 0x7f); /* Set Column Address */
-	write_reg(par, 0x75, 0x00, 0x7f); /* Set Row Address */
-	write_reg(par, 0xa1, 0x00); /* Set Display Start Line */
-	write_reg(par, 0xa2, 0x00); /* Set Display Offset */
-	write_reg(par, 0xb5, 0x00); /* Set GPIO */
-	write_reg(par, 0xab, 0x01); /* Set Function Selection */
-	write_reg(par, 0xb1, 0x32); /* Set Phase Length */
-	write_reg(par, 0xb4, 0xa0, 0xb5, 0x55); /* Set Segment Low Voltage */
-	write_reg(par, 0xbb, 0x17); /* Set Precharge Voltage */
-	write_reg(par, 0xbe, 0x05); /* Set VComH Voltage */
-	write_reg(par, 0xc1, 0xc8, 0x80, 0xc8); /* Set Contrast */
-	write_reg(par, 0xc7, 0x0f); /* Set Master Contrast */
-	write_reg(par, 0xb6, 0x01); /* Set Second Precharge Period */
-	write_reg(par, 0xa6); /* Set Display Mode Reset */
-	write_reg(par, 0xaf); /* Set Sleep Mode Display On */
-
-	return 0;
-}
-
-static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, int ye)
-{
-	write_reg(par, 0x15, xs, xe);
-	write_reg(par, 0x75, ys, ye);
-	write_reg(par, 0x5c);
-}
-
-static int set_var(struct fbtft_par *par)
-{
-	unsigned int remap;
-
-	if (par->fbtftops.init_display != init_display) {
-		/* don't risk messing up register A0h */
-		return 0;
-	}
-
-	remap = 0x60 | (par->bgr << 2); /* Set Colour Depth */
-
-	switch (par->info->var.rotate) {
-	case 0:
-		write_reg(par, 0xA0, remap | 0x00 | BIT(4));
-		break;
-	case 270:
-		write_reg(par, 0xA0, remap | 0x03 | BIT(4));
-		break;
-	case 180:
-		write_reg(par, 0xA0, remap | 0x02);
-		break;
-	case 90:
-		write_reg(par, 0xA0, remap | 0x01);
-		break;
-	}
-
-	return 0;
-}
-
-/*
- * Grayscale Lookup Table
- * GS1 - GS63
- * The driver Gamma curve contains the relative values between the entries
- * in the Lookup table.
- *
- * From datasheet:
- * 8.8 Gray Scale Decoder
- *
- *	there are total 180 Gamma Settings (Setting 0 to Setting 180)
- *	available for the Gray Scale table.
- *
- *	The gray scale is defined in incremental way, with reference
- *	to the length of previous table entry:
- *		Setting of GS1 has to be >= 0
- *		Setting of GS2 has to be > Setting of GS1 +1
- *		Setting of GS3 has to be > Setting of GS2 +1
- *		:
- *		Setting of GS63 has to be > Setting of GS62 +1
- *
- */
-static int set_gamma(struct fbtft_par *par, u32 *curves)
-{
-	unsigned long tmp[GAMMA_NUM * GAMMA_LEN];
-	int i, acc = 0;
-
-	for (i = 0; i < 63; i++) {
-		if (i > 0 && curves[i] < 2) {
-			dev_err(par->info->device,
-				"Illegal value in Grayscale Lookup Table at index %d : %d. Must be greater than 1\n",
-				i, curves[i]);
-			return -EINVAL;
-		}
-		acc += curves[i];
-		tmp[i] = acc;
-		if (acc > 180) {
-			dev_err(par->info->device,
-				"Illegal value(s) in Grayscale Lookup Table. At index=%d : %d, the accumulated value has exceeded 180\n",
-				i, acc);
-			return -EINVAL;
-		}
-	}
-
-	write_reg(par, 0xB8,
-		  tmp[0],  tmp[1],  tmp[2],  tmp[3],
-		  tmp[4],  tmp[5],  tmp[6],  tmp[7],
-		  tmp[8],  tmp[9],  tmp[10], tmp[11],
-		  tmp[12], tmp[13], tmp[14], tmp[15],
-		  tmp[16], tmp[17], tmp[18], tmp[19],
-		  tmp[20], tmp[21], tmp[22], tmp[23],
-		  tmp[24], tmp[25], tmp[26], tmp[27],
-		  tmp[28], tmp[29], tmp[30], tmp[31],
-		  tmp[32], tmp[33], tmp[34], tmp[35],
-		  tmp[36], tmp[37], tmp[38], tmp[39],
-		  tmp[40], tmp[41], tmp[42], tmp[43],
-		  tmp[44], tmp[45], tmp[46], tmp[47],
-		  tmp[48], tmp[49], tmp[50], tmp[51],
-		  tmp[52], tmp[53], tmp[54], tmp[55],
-		  tmp[56], tmp[57], tmp[58], tmp[59],
-		  tmp[60], tmp[61], tmp[62]);
-
-	return 0;
-}
-
-static int blank(struct fbtft_par *par, bool on)
-{
-	fbtft_par_dbg(DEBUG_BLANK, par, "(%s=%s)\n",
-		      __func__, str_true_false(on));
-	if (on)
-		write_reg(par, 0xAE);
-	else
-		write_reg(par, 0xAF);
-	return 0;
-}
-
-static struct fbtft_display display = {
-	.regwidth = 8,
-	.width = WIDTH,
-	.height = HEIGHT,
-	.gamma_num = GAMMA_NUM,
-	.gamma_len = GAMMA_LEN,
-	.gamma = DEFAULT_GAMMA,
-	.fbtftops = {
-		.init_display = init_display,
-		.set_addr_win = set_addr_win,
-		.set_var = set_var,
-		.set_gamma = set_gamma,
-		.blank = blank,
-	},
-};
-
-static int update_onboard_backlight(struct backlight_device *bd)
-{
-	struct fbtft_par *par = bl_get_data(bd);
-	bool on;
-
-	fbtft_par_dbg(DEBUG_BACKLIGHT, par, "%s: power=%d\n", __func__, bd->props.power);
-
-	on = !backlight_is_blank(bd);
-	/* Onboard backlight connected to GPIO0 on SSD1351, GPIO1 unused */
-	write_reg(par, 0xB5, on ? 0x03 : 0x02);
-
-	return 0;
-}
-
-static const struct backlight_ops bl_ops = {
-	.update_status = update_onboard_backlight,
-};
-
-static void register_onboard_backlight(struct fbtft_par *par)
-{
-	struct backlight_device *bd;
-	struct backlight_properties bl_props = { 0, };
-
-	bl_props.type = BACKLIGHT_RAW;
-	bl_props.power = BACKLIGHT_POWER_OFF;
-
-	bd = backlight_device_register(dev_driver_string(par->info->device),
-				       par->info->device, par, &bl_ops,
-				       &bl_props);
-	if (IS_ERR(bd)) {
-		dev_err(par->info->device,
-			"cannot register backlight device (%ld)\n",
-			PTR_ERR(bd));
-		return;
-	}
-	par->info->bl_dev = bd;
-
-	if (!par->fbtftops.unregister_backlight)
-		par->fbtftops.unregister_backlight = fbtft_unregister_backlight;
-}
-
-FBTFT_REGISTER_DRIVER(DRVNAME, "solomon,ssd1351", &display);
-
-MODULE_ALIAS("spi:" DRVNAME);
-MODULE_ALIAS("platform:" DRVNAME);
-MODULE_ALIAS("spi:ssd1351");
-MODULE_ALIAS("platform:ssd1351");
-
-MODULE_DESCRIPTION("SSD1351 OLED Driver");
-MODULE_AUTHOR("James Davies");
-MODULE_LICENSE("GPL");
-- 
2.54.0

