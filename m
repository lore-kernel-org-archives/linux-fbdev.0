Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4192367AC
	for <linux-fbdev@vger.kernel.org>; Sat, 17 Jan 2026 04:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768624234; cv=none; b=h86f+sWFklLNU29icYSgPbOq2kgxsb29c6TIyPaZEYbBKaD+VvwxuDFZoUHKzTOI8cCBKqdiQ0TPTTYmD/7fBZPXh3pIwIfOvPH3+2vv0oXHW+RKCZ6R0JUs3jyAqWAiqdKMk7O8cWREzJ3KoYTT5G5tdcMzJSm126iFTV6xwrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768624234; c=relaxed/simple;
	bh=59/a8WTm/gWfCxzRJbq7yPBBnub6sQLN8ljF0PmknGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ahl2J/NLklnK32A3nvoVktFiquiVY6YXmsbyPFwb9W4ChwCHkb5ZmEarmRX4ygh523COJEK9/rjNJjtasjOCwnDwQVB8TjEjJYy0v4USh9nJVP0luiIg1w/MltjyIIJQ7JWrDTz39OVOPdfDUG0Sn//3oTzaOdFYah7yGGjRSDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dr8EaJNM; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dr8EaJNM"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34ab8e0df53so1852939a91.3
        for <linux-fbdev@vger.kernel.org>; Fri, 16 Jan 2026 20:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768624232; x=1769229032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vCrSsGPr19mQwGzLbkxTfgCN7ZB1b84ZZ1vrvJhEPMM=;
        b=Dr8EaJNMXexPCHjNVzP2tIXtWtLq1VV3hlIDdypVXriV/eSV06TE+kYD/yn/Kz3XHU
         8OYonGCjgY/bhj8t2FLPlkku3og3+eSfHUBcixadxhP6qh12AEt+pwZDCl4LF8JNpU8b
         BfiiZkwTO7nLNLYb1pW8mP2F4T/SbH1vFKLUKTjsgnCjL/UkVz6rKTk+buVAYhKpuuMe
         W9B5HgFtVlI9Fxn0maR4YFIbwGx0uzmbzAvX2bo85xM+yA7DKNRHDJWoKtkTsKbMSZBA
         3p2ImB3TXS3Cw/xAFbEmVbCSJWf9rBLzf7PqrAKXFWWD6WRvu/sW3//3CdojoCjnyI1p
         lP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768624232; x=1769229032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCrSsGPr19mQwGzLbkxTfgCN7ZB1b84ZZ1vrvJhEPMM=;
        b=b6D9tPoNBdKr74TmfJs/iLIV+Dsx9oLNgGS7fyo7zsWSpuiWuI/2FV/BBdBKwJDL+l
         lxlm+ephiCJ9movhn05ZwIj5G/unchNWv6bslsxMWKPDTv0RVKmfrlKGRJHETWBwuCKB
         E9DDiF0Qpni8+WOVZqY4Q0kzsva5g0KCMtoFvUlF39qC1hTDmwNpLaS27g6pWSn5R0sF
         zEWtz/vIW4nyD+PAzecP3DUZbAabUv0Wt/yd/Psf4M6fU3dngPRwR2Ikcf0HBy5p+3W9
         Ae8xue1/fHC+2En5RNEacaPVYQGCJPmHXBBaSls+azMR+PCGWqKEPc9MBt3Jfl4VbDmd
         gkMw==
X-Gm-Message-State: AOJu0YyDqrZR5BPRZkXyMjh2Cgycy1/TGgqkvb4cuTD7GoggwMH8zLXg
	0QhmiDSidNlvXucNsSS+BVREOHxR30Nje5l1vvznfbkvBzeAaEqlQ/rPMIxBqw==
X-Gm-Gg: AY/fxX7gHp8NiLxPfrYQgWo9SC22sEEvNMJwvm2F5uUHUqsxxVJMpZRi7RAnRJ2Jp7c
	lPYzaYTYAM02Kfw01YcKvwrSo9B/ma/CS/EqWTT/PePrvFEOLDP7ZXxqn8mg+zUBe3V72bB1WsG
	KcrJLPWgolGzIpG55vcHBBX3NI9Gl8rBt+xmIMlOqfOgwS85N+KPKt470qIwRxNGrGkapxwsTKs
	1/hdmj0U8YpBBcsmaYC4EFiD8dYxyaKsQqh8JQmCydw34nzO808QI6tPnFpTbqR47K9YOkKoRmY
	mSOzAUCCmY3m8NMnu7b1X/KDFHXouUNOst9c/I96cnvGKyU6+3/WR+sdfYhqrobMck5q43qjYgQ
	9b0qoQYqb2U5+waOHtz04Nl/itjIhwpSdhhFlaIb9uzDSR+fT8GqDyQQW3ZcDtH+0dLy9f95fGj
	/4Nyf0xKit42uOaSwVEED2ZQbuqssNWH7ZGQRi9ZGhuRo=
X-Received: by 2002:a17:902:f78a:b0:2a0:b066:3f55 with SMTP id d9443c01a7336-2a7174efc71mr45039245ad.10.1768624232460;
        Fri, 16 Jan 2026 20:30:32 -0800 (PST)
Received: from cmpatel-home.hsd1.or.comcast.net ([2601:1c0:5780:9200:26af:b454:d793:29de])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa108b23asm3370159b3a.3.2026.01.16.20.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 20:30:31 -0800 (PST)
From: Chintan Patel <chintanlike@gmail.com>
To: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	tzimmermann@suse.de,
	andy@kernel.org,
	deller@gmx.de,
	gregkh@linuxfoundation.org,
	Chintan Patel <chintanlike@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v7 1/2] staging: fbtft: Fix build failure when CONFIG_FB_DEVICE=n
Date: Fri, 16 Jan 2026 20:29:30 -0800
Message-ID: <20260117042931.6088-1-chintanlike@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_FB_DEVICE is disabled, struct fb_info does
not provide a valid dev pointer. Direct dereferences of
fb_info->dev therefore result in build failures.

Fix this by avoiding direct accesses to fb_info->dev and
switching the affected debug logging to framebuffer helpers
that do not rely on a device pointer.

This fixes the following build failure reported by the
kernel test robot.

Fixes: a06d03f9f238 ("staging: fbtft: Make FB_DEVICE dependency optional")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202601110740.Y9XK5HtN-lkp@intel.com
Signed-off-by: Chintan Patel <chintanlike@gmail.com>

---
Changes in v7:
- Split logging cleanups into a separate patch
- Limit this patch to the CONFIG_FB_DEVICE=n build fix only

Changes in v6:
- Switch debug/info logging to fb_dbg() and fb_info()(suggested by Thomas Zimmermann)
- Drop dev_of_fbinfo() usage in favor of framebuffer helpers that implicitly
  handle the debug/info context.
- Drop __func__ usage per review feedback(suggested by greg k-h)
- Add Fixes tag for a06d03f9f238 ("staging: fbtft: Make FB_DEVICE dependency optional")
  (suggested by Andy Shevchenko)

Changes in v5:
- Initial attempt to replace info->dev accesses using
  dev_of_fbinfo() helper

 drivers/staging/fbtft/fbtft-core.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 8a5ccc8ae0a1..1b3b62950205 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -365,9 +365,9 @@ static int fbtft_fb_setcolreg(unsigned int regno, unsigned int red,
 	unsigned int val;
 	int ret = 1;
 
-	dev_dbg(info->dev,
-		"%s(regno=%u, red=0x%X, green=0x%X, blue=0x%X, trans=0x%X)\n",
-		__func__, regno, red, green, blue, transp);
+	fb_dbg(info,
+	       "regno=%u, red=0x%X, green=0x%X, blue=0x%X, trans=0x%X\n",
+	       regno, red, green, blue, transp);
 
 	switch (info->fix.visual) {
 	case FB_VISUAL_TRUECOLOR:
@@ -391,8 +391,7 @@ static int fbtft_fb_blank(int blank, struct fb_info *info)
 	struct fbtft_par *par = info->par;
 	int ret = -EINVAL;
 
-	dev_dbg(info->dev, "%s(blank=%d)\n",
-		__func__, blank);
+	fb_dbg(info, "blank=%d\n", blank);
 
 	if (!par->fbtftops.blank)
 		return ret;
@@ -793,11 +792,11 @@ int fbtft_register_framebuffer(struct fb_info *fb_info)
 	if (spi)
 		sprintf(text2, ", spi%d.%d at %d MHz", spi->controller->bus_num,
 			spi_get_chipselect(spi, 0), spi->max_speed_hz / 1000000);
-	dev_info(fb_info->dev,
-		 "%s frame buffer, %dx%d, %d KiB video memory%s, fps=%lu%s\n",
-		 fb_info->fix.id, fb_info->var.xres, fb_info->var.yres,
-		 fb_info->fix.smem_len >> 10, text1,
-		 HZ / fb_info->fbdefio->delay, text2);
+	fb_info(fb_info,
+		"%s frame buffer, %dx%d, %d KiB video memory%s, fps=%lu%s\n",
+		fb_info->fix.id, fb_info->var.xres, fb_info->var.yres,
+		fb_info->fix.smem_len >> 10, text1,
+		HZ / fb_info->fbdefio->delay, text2);
 
 	/* Turn on backlight if available */
 	if (fb_info->bl_dev) {
-- 
2.43.0

