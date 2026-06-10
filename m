Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1849E274B5C
	for <linux-fbdev@vger.kernel.org>; Wed, 10 Jun 2026 02:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781059828; cv=none; b=KW1pvQKK+hTCILxfxJkH+vsdjQefXN1gs2v2KKfv0Qa9LLVXYE/CzQuz3mwHVt9jezoedhRQloHT5hcznNbbUVQxG4YT26IMI+yVSJrh+FftsNBQKusJ7EGfw1P3PcBF9pDDvQMooTvSX9G35raQCIV+hLm22THgTUidVe+zPZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781059828; c=relaxed/simple;
	bh=qqZUIAuofezY45TCSDHXYgH63SWhY1ip7eWShP9F73o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aDlK+IpLp2F4mAmU7RKN8LGlwNtXl40Pz410zvcGRoStvblVmaqCNktZrvePVZhu1goV0DgvOXYcGWmVb8Kjv6gKrLMJYTvn+uFECL6X84YBxe9UbskG8Oi3jL02qkPBWRm/Txfm1KMSFSLgcAR05/kzDoTE6vTJTuiOH0JSKns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnq8Tm4B; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnq8Tm4B"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8423f236418so3433928b3a.1
        for <linux-fbdev@vger.kernel.org>; Tue, 09 Jun 2026 19:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781059826; x=1781664626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=New9XIBi5RYOIip+hYx53iokI1SR5R7v21yzx2FBPSs=;
        b=nnq8Tm4BIm2woZV0ZSxL/T80/RE/VNjg7QCmXKBTYLHfEg8dOd3G0Jgt71OTnsGZfU
         x08LyVwEKihpdGZJCFNTfiPLNh2kd8pJrA8wnm094BOfPTPwEGCNdt2KBR+G0CjiDRT3
         MIagq1aivAAyTkLeMPPU9mSbM32zX3Kt4Lh2ACaDN4u+c49lf+2mxZb/X+l30EGttV4/
         r1Zn6FY3AYnHgP+u3TLg+5YsIFVHFAvGgCFwmKk5iG7C0c/UHqpgflFMI/xSFulXQNVX
         Rr0PpJ51kjRmO+km6oAJJ4K79akluVuwGukbi9heFhtBPCjr5cn1SLmgQpyxSUji+zyx
         kTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781059826; x=1781664626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=New9XIBi5RYOIip+hYx53iokI1SR5R7v21yzx2FBPSs=;
        b=V38x7FBbwuAclJO6oP2HSsaJ8w63DGJgm2Jc+ymFghLZbCfYV5YokWVCzSlTjjqhNh
         5VsCJ+tjDUJP5AZF1rVrJBC2s622toYehxwV7ExLnn03dZQwNLKnGGa16S48lSdOCzQY
         e2yyCh/y/Y7FUGD6zFQdc6O/f4EheQUZPnxKAdKHyH/MtogarFJtGnsLB3sHgseZh7Ab
         6+q9kGbHEOK1VLCQhBk0RyYq0qfh7Q3ZVsTqfPhJGnfg/PnC7wMry2cWub49lHPClkVp
         TmQKSCZkxcCbBKZR/qX2mqiiSZ5g9OJKaozHzviy/SaNKEYznmEDC/a66XlF4NxYIpat
         /TAQ==
X-Gm-Message-State: AOJu0Yx/jMasBKScVyEd5aQaIR+uSLpVS3ee8VOtPT+arv1vmc9VgJA2
	9QIO2vnaLudyGOULKOwJP5olUO286W6Uj6rLSs2uFZFZvS5MOEk9XbxJr4qQO7Ry
X-Gm-Gg: Acq92OEL/aQ85j5KvoTgVUmCIyWKvE6MhSqFWm+QHfjbUpAbQXRs01Gp48ur0oBj9nL
	vohVm1/X2qgQF2j+5ICJ+pFs9uCV7Szxy2c3kA2AnUUboPlP5GV4P1dSdWqNP7QsYmikC8kVYYs
	EieKIbHLm84QF/ALUMEfct2X/7MPcsFooBEpvaujBSOZNlpwm85Q7tdVisusUGuUsys/kskeGcx
	JbObV+SxlH+Dlj4vT7KLs+c4UjAQPwrZo9Ke4a2Sxn1bcAe51jF5iyf3L9EpozXxxPahr4ITIeK
	RZFeXS4dPpsqEr0y4tCQTpqaoJ9dkRa5zYKYdiovLNHwwooLK5T4qvxe8GCz/iZPiermQ+3Lp/F
	55U/5dTafSl3EnFuqTiqq+72JCPqxFa8UFLcxMybGXSeNAbf6714/+EER2NWdEDYS1PB/AIGQPp
	o5by2u3WjXQ07bJPShvcFhhAu7v0j/cry8Aua2xi0XGEF96Pwb/MUCtyISxZ1YwEx9m+M=
X-Received: by 2002:a05:6a00:4fc9:b0:842:5931:7b8c with SMTP id d2e1a72fcca58-842b0e20598mr22341362b3a.1.1781059826283;
        Tue, 09 Jun 2026 19:50:26 -0700 (PDT)
Received: from oslab.. (n058152109039.netvigator.com. [58.152.109.39])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842820e8e6asm22196451b3a.0.2026.06.09.19.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 19:50:25 -0700 (PDT)
From: Tuo Li <islituo@gmail.com>
To: simona@ffwll.ch,
	deller@gmx.de,
	tzimmermann@suse.de,
	kees@kernel.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tuo Li <islituo@gmail.com>
Subject: [PATCH v2] fbdev:modedb: fix a possible UAF in fb_find_mode()
Date: Wed, 10 Jun 2026 10:50:14 +0800
Message-ID: <20260610025014.5913-1-islituo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If mode_option is NULL, it is assigned from mode_option_buf:

  if (!mode_option) {
    fb_get_options(NULL, &mode_option_buf);
    mode_option = mode_option_buf;
  }

Later, name is assigned from mode_option:

  const char *name = mode_option;

However, mode_option_buf is freed before name is no longer used:

  kfree(mode_option_buf);

while name is still accessed by:

  if ((name_matches(db[i], name, namelen) ||

Since name aliases mode_option_buf, this may result in a
use-after-free.

Fix this by extending the lifetime of mode_option_buf until the end of the 
function and using scope-based resource management for cleanup.

Signed-off-by: Tuo Li <islituo@gmail.com>
---
v2:
* Use scope-based resource management instead of manual kfree() calls.
  Thanks to Helge Deller for the helpful advice.
---
 drivers/video/fbdev/core/modedb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/modedb.c b/drivers/video/fbdev/core/modedb.c
index 703d0b7aec32..b6926764a99c 100644
--- a/drivers/video/fbdev/core/modedb.c
+++ b/drivers/video/fbdev/core/modedb.c
@@ -626,7 +626,7 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 		 const struct fb_videomode *default_mode,
 		 unsigned int default_bpp)
 {
-	char *mode_option_buf = NULL;
+	char *mode_option_buf __free(kfree) = NULL;
 	int i;
 
 	/* Set up defaults */
@@ -724,7 +724,6 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 			res_specified = 1;
 		}
 done:
-		kfree(mode_option_buf);
 		if (cvt) {
 			struct fb_videomode cvt_mode;
 			int ret;
-- 
2.43.0

