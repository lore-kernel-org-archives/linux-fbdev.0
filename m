Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6972701C4
	for <linux-fbdev@vger.kernel.org>; Sat,  7 Feb 2026 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770484377; cv=none; b=Kg7ykWYkVRZIQEfVA7yGKwsdyGMujK96nf36M+X4IbTjGtfTOCbpQaP2KbeTRhCOH7RuheSL1Hl8hps7gxpixbRPZxkyei2avEdjJZebff60N34Lu24ncfP7RGoHqwen2gvzCPKbmXaGwNfU+Tr5WoomMXIlAsZ7iMACtxGN340=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770484377; c=relaxed/simple;
	bh=EG7KrFeRIED1gbhtxHoC15RUdL9wU0F4wf7rqkzz7tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7atFbTbdZNGKIcxSPxFVCvwsx2pAMljR56r/lvceumDkjxahGduP2KETa3IBSwEk/FLo2HSJpt/dP4e4mvwxc+qkBbpXjpyDqXK3/k6Vov79RCrryJEJq/CfqzyzsMUHGU9t5qCm/ejxzxixtw4VeanuwF8OqvOfB69+kD90IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OR9tE+tP; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OR9tE+tP"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so41071155e9.1
        for <linux-fbdev@vger.kernel.org>; Sat, 07 Feb 2026 09:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770484376; x=1771089176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXVXB/RzJcoQAkIf6oAMqZB6mFdPuWSO4ccLVK1dTPE=;
        b=OR9tE+tPymkcnoxBIMTqOnT2dzgRDU/wzqkBZwwLND1/F5hWvIpcUqIJHHW3MZCYsj
         koItGsyZViutMB0Id3cw9UeOLdzkAspooqOa1E+22HzyiU3zLjge1S6g/RHuJtFpIsyR
         ezhlmsRWgdY+LNE2NIjB88CyKk5mbudCyToUvuVIP6c4ps5xE4xxBrYJBeON6Vj1BGh5
         0vtIxQxcFmRytoboR/ogOaRtUREh1pMQ7PCWjjIseLsEf28Kz514L5KEMByuVG87aUqC
         0cpyaITFdgRFFGevKdU4Z2YTcYKNZh+3hqu4xJQfOA3GGp/srFhqKUNF7ajqDzq9fmPI
         NETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770484376; x=1771089176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FXVXB/RzJcoQAkIf6oAMqZB6mFdPuWSO4ccLVK1dTPE=;
        b=wv6yOLiE3fELk0phCL8p9hyBq4wSo3UCC10Z6UJfwSFT93sS8BgzQHOFcFiDia0tQf
         S1a+PfLteneLHblwMJX5eCg3ap1Yvd6yXsroWjFiJn9nH5Y8JFv+DiSu4NzjihEv+uUq
         iXjnZxBsEQfYH7bfsVIiTCdCzlhpiCzfF/TxeHstNFt7vwHVgbSB+KPpks65mHxcmvd9
         zaiWY3WoX5PDh4+noMQTr+dByrQGA7k3aT8qr8o1Q+EhcsY9bmM70dKtQU5uQbOZW588
         BdGzWZiZswvFfQXUcvnesGGcQicQCl4zXyx/hs4JF+Mdgr6yXs6bNT+MyW0cVt3nDXR2
         kZjA==
X-Forwarded-Encrypted: i=1; AJvYcCWhXC2TvnH8JrDSlR5QfDjChi3lXehuihfA8Y0IQszeI4Uh/WBNSNcHXVsH6NDTeRxx2JGcrNeDxLP+yA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzG++JLk7mF6Qgi+3+zQTbB8aprUap+RtZp/W4H0NKisNkWKE4E
	i2i+T9w1P4Xava8RBJrjP+pusPZCjuJ4BNLUmgNn1fpFB2sv9zkwb8QkcTaQftcyfdA=
X-Gm-Gg: AZuq6aLvGhFtPwymkK7Bd0Bk3N9LKC43Vy/nUzYbOiyhOVSXKIyqdSt6FSWB6Hvngf4
	1eUTePy7YFFzoa1e83p49CKzw4JcxPwp1qKbxzWoYL2NSo45E08qRsSeyoQ03SWf25uSNhPmfrs
	4nE5jd4FrdizL5X7g8CDzSaVWtrTBv122bzFOT0k4BqWc06qoh8xhd4Xo0MwF37tHU6cf+0Nceo
	GR98g3rCgu5tF+uuvDqT2mlq6wZRRa6SVOO4mskgLksjXUqj0WgRIx3pCfQ+aNGd+PyoV3YFty2
	dMflFjpw0M9xVMmOC64yYJBz7D8IUddNHlafNeP8twxMbbatlhO7cUiXGf+osP3+6LLJ6/mnROc
	r/5gwNIOC+EEhYKYrPvwsbFcOo2G4pzNELISYZa9a4BBY68KOQSXGSe7dmC2FaZesjZ3zgQdKLI
	nYT5fRiCjiCLEzKzvr
X-Received: by 2002:a05:6000:2285:b0:427:526:16aa with SMTP id ffacd0b85a97d-436293b6ae1mr9317004f8f.58.1770484375231;
        Sat, 07 Feb 2026 09:12:55 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4362972fa4csm12998827f8f.26.2026.02.07.09.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 09:12:54 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 2/4] fbdev: au1100fb: Mark several local functions as static
Date: Sat,  7 Feb 2026 18:12:35 +0100
Message-ID:  <dc4836214dbfe43166aab995565d298eeffc6e10.1770483674.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770483674.git.u.kleine-koenig@baylibre.com>
References: <cover.1770483674.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2951; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=EG7KrFeRIED1gbhtxHoC15RUdL9wU0F4wf7rqkzz7tY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBph3KHq6rxnqaXyH8CRgWR8k7VU41sfl4SOr57S JYxEBHN2feJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaYdyhwAKCRCPgPtYfRL+ TvfWB/0eou3LaLVyjLyoRxmllOT+kj1XkAGQWR8L2z5YdO3tEpJVBcMfxRZXO+D1WLZZgcgb1iC 4mQVMxG7vocZy+zCz+3/3ggWGh4v/bq9tmZ8vy2hzcRo68Rby9FG9sFnR1gUqS3Rz0H7NJjhsRn QoYXRxl3LynLyDXxZvu6iI948pRXZ8fBp5ptJf1EADgTKbYU7RRqknr2HcrzqDYfu8aSqlzKmjW HNjEjqYuKj+Xfblf/5uVO4DsKRewH/htc4z1yi6Zhm5eqWkw13akBuOr2V3m9YwsOPfuUEaw6c0 B6Q7mNSvAm/mFlOOoVDOzk4omnGTfLPsuhG4+epPjlEhKtC3
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This fixes several (fatal) compiler warnings à la

	drivers/video/fbdev/au1100fb.c:530:6: error: no previous prototype for ‘au1100fb_drv_remove’ [-Werror=missing-prototypes]
	  523 | void au1100fb_drv_remove(struct platform_device *dev)
	      |      ^~~~~~~~~~~~~~~~~~~

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/video/fbdev/au1100fb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index 75344ee080f3..beba8befaec9 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -120,7 +120,7 @@ static int au1100fb_fb_blank(int blank_mode, struct fb_info *fbi)
  * Set hardware with var settings. This will enable the controller with a specific
  * mode, normally validated with the fb_check_var method
 	 */
-int au1100fb_setmode(struct au1100fb_device *fbdev)
+static int au1100fb_setmode(struct au1100fb_device *fbdev)
 {
 	struct fb_info *info;
 	u32 words;
@@ -219,7 +219,7 @@ int au1100fb_setmode(struct au1100fb_device *fbdev)
 /* fb_setcolreg
  * Set color in LCD palette.
  */
-int au1100fb_fb_setcolreg(unsigned regno, unsigned red, unsigned green, unsigned blue, unsigned transp, struct fb_info *fbi)
+static int au1100fb_fb_setcolreg(unsigned regno, unsigned red, unsigned green, unsigned blue, unsigned transp, struct fb_info *fbi)
 {
 	struct au1100fb_device *fbdev;
 	u32 *palette;
@@ -278,7 +278,7 @@ int au1100fb_fb_setcolreg(unsigned regno, unsigned red, unsigned green, unsigned
 /* fb_pan_display
  * Pan display in x and/or y as specified
  */
-int au1100fb_fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *fbi)
+static int au1100fb_fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *fbi)
 {
 	struct au1100fb_device *fbdev;
 	int dy;
@@ -325,7 +325,7 @@ int au1100fb_fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *fbi)
  * Map video memory in user space. We don't use the generic fb_mmap method mainly
  * to allow the use of the TLB streaming flag (CCA=6)
  */
-int au1100fb_fb_mmap(struct fb_info *fbi, struct vm_area_struct *vma)
+static int au1100fb_fb_mmap(struct fb_info *fbi, struct vm_area_struct *vma)
 {
 	struct au1100fb_device *fbdev = to_au1100fb_device(fbi);
 
@@ -517,7 +517,7 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 	return -ENODEV;
 }
 
-void au1100fb_drv_remove(struct platform_device *dev)
+static void au1100fb_drv_remove(struct platform_device *dev)
 {
 	struct au1100fb_device *fbdev = NULL;
 
@@ -559,7 +559,7 @@ static int au1100fb_drv_suspend(struct platform_device *dev, pm_message_t state)
 	return 0;
 }
 
-int au1100fb_drv_resume(struct platform_device *dev)
+static int au1100fb_drv_resume(struct platform_device *dev)
 {
 	struct au1100fb_device *fbdev = platform_get_drvdata(dev);
 	int ret;
-- 
2.47.3

