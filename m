Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD6421773D
	for <linux-fbdev@vger.kernel.org>; Sat, 11 Apr 2026 15:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775921194; cv=none; b=XzM1MPti6pLObNTbPs4nFBEX55ehthqpODaU2SyDK4lEH2t66x7jIVc1gzMre7FvEb0IN6SfE95IY4QDHgOJVUiq5HSleX0+MUOPPgBNn8J/sWc3eFJfqEsu2tG632JX4yNqZ4Kepf6StvSMiiIXt7glEqbhvDdPkiVdJXQtbuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775921194; c=relaxed/simple;
	bh=fq9k4HS7wZTcCEwgEk9lzhSQnE2UXTvw9PCJzwZVIFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pB1HHVTf17ywaWjlCTFtm6IBLziev3U5CQ0yvdItxqpp5D+yVgC1T+w5WsFYBwYWYOI1jxWgwLOFKJFXt7rSrB+uZl+3IUga/4lVflD752I9ZdipXv99+cuIJw8fd3H/3Bw5+zAg0a0nulngW5p7EhkYXij1fDjO6FZWrE9qWDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPPKL4ea; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPPKL4ea"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c76c067bc51so1129621a12.0
        for <linux-fbdev@vger.kernel.org>; Sat, 11 Apr 2026 08:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775921192; x=1776525992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S2yzm7/HJQbzBsOcthAlts6qCBZnAR76KLWrUtFupiU=;
        b=CPPKL4ea7PWnbKmUNycqgEuMqcLQ+Bha2oJ0uhRniDYaQaQI4qlTkoE4AVpHmHPUDA
         yYMwsarROHsqqNGaJlYnpz2nGULj1gFCRTU9A2Mah5hPQbbBZpt+XhgUJ36F/5QgaKTK
         PcRIw9QAh1psiuE/OrUslyLoaC2sAfAks3mR7rFQ/o+wgmDJmKfmMUQ8ramb4WigTynI
         lie7tmZsw67dEp0JebmjYxNUDHxdfADRLWqKncLoE0uAvIkK8v5JHwdf+GWKQYteWP/l
         I0p1VAd7u2oI3NotgB6KNxjSb4qeoaGElsDNe0FWiUtg5iCK8WEsTGnQBkt1nDo2z+EU
         wptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775921192; x=1776525992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2yzm7/HJQbzBsOcthAlts6qCBZnAR76KLWrUtFupiU=;
        b=Oqhq1XK3IdMsLzjbmEcNSaFA3SVEXJYsUpuIJNbsc/P58AdlHsKcx3XQBnPLTHUXqD
         AebEuMlYkfv9GDS1lALkLI2RnMsBjsXZPvT0ELbGwLGucnHYB3bqcstgoAfy8xLihiO5
         nKNC6MhdWiCsPBzcT1I1MCQIuMRwndYJ5BLlbSvUVF3YVNzfEBIwDROCT+eans0YxYy4
         piYDuyEEzzWgFRGzqWFQSxuXAdD9+E7WaIU0la/LtH1FsyK4IEGX61b/Kway8tsSvp95
         RyPv0pYqykMgOCxpfApz4KI2Erb5Ye9eKAtGDpdyacaRv5leDvEaB1+9ZJqGevR55MeF
         doWQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ZAqJfQ9SZiFKGDJ+sZWmbFeRzv8/NclGQ7I8XirNHamzypD1UYnsOv/iUon8A6JhRD5khGUkvxRlpog==@vger.kernel.org
X-Gm-Message-State: AOJu0YxS83KqFjfZR2kaRw4qVupHXn6Z5Ngw9iB824IWIA7RcDpquwoH
	pFHt+ELjiCJDsvA2aJNEh39ufzpfw7KFl2rDPcrazj1iXuLgtUMfIbc5
X-Gm-Gg: AeBDiesumtivwj/J1x5U7w8OZDkwQbeUplZFnjX8qAITvcd920entEgaYzC/u/D4dLP
	3LFnwXr4gJG4qooh3Y9TpxLoXY+mflXtWqtk9hZAr3plVQ/DKUbH9xRearKW5ka4McRlC5CfAYa
	3dHTKB2zY+SvotM6EcTGxoZO/z9vzYXS+S54ul4zDsS7UdsDA4y7E9QVOb4Byy/bExS1QkR2awk
	l4ltOBAoG/h8jwGoLXPeqa9ZRQf7XspSEpkb9t2yiEh0X599twaa2jRIE3MffrtrHJtylG6aDXl
	fEwaC/YRp14fCylNEFSytjeOGqvM1+TrxH9qzsQs5Ra97t4f6zUZIgnXHGOvsEsC5gNNomNlNlm
	btn/em1n8LR8/0lOC1jyIGjTHHlVSLTEQgliQ7GGjAo31i5VzlcwFICyvWBizFGYDDlXWMVJs7P
	XHFK5LlHB1M0kgMUv2tzmt1Y0+2+WklEsRRWvLtqAXz46fD8rxXNbS0g9srIm5p8kX0w==
X-Received: by 2002:a17:903:1a6f:b0:2b0:7d6f:4627 with SMTP id d9443c01a7336-2b2d5a45f9dmr72344535ad.37.1775921191790;
        Sat, 11 Apr 2026 08:26:31 -0700 (PDT)
Received: from chandras-fedora.tail1a292d.ts.net ([14.195.131.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f2af90sm64077935ad.64.2026.04.11.08.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 08:26:31 -0700 (PDT)
From: Chandra Mouli Baskaran <bcmouli2006@gmail.com>
To: gregkh@linuxfoundation.org,
	andy@kernel.org
Cc: linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Chandra Mouli <bcmouli2006@gmail.com>
Subject: [PATCH] staging: fbtft: improve TODO comment clarity
Date: Sat, 11 Apr 2026 20:52:20 +0530
Message-ID: <20260411152220.89174-1-bcmouli2006@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chandra Mouli <bcmouli2006@gmail.com>

Clarify the TODO comment in fbtft_ops_damage_range() to
better describe that the current implementation updates
the entire displayinstead of only the modified region.

Signed-off-by: Chandra Mouli <bcmouli2006@gmail.com>
---
 drivers/staging/fbtft/fbtft-core.c | 74 +++++++++++++++---------------
 1 file changed, 38 insertions(+), 36 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index f427c0914..f011a6ebc 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -77,12 +77,12 @@ static int fbtft_request_one_gpio(struct fbtft_par *par,
 	struct device *dev = par->info->device;
 
 	*gpiop = devm_gpiod_get_index_optional(dev, name, index,
-					       GPIOD_OUT_LOW);
+						   GPIOD_OUT_LOW);
 	if (IS_ERR(*gpiop))
 		return dev_err_probe(dev, PTR_ERR(*gpiop), "Failed to request %s GPIO\n", name);
 
 	fbtft_par_dbg(DEBUG_REQUEST_GPIOS, par, "%s: '%s' GPIO\n",
-		      __func__, name);
+			  __func__, name);
 
 	return 0;
 }
@@ -112,15 +112,15 @@ static int fbtft_request_gpios(struct fbtft_par *par)
 		return ret;
 	for (i = 0; i < 16; i++) {
 		ret = fbtft_request_one_gpio(par, "db", i,
-					     &par->gpio.db[i]);
+						 &par->gpio.db[i]);
 		if (ret)
 			return ret;
 		ret = fbtft_request_one_gpio(par, "led", i,
-					     &par->gpio.led[i]);
+						 &par->gpio.led[i]);
 		if (ret)
 			return ret;
 		ret = fbtft_request_one_gpio(par, "aux", i,
-					     &par->gpio.aux[i]);
+						 &par->gpio.aux[i]);
 		if (ret)
 			return ret;
 	}
@@ -134,7 +134,7 @@ static int fbtft_backlight_update_status(struct backlight_device *bd)
 	bool polarity = par->polarity;
 
 	fbtft_par_dbg(DEBUG_BACKLIGHT, par, "%s: polarity=%d, power=%d\n", __func__,
-		      polarity, bd->props.power);
+			  polarity, bd->props.power);
 
 	if (!backlight_is_blank(bd))
 		gpiod_set_value(par->gpio.led[0], polarity);
@@ -172,7 +172,7 @@ void fbtft_register_backlight(struct fbtft_par *par)
 
 	if (!par->gpio.led[0]) {
 		fbtft_par_dbg(DEBUG_BACKLIGHT, par,
-			      "%s(): led pin not set, exiting.\n", __func__);
+				  "%s(): led pin not set, exiting.\n", __func__);
 		return;
 	}
 
@@ -183,8 +183,8 @@ void fbtft_register_backlight(struct fbtft_par *par)
 		par->polarity = true;
 
 	bd = backlight_device_register(dev_driver_string(par->info->device),
-				       par->info->device, par,
-				       &fbtft_bl_ops, &bl_props);
+					   par->info->device, par,
+					   &fbtft_bl_ops, &bl_props);
 	if (IS_ERR(bd)) {
 		dev_err(par->info->device,
 			"cannot register backlight device (%ld)\n",
@@ -199,7 +199,7 @@ void fbtft_register_backlight(struct fbtft_par *par)
 EXPORT_SYMBOL(fbtft_register_backlight);
 
 static void fbtft_set_addr_win(struct fbtft_par *par, int xs, int ys, int xe,
-			       int ye)
+				   int ye)
 {
 	write_reg(par, MIPI_DCS_SET_COLUMN_ADDRESS,
 		  (xs >> 8) & 0xFF, xs & 0xFF, (xe >> 8) & 0xFF, xe & 0xFF);
@@ -235,8 +235,8 @@ static void fbtft_update_display(struct fbtft_par *par, unsigned int start_line,
 	if (unlikely(par->debug & (DEBUG_TIME_FIRST_UPDATE |
 			DEBUG_TIME_EACH_UPDATE))) {
 		if ((par->debug & DEBUG_TIME_EACH_UPDATE) ||
-		    ((par->debug & DEBUG_TIME_FIRST_UPDATE) &&
-		    !par->first_update_done)) {
+			((par->debug & DEBUG_TIME_FIRST_UPDATE) &&
+			!par->first_update_done)) {
 			ts_start = ktime_get();
 			timeit = true;
 		}
@@ -251,7 +251,7 @@ static void fbtft_update_display(struct fbtft_par *par, unsigned int start_line,
 		end_line = par->info->var.yres - 1;
 	}
 	if (start_line > par->info->var.yres - 1 ||
-	    end_line > par->info->var.yres - 1) {
+		end_line > par->info->var.yres - 1) {
 		dev_warn(par->info->device,
 			 "%s: start_line=%u or end_line=%u is larger than max=%d. Shouldn't happen, will do full display update\n",
 			 __func__, start_line,
@@ -261,7 +261,7 @@ static void fbtft_update_display(struct fbtft_par *par, unsigned int start_line,
 	}
 
 	fbtft_par_dbg(DEBUG_UPDATE_DISPLAY, par, "%s(start_line=%u, end_line=%u)\n",
-		      __func__, start_line, end_line);
+			  __func__, start_line, end_line);
 
 	if (par->fbtftops.set_addr_win)
 		par->fbtftops.set_addr_win(par, 0, start_line,
@@ -359,15 +359,15 @@ static unsigned int chan_to_field(unsigned int chan, struct fb_bitfield *bf)
 }
 
 static int fbtft_fb_setcolreg(unsigned int regno, unsigned int red,
-			      unsigned int green, unsigned int blue,
-			      unsigned int transp, struct fb_info *info)
+				  unsigned int green, unsigned int blue,
+				  unsigned int transp, struct fb_info *info)
 {
 	unsigned int val;
 	int ret = 1;
 
 	fb_dbg(info,
-	       "regno=%u, red=0x%X, green=0x%X, blue=0x%X, trans=0x%X\n",
-	       regno, red, green, blue, transp);
+		   "regno=%u, red=0x%X, green=0x%X, blue=0x%X, trans=0x%X\n",
+		   regno, red, green, blue, transp);
 
 	switch (info->fix.visual) {
 	case FB_VISUAL_TRUECOLOR:
@@ -414,7 +414,9 @@ static void fbtft_ops_damage_range(struct fb_info *info, off_t off, size_t len)
 {
 	struct fbtft_par *par = info->par;
 
-	/* TODO: only mark changed area update all for now */
+	/* TODO: Optimize to update only the modified region instead
+	 * of refreshing the entire display.
+	 */
 	par->fbtftops.mkdirty(info, -1, 0);
 }
 
@@ -577,10 +579,10 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 
 	if (display->gamma_num && display->gamma_len) {
 		gamma_curves = devm_kcalloc(dev,
-					    display->gamma_num *
-					    display->gamma_len,
-					    sizeof(gamma_curves[0]),
-					    GFP_KERNEL);
+						display->gamma_num *
+						display->gamma_len,
+						sizeof(gamma_curves[0]),
+						GFP_KERNEL);
 		if (!gamma_curves)
 			return NULL;
 	}
@@ -793,10 +795,10 @@ int fbtft_register_framebuffer(struct fb_info *fb_info)
 		sprintf(text2, ", spi%d.%d at %d MHz", spi->controller->bus_num,
 			spi_get_chipselect(spi, 0), spi->max_speed_hz / 1000000);
 	fb_dbg(fb_info,
-	       "%s frame buffer, %dx%d, %d KiB video memory%s, fps=%lu%s\n",
-	       fb_info->fix.id, fb_info->var.xres, fb_info->var.yres,
-	       fb_info->fix.smem_len >> 10, text1,
-	       HZ / fb_info->fbdefio->delay, text2);
+		   "%s frame buffer, %dx%d, %d KiB video memory%s, fps=%lu%s\n",
+		   fb_info->fix.id, fb_info->var.xres, fb_info->var.yres,
+		   fb_info->fix.smem_len >> 10, text1,
+		   HZ / fb_info->fbdefio->delay, text2);
 
 	/* Turn on backlight if available */
 	if (fb_info->bl_dev) {
@@ -885,10 +887,10 @@ static int fbtft_init_display_from_property(struct fbtft_par *par)
 			}
 			/* make debug message */
 			fbtft_par_dbg(DEBUG_INIT_DISPLAY, par,
-				      "init: write_register:\n");
+					  "init: write_register:\n");
 			for (j = 0; j < i; j++)
 				fbtft_par_dbg(DEBUG_INIT_DISPLAY, par,
-					      "buf[%d] = %02X\n", j, buf[j]);
+						  "buf[%d] = %02X\n", j, buf[j]);
 
 			par->fbtftops.write_register(par, i,
 				buf[0], buf[1], buf[2], buf[3],
@@ -909,7 +911,7 @@ static int fbtft_init_display_from_property(struct fbtft_par *par)
 				buf[60], buf[61], buf[62], buf[63]);
 		} else if (val & FBTFT_OF_INIT_DELAY) {
 			fbtft_par_dbg(DEBUG_INIT_DISPLAY, par,
-				      "init: msleep(%u)\n", val & 0xFFFF);
+					  "init: msleep(%u)\n", val & 0xFFFF);
 			msleep(val & 0xFFFF);
 			val = values[++index];
 		} else {
@@ -1020,8 +1022,8 @@ int fbtft_init_display(struct fbtft_par *par)
 		case -2:
 			i++;
 			fbtft_par_dbg(DEBUG_INIT_DISPLAY, par,
-				      "init: mdelay(%d)\n",
-				      par->init_sequence[i]);
+					  "init: mdelay(%d)\n",
+					  par->init_sequence[i]);
 			mdelay(par->init_sequence[i++]);
 			break;
 		default:
@@ -1052,7 +1054,7 @@ static int fbtft_verify_gpios(struct fbtft_par *par)
 	int i;
 
 	if (pdata->display.buswidth != 9 &&  par->startbyte == 0 &&
-	    !par->gpio.dc) {
+		!par->gpio.dc) {
 		dev_err(par->info->device,
 			"Missing info about 'dc' gpio. Aborting.\n");
 		return -EINVAL;
@@ -1140,8 +1142,8 @@ static struct fbtft_platform_data *fbtft_properties_read(struct device *dev)
  * Return: 0 if successful, negative if error
  */
 int fbtft_probe_common(struct fbtft_display *display,
-		       struct spi_device *sdev,
-		       struct platform_device *pdev)
+			   struct spi_device *sdev,
+			   struct platform_device *pdev)
 {
 	struct device *dev;
 	struct fb_info *info;
@@ -1264,7 +1266,7 @@ void fbtft_remove_common(struct device *dev, struct fb_info *info)
 	par = info->par;
 	if (par)
 		fbtft_par_dbg(DEBUG_DRIVER_INIT_FUNCTIONS, par,
-			      "%s()\n", __func__);
+				  "%s()\n", __func__);
 	fbtft_unregister_framebuffer(info);
 	fbtft_framebuffer_release(info);
 }
-- 
2.53.0

