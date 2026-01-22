Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C9B3B8BCD
	for <linux-fbdev@vger.kernel.org>; Thu, 22 Jan 2026 03:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769051812; cv=none; b=JvJX/iveK3zHlzitnq14KZrIVk52ul+pQmDXQ1+cpd7YJmLM4qt3UrQjereQs768r+uKZadCFhQKeoif9oBTIfqvqIvNfg/RLGQuDuDGaTuPd+TH18VzVI4n9cW/Bw92FFmHniUnMUk3nypWe9K5SaWsk2nhM7SxhTMgGRiSo7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769051812; c=relaxed/simple;
	bh=fB4qFDnLcEuztYyiCjd+RjPOd463HVI1jnS3oHKE1Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jBOfBM5v0GZE0kHvtt/DoaNS8NizrBQnpGGEPaDLMIcghxy1VI1y6N31Q3THqNX7pd8/CfQ2sBhRT/TgEXHBIW5qzNB4qZNiZaB4taAbayAkMQ7z8KKZZlRCGdA/xbvE+Sdz5oLjYAGlU47n0r60BPwMHy+ib3hq0NT5E8Gubwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdCwq7/R; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdCwq7/R"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a7bced39cfso4927305ad.1
        for <linux-fbdev@vger.kernel.org>; Wed, 21 Jan 2026 19:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769051805; x=1769656605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GfgKMmP8DcncE4pa4cHunaIBJ+0sSublRL5+ZWYWWN8=;
        b=FdCwq7/RVhb1nKkgHtTfqVNu6f75/PSCpOZhnuLXN+VdHp+97TwU2QEVf0Jt7vU6p2
         dbPSLA80XIZFnlnhZRcu3nhdLRuU4Y+bR1vbaCRmviTxonYTheur6sfcPClFsRBBHYMC
         46vgDzPpjLhzUg0IQRFxFJBbeA73pDCZ4SqyoJEA0nscJW27Y3TwBn6wfY2+f7sAu+P4
         /fRqJAUm864gjZGpVjN9l3mqm0A5NzZYZTcZMxkJzeiJOHaPWdc2AwqQDkFordHRw0ey
         TLoGiWvskM7655ssXohM9N+ghgW1oXL4SCFAGO7K5tDLmJooZR81gcyJmqRZ3jCWEa5R
         MYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769051805; x=1769656605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfgKMmP8DcncE4pa4cHunaIBJ+0sSublRL5+ZWYWWN8=;
        b=WgKLOf8PtCLAH17sIoq5mKfhWABwkRW45ZrpBU3HnviTyc6iC1/HUM3ih639PEd4gQ
         W0+jIAqVMz8mCZtEuSkMiiBRpk9uFkMwMOGigICOoZY+DLY8QKSC25GNkqq5b430l3tk
         RGqE/JN5YCH8dmle1ickGoUA8yHpyDspCPGRs6+ePTVuyHKuSUH6X0LElBd2Rs8OBBlW
         qWweCnP40SBF9yaKax0H0qETqrBkS1bLP/H8SB/MI/IkVT8atugoId0N7WWzHNhkIamk
         1Orv2QJG6Ncp4dNY63sK7A3eSU0TgQq18y6sRXLYi8d3xVBLsnSuOkG91jWpj+qd2Haa
         0FKQ==
X-Gm-Message-State: AOJu0Yxt+XPOdjTYybXK00XsD2DcTNO7cEPtPO1uGxgpIRd4kNzKbe5G
	QKmixSjiBjQRBjh5WVA91/NUGPjyjS2AU6zLQovIn/s58fAYlmz763yMXx6N5Q==
X-Gm-Gg: AZuq6aLVDCBs+t6gaOqImwo/WAtvt+9JPeMJ4a6hiUImk9BDP7NVSDui7yvK9K1+WE0
	5aV5syv9ZEe5uFHU1R7iasHWVREvZN7IEPYrXLnqLPWJfA1RHb9MZ1SORtqi3BcMUInSI4Sm0U+
	b0uS8ym3mKxbpD7stc985w5lCJdsdAGt7QaDzm/tls6FM8Jnl0sEEizr+Yjf9n8zadKUGD1XgtI
	pz0Ur/J8hqLULL/+NLngNIgjyP5Bh7ZohWc8DSNAtCkr0VJmc8ayKnqlEgZLW21EdC39LjJIBN+
	ijhPw5IuuQl/mdE4Lv3Dt16RcgSFw/A/8pi1ZF1DTN3rcmFL3RcwNdY+edX/EECpAdaREL//TR+
	/2Kud5rpgBmI3cr9ztZjv/5A+4Yj257o2+cjlY2jixwsX1D8dqZ1FNSBb92VTP3fmEcDhnglSsl
	2sgnylw+e3pfCHaYpr0eNWiOys+nKNyRPgpQBDW9NWhhg=
X-Received: by 2002:a17:902:cf41:b0:29e:fd60:2cf9 with SMTP id d9443c01a7336-2a76b169703mr73811165ad.54.1769051804927;
        Wed, 21 Jan 2026 19:16:44 -0800 (PST)
Received: from cmpatel-home.hsd1.or.comcast.net ([2601:1c0:5780:9200:5396:967a:93dd:83bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a719412d38sm155966625ad.87.2026.01.21.19.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 19:16:44 -0800 (PST)
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
	kernel test robot <lkp@intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v8 1/2] staging: fbtft: Fix build failure when CONFIG_FB_DEVICE=n
Date: Wed, 21 Jan 2026 19:16:34 -0800
Message-ID: <20260122031635.11414-1-chintanlike@gmail.com>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Chintan Patel <chintanlike@gmail.com>

---
Changes in v8:
- Add Reviewed-by tag from Andy Shevchenko.

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

