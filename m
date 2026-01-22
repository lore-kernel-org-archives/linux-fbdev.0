Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E47538BDA5
	for <linux-fbdev@vger.kernel.org>; Thu, 22 Jan 2026 03:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769051815; cv=none; b=rCq/hkoUuGwOZ7u9ydrpjkvDCvygIxJVz0HtTml9B6+aqSxdevLj0DRXfEFmXbeJdHEFHNEl4bubUxynsM5klhK0Y3kckAxPvdoOcRZV4qEg2y2sDDUSDrWOfq/hi3dzxwY80Y1Hh8S5kYcldi46HrW1q9R5KEr/xb35Z9h/Kjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769051815; c=relaxed/simple;
	bh=+MYoKC4GsgZniJRfFsr+5viMvEwYPUanOo3mvBb8WUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBxTx4Jn///T5mqpOG8DQXaWiQg2kqhAaag/SaRH5HLFKA/13p1QkJacUmF9modr5RZe665ks/ZY34Ii5Z2kk3G0YWi6vDcaD5VuPxhxjerSNVDjSn+wfBWAvSac/LV+DJkesUH6nE+62DrON/snNI9MwUaLVcinhIUPBTaRyEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NO6imYFl; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NO6imYFl"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a7a23f5915so3214485ad.2
        for <linux-fbdev@vger.kernel.org>; Wed, 21 Jan 2026 19:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769051808; x=1769656608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWQboeoR7+6YsMwaf3C2xb3O23tU5oXeb/k98XP/HFY=;
        b=NO6imYFlQtOUQVLEGyIP5iQzmy6LIp4dk80HZTCfFDz3DPIrHneSq71D1YN3rYmPpm
         I7q6sLyEmbHo2PKb/e8ZzrMUoe1Y7uTkxWpGNh6fCJ5CSg2H2lFAgaGbPUCpnjjGqUdc
         KtKCAWib6zPZpGnVNOsTZmS0gAFSk8ghpztI3OjfeCrszWOJpL5kSvmg1shZ1ksAfBac
         fBhcg6HR2cneOD6K9JPhd65bjqoptJlESGMOzGP1XsMHHfJcrzF0eDLMq37O+buVMkoL
         GV1guDRyDsEAnxGwweyi6sUaRGtV95tTC20rg9cQFzevJiXGPUGOBkKKuIu/q+M8ffcP
         hXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769051808; x=1769656608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nWQboeoR7+6YsMwaf3C2xb3O23tU5oXeb/k98XP/HFY=;
        b=S/RUH69Yis5ZtJVYwdknPql02CN+LCwBtTwk4iZ2kfDe1VoB39jdQGYofZn2yfNEkv
         paSdhGfZaGkKutKX5Z9ay62bnKwt83IJzLudK3ODzxMXKLSaHDQcD9rXchEnrE4WY2ay
         d5w0ElbmqHBVRaX1fZ+lz9CSmHf4hXgm/hAzFPlVTpcsPF/7OyWLmnuZByDf0pwTmLPN
         MoAq32S0AB0YhDdeiqyuLk4H8bNbJlMCqfqtRtudsnRbzCEynNdfoYSrlvclfYn81Xlc
         MFiXYn75g0m+5qipvcdOxX0QkxcYG9v+U+tKpAmnizVxoU6QUewekNEqnv3xqm3XYg63
         2/yA==
X-Gm-Message-State: AOJu0Yzxfl0Gu1s8Ak1VoeFsFjUQCdzJJ07fQv/kI2dxeIrLjlOPYvE3
	g3mmkYfA6MSgZ/4paJiUfs6SCwLvno4iYEJSL311XpP3d5SLwyYQ6Au4UdbmYw==
X-Gm-Gg: AZuq6aIwoUfW364PwJvK5Zisg7WaMYuf4Mm7nvS0D62+wdCNhajK0EQ3l/GB+hxx0O2
	/1APSrEfoccNDJ5pNyEJiTsbAgr+9Crr63f4FvCElCtbbgPRRdeSUvtZvr2UN+0Ou3nniBSxNiD
	mfnu6l6pub+gvSTZDaD1aJMLTFkxbxOlu9fuEEpBhcI/6ADZa3zGa6K0oV5nWxlD6EWGXHUxcVo
	9HyOEqWS9DsQ8TJN1/5yAZ9ZobhnBBwyCJx99Mcn1c1rCQ4r3UdRTaldaZAtnkpNxDSk306GFqx
	cIng2wRmlUwk/MSpu+WSGczm94XLG9WRJgQgIzlZszmx+TXtrEOZpoNjRektpb62jMRKVp8JQbT
	Apv9yDhBnIh0teEKjYEYZxQXyPUzgn7VPvN6SZ5YuUQNlNH064w/JrmM11nC1pGi6Gqrg1qPOBZ
	pEqAUMSIvsA2/KouPKRb9bUFwDgh5Fl+aa3CTjfxnh6Rg=
X-Received: by 2002:a17:902:e80f:b0:2a7:682b:50af with SMTP id d9443c01a7336-2a7682b521bmr74186085ad.40.1769051807610;
        Wed, 21 Jan 2026 19:16:47 -0800 (PST)
Received: from cmpatel-home.hsd1.or.comcast.net ([2601:1c0:5780:9200:5396:967a:93dd:83bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a719412d38sm155966625ad.87.2026.01.21.19.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 19:16:47 -0800 (PST)
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
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v8 2/2] staging: fbtft: Make framebuffer registration message debug-only
Date: Wed, 21 Jan 2026 19:16:35 -0800
Message-ID: <20260122031635.11414-2-chintanlike@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260122031635.11414-1-chintanlike@gmail.com>
References: <20260122031635.11414-1-chintanlike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The framebuffer registration message is informational only and not
useful during normal operation. Convert it to debug-level logging to
keep the driver quiet when working correctly.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Chintan Patel <chintanlike@gmail.com>

---
Changes in v8:
- Add Reviewed-by tag from Andy Shevchenko
- Add Suggested-by tag from Greg Kroah-Hartman

 drivers/staging/fbtft/fbtft-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 1b3b62950205..f427c0914907 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -792,11 +792,11 @@ int fbtft_register_framebuffer(struct fb_info *fb_info)
 	if (spi)
 		sprintf(text2, ", spi%d.%d at %d MHz", spi->controller->bus_num,
 			spi_get_chipselect(spi, 0), spi->max_speed_hz / 1000000);
-	fb_info(fb_info,
-		"%s frame buffer, %dx%d, %d KiB video memory%s, fps=%lu%s\n",
-		fb_info->fix.id, fb_info->var.xres, fb_info->var.yres,
-		fb_info->fix.smem_len >> 10, text1,
-		HZ / fb_info->fbdefio->delay, text2);
+	fb_dbg(fb_info,
+	       "%s frame buffer, %dx%d, %d KiB video memory%s, fps=%lu%s\n",
+	       fb_info->fix.id, fb_info->var.xres, fb_info->var.yres,
+	       fb_info->fix.smem_len >> 10, text1,
+	       HZ / fb_info->fbdefio->delay, text2);
 
 	/* Turn on backlight if available */
 	if (fb_info->bl_dev) {
-- 
2.43.0

