Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7EF2E7360
	for <linux-fbdev@vger.kernel.org>; Sat, 18 Jul 2026 04:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784350632; cv=none; b=Kx0Tz3r8QnAxEn/4Lv+x89b+JjfJZyUDCJpbhkZIL19vHmb/oItTYDufGgtiSSyUu6kgdrpmr6RT5WuCJoNtX3Dpi9UTyAMkmiZm7blRsXfvDbC5jhhlMGkkeseOx13n5//k0wyVDeTGiwF2AXaKLGM8Bn2xCfn4ZUQtp1Dv/Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784350632; c=relaxed/simple;
	bh=TJUsfjnTqW01BqA4c2SrNKyLpzODeEISYa0BR5PUda0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bCvr8bUVcpbWYUF2D6sy+LAaegCLBPaHSf1HAU9mVhMlWWpw71M3IPCBE5T79bP09oyB2V1myaSORzC/CX0ff/xDBcq4Q0GPfGdnvDt2kYbOdvD2+jxo6ZspxLqMX7maqB7Fcocod2/R/UScAR0bNkhUKUmdG/fC95kvMmlEGOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qtxoxmY1; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtxoxmY1"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-697bd21fdc2so6372722a12.1
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Jul 2026 21:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784350629; x=1784955429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aF4697Uf41KJkQZyxlwdYFjyI6ttMNVshCuVIWwkfKI=;
        b=qtxoxmY173Ozxuxqx3VGpVVQCc6xDCZG3Uozdt/EkBqI010ot03fd9JL3L8240rRt3
         cyTfsnktawI2E22Uf32CpAgn4JeZK8nC5vYtmo5E4aeKP3ijLisiH+ceFdXG2GAXifF8
         eq/qz3yl9mXoWkDJmhHKMmTqOfo380dS2Y4coPXISQ3MbOm83Gy9w5JTtGXRe83fMmzg
         jjIXiPTVA6FNbWxYHBFBELbXzkkgKIol396EByzAufQcQ6yG45KCGXYwoVVS5cvkGJM7
         qboxM74podqU0ps37uNlzOEw4H1+YwWG+W2nDooYm3frmsXTE+NhLzLKnK0f27lmny0g
         vC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784350629; x=1784955429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aF4697Uf41KJkQZyxlwdYFjyI6ttMNVshCuVIWwkfKI=;
        b=VFmJ3aDlVBYjxOdN6+49d3vY61n8o2f+9HX7pNkghrS6vRON/9WuTbBH3ITiLUm2L7
         EsHU+gBq0W1LC0UD5SmnSP8fT3APF1PrAN7HOqdihV7fJwZGJ3AvS6AZooVLNqGdwUW4
         j8x0E55Z3H3KRehjC4Q4hGzsZevZ8jujPVX2dUtkaphuN3NAMF3qO6b/c4DN80CZIl3Z
         EweiQ7gti6pvcSkV4fvUm2WA9K1XiT5q0I4Yu66zOI/vC4B+CGJTy90QUudGcTxtsMPo
         7BD5xoKdZFA2TGrQl5c36zm+VaH1a/3H5F9ueU9G2Ye0b0hVwO+QkTT9oa2XrufEsT1a
         njmg==
X-Forwarded-Encrypted: i=1; AHgh+RpNDHYuG+MVvPwCR7btptFBUJ9oVVfqwVK+hPxCaOaPGJXwjaKlDRblbfpqZg9i9b+qopqbI8qStfwG8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqWQh/DzBcrOjLvEn3szDOrLSg6+4Q39JE8uQFREITsWE7qEGK
	CcXWB3aNAJRMG9rAR0id4jJqAfk7F13UVXnniQBYywKSzt+kmnuDbuu8
X-Gm-Gg: AfdE7clBkrgpEWgac9+d1vulckzyP1sy5B7/YyfLB7Ih2DasJi/N96QZWp97CGJIUwZ
	RukcDyWpbBiuh2sP4q+jQF7qgmux7Xu55gamNYRp4QEZ++agKUusz3B8ALy4OTqiwTGJo2HV9RR
	154ECClmeo/8UB5CkQJnWhvNSmh+PLefLx3Cj81BUPHpTttzdh19ILOTvkIOS0fo63d8DQ1uTct
	DUgSNzguRNahXUrlaR86vNxB67Z1nxjjYeOcYV0cgFJvQUYn5XhAXXeKr2G688fR/2MWE7KPh8X
	GnggVxH2qM11rP5XvF2LDo5pY3QBi6KEtuaikXZyxK0SnZFlk4g0xaF8mC9b5CS+i7s0njvJvPM
	CVQWy4BNSF11ntMb3/G7q1Djij38BtxhVRIrxjEf192VhQ+ItunZfiGMhCmPxGd3sAAIAuJ+bec
	RF9rcBdDkKo1vE40G4kXqmnJnGpT6n9IRYX2tgdrudzQ6bW9cDfovoC+o=
X-Received: by 2002:a17:907:6d09:b0:c15:fc9d:cf3c with SMTP id a640c23a62f3a-c16b48c1139mr259395066b.42.1784350628774;
        Fri, 17 Jul 2026 21:57:08 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c17009ae102sm168303166b.13.2026.07.17.21.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 21:57:08 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] staging: sm750fb: fix mono image source stride mismatch in lynxfb_ops_imageblit()
Date: Sat, 18 Jul 2026 09:56:41 +0500
Message-ID: <20260718045641.468640-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sm750_hw_imageblit() advances its monochrome source pointer by
src_delta per scanline, and computes the correct rounded-up stride
internally as:

	bytes_per_scan = (width + start_bit + 7) / 8;

Its only caller, lynxfb_ops_imageblit(), instead passes src_delta as
image->width >> 3. For widths not a multiple of 8 this under-counts
the stride, so the source pointer falls further behind the real
per-scanline layout on every line, corrupting the rendered image.

Use DIV_ROUND_UP() so the stride passed in matches what
sm750_hw_imageblit() already assumes.

Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 89c811e0806c..69e803f4f175 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -261,7 +261,7 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
 	spin_lock(&sm750_dev->slock);
 
 	sm750_dev->accel.de_imageblit(&sm750_dev->accel,
-				      image->data, image->width >> 3, 0,
+				      image->data, DIV_ROUND_UP(image->width, 8), 0,
 				      base, pitch, bpp,
 				      image->dx, image->dy,
 				      image->width, image->height,
-- 
2.55.0

