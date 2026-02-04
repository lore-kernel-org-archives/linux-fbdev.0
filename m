Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938AA38F94A
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Feb 2026 09:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770196528; cv=none; b=SzReqVxptXgSq4LdmET45nwht50KuvihBoIyY2jdoAODwKDATIJ4H5jqggpmbSwpXB0utfxnwT3Lbb+WLFohZz8g67UctFeTghra+bAxkDX+KmrIR695HqDWT7QVhUHEvlEs68l2mn+dHeVUXMOvxAMrt2sltjmjF/hJDgitwTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770196528; c=relaxed/simple;
	bh=XZn/GP+/Hn3BUIUk+YdmBk4Y4+sbl1x67i7eczPkN70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tut0qiD9UM/eCBLgiNJMnEwUx1UC4JIjjBFYr4Mb01PzvBVoXnCk8L7q9Na28ExenYWwwyXR2DB1jdSQby5rpEbsi4VduCbBOYzy9FG5uLibkOoLu4boUXF34y/DemKnVxoD4Zk/GvF2fqgP8sqdrLjOBcHmndIkdBsqelVWtEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rjAnYrWu; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rjAnYrWu"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-48068127f00so56247385e9.3
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Feb 2026 01:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770196526; x=1770801326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxehwfigTtxx4VEPi4AE7s7RcqfSuZjwJcd/po/KS5M=;
        b=rjAnYrWuKQqfBAk0gW1UCtRBPpJ3c6oTpbxtx494IzGl/xef8YMEdmz25BvDQfaWoB
         JoLZ+0pOeWJuDIYWPO0GL+fChEvxiCn35FNS6HvB+RHQUJiqVzRgRced5WwlScr7pyUr
         h2IayXOMuwyz9Ng5FTi/FBfq55Ht14nj6ZxTJ6rDVTIFAJJOYYhrsbdiGvVxjswKX3Ti
         tr+DplazPda38q4Yo8lUM6c3CWwRoTDrKX1/lax3sWEl2Ets+4vkrQf+cHyYV6BJX2mz
         nSjx5muSHCbzi0JcjwLrVDt+qBny9QlkPcItHIT3Jd8tt5Z2CjWZDNhwh8FNZJVm6gP2
         m1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770196526; x=1770801326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sxehwfigTtxx4VEPi4AE7s7RcqfSuZjwJcd/po/KS5M=;
        b=M2Anp0SJpwwHy1f9+0l9xyHwKLQ7hNlK5c1S1DRVEX6EKsXEKxlMwqH9NDpc/0P5k3
         gUlsHmMZ3I32tCIpDOnkEHXECVDj6C1mpDMmZoVLwqIA11VH8r66x5FVyTRe7Sg4rvwG
         Fo0kOVVYOgoDN2ybcjCu2wwj7BtpehLzQSBi7vy7uwKChP7UJEPBKiS3Jy8E6Fgja5u3
         Z9M+ZOyvF9sLKn8ShLw6N3zyINzzTi4CU3Q2OA2JpS4+pTgdmGpRwH/VJ80qm3ZEGkzS
         07+IMrnSRtjc+BP1xURfUCH3RsH8UCeVc8rfnkwkplnzgDLwT+f/SpTJ44gI7sUi9bec
         ApUg==
X-Forwarded-Encrypted: i=1; AJvYcCVjGGxJ9y3XcX4lkb5GxacJrqgVhEbw17FavPDtb1Qmr9DYFTfBclBsCEFoX0AB7pKICwC0R2bkbk8ZHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHZm78feyDDaKxZcnlsVjLxkmEnUjCA6LG0HY4Clvy4CIaKt2A
	JF03/kvLh5K4kDFzkzdC92xOqeUrWHXQWZhNGEJJn7hbI0NKMtuT4c+Cz6hlSbNfA+CHATPMhkB
	mpsUmG+U=
X-Gm-Gg: AZuq6aIgJCUHDo3Pdv4uIhhCAvpM3h1hfgaL6STYnK6DrL5bB4cSPx1vplhVw8T/MG5
	ZXpFxikCeA75dAdL28KWOIjxIo269kXvEQQs4iz7AVeKpGql+9petXXqfKFKS/B7doDAdBfucSW
	b4UfuEPjYSZ8BoPVUXABO1oBDod/PjPb+ldDqfB19a/zXNB93rn92M2w+Lfz01FBcBgX1ucwuMm
	9knX/+oNw8NsL7K6fL3QgK8hTqBbbthf4ymZgr2uwE8FJK9JqWdKVrXIMmC6leFBORmPLsOd9iB
	0Z4vGwToFBFw5tRGQj1ZS7iZx9j8P9XCyKseCWoI7q3z+uEL2ZD1I8vLZJgAqLvNDOYtDM1/kZi
	jcorDyTCgsB2gvnBMRa5QiV7VCO+COW5dyy0nwGYL/aUOuS+tHs/X6+AWTkTM+gfH2s8ZaDwsP6
	FVInuyPBPcimff/yjIIR+kTP3D5SZP1F2EJiR35NWhE8eQp+v5M7Nvm5vDTy3Ss+rJXK1TCxdCS
	t5zMVwu5JvB6Q==
X-Received: by 2002:a05:600c:5491:b0:477:6d96:b3e5 with SMTP id 5b1f17b1804b1-4830e922970mr30892105e9.7.1770196525981;
        Wed, 04 Feb 2026 01:15:25 -0800 (PST)
Received: from localhost (p200300f65f20eb0470629fa1229c2efb.dip0.t-ipconnect.de. [2003:f6:5f20:eb04:7062:9fa1:229c:2efb])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4361805f25dsm5179819f8f.29.2026.02.04.01.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 01:15:25 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v1 1/3] fbdev: au1100fb: Mark several local functions as static
Date: Wed,  4 Feb 2026 10:15:11 +0100
Message-ID:  <ceb08e29f6a07075b5ca63e4ed30c5051fddcdfd.1770196161.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770196161.git.u.kleine-koenig@baylibre.com>
References: <cover.1770196161.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3309; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=XZn/GP+/Hn3BUIUk+YdmBk4Y4+sbl1x67i7eczPkN70=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpgw4hHstF6LkWEYZBH5ROgc9ot9NDyxl7XRDK9 1O1RqBRKM2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaYMOIQAKCRCPgPtYfRL+ Ti8fB/9KhSErUK59/gPfkp1kl8W4UilXPUO1/xyJTht9qAnWvaeLAShYF1dKA9da4dZPIXkBWAs HfZ9rVe5ejz3J12Rbv9yGXNQr8b4CIpAl+9zRAZIsscRPSCZrPH+6Q96xAPzW2qg6Za1QB093E5 nntkz1wcPw9Et5KqTA+DUEjSJJoqPogV6MG3DOkxZUcoJkKBjZhkeiCI89Q+/33uzQlofLg3wVd RUX8X/8FomSolTzJAf3r9n04BngOdF5q/ZAMDxqQEmFZ5auEWBy3BDStUeqZU2SdnbofEzthqtW Iwcr8bqSOnVPyQUPgx1dREAITBCPkN3/unBJhc72UZ7BwurY
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This fixes several (fatal) compiler warnings à la

	drivers/video/fbdev/au1100fb.c:530:6: error: no previous prototype for ‘au1100fb_drv_remove’ [-Werror=missing-prototypes]
	  523 | void au1100fb_drv_remove(struct platform_device *dev)
	      |      ^~~~~~~~~~~~~~~~~~~

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/video/fbdev/au1100fb.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index feaa1061c436..4df470878b42 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -135,7 +135,7 @@ static int au1100fb_fb_blank(int blank_mode, struct fb_info *fbi)
  * Set hardware with var settings. This will enable the controller with a specific
  * mode, normally validated with the fb_check_var method
 	 */
-int au1100fb_setmode(struct au1100fb_device *fbdev)
+static int au1100fb_setmode(struct au1100fb_device *fbdev)
 {
 	struct fb_info *info;
 	u32 words;
@@ -234,7 +234,7 @@ int au1100fb_setmode(struct au1100fb_device *fbdev)
 /* fb_setcolreg
  * Set color in LCD palette.
  */
-int au1100fb_fb_setcolreg(unsigned regno, unsigned red, unsigned green, unsigned blue, unsigned transp, struct fb_info *fbi)
+static int au1100fb_fb_setcolreg(unsigned regno, unsigned red, unsigned green, unsigned blue, unsigned transp, struct fb_info *fbi)
 {
 	struct au1100fb_device *fbdev;
 	u32 *palette;
@@ -293,7 +293,7 @@ int au1100fb_fb_setcolreg(unsigned regno, unsigned red, unsigned green, unsigned
 /* fb_pan_display
  * Pan display in x and/or y as specified
  */
-int au1100fb_fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *fbi)
+static int au1100fb_fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *fbi)
 {
 	struct au1100fb_device *fbdev;
 	int dy;
@@ -340,7 +340,7 @@ int au1100fb_fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *fbi)
  * Map video memory in user space. We don't use the generic fb_mmap method mainly
  * to allow the use of the TLB streaming flag (CCA=6)
  */
-int au1100fb_fb_mmap(struct fb_info *fbi, struct vm_area_struct *vma)
+static int au1100fb_fb_mmap(struct fb_info *fbi, struct vm_area_struct *vma)
 {
 	struct au1100fb_device *fbdev = to_au1100fb_device(fbi);
 
@@ -522,7 +522,7 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 	return -ENODEV;
 }
 
-void au1100fb_drv_remove(struct platform_device *dev)
+static void au1100fb_drv_remove(struct platform_device *dev)
 {
 	struct au1100fb_device *fbdev = NULL;
 
@@ -547,7 +547,7 @@ void au1100fb_drv_remove(struct platform_device *dev)
 #ifdef CONFIG_PM
 static struct au1100fb_regs fbregs;
 
-int au1100fb_drv_suspend(struct platform_device *dev, pm_message_t state)
+static int au1100fb_drv_suspend(struct platform_device *dev, pm_message_t state)
 {
 	struct au1100fb_device *fbdev = platform_get_drvdata(dev);
 
@@ -564,7 +564,7 @@ int au1100fb_drv_suspend(struct platform_device *dev, pm_message_t state)
 	return 0;
 }
 
-int au1100fb_drv_resume(struct platform_device *dev)
+static int au1100fb_drv_resume(struct platform_device *dev)
 {
 	struct au1100fb_device *fbdev = platform_get_drvdata(dev);
 	int ret;
-- 
2.47.3

