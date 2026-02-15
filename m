Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16FD2BB13
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 23:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198428; cv=none; b=m9FCW1S5k2MFgBDnm9rpO+FLMAQeyX79sE19BQrmUM3RtCz71Ltgnmon7v8cS1CrzzBzMKul4WZGcoXKf1PcT4+UXxGBH3V1DGJAgYp7w3TVGkQ1Fs1bs7+Sj9iLdrocLx8bySlhkTI1MXgy7aUR2kO2ojZltUJzXtCCtUQb+0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198428; c=relaxed/simple;
	bh=cNISZOqeKk8QMk5edubEElUWhcYpjBpybGx8Xr4QHLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ko7gu1w1DAfcOJ9kIZqcO/8YMlTVtQHtOBZkMrquHT1YNAh30qAVHV8tT/1ZAVNqBKACHdy0zsZHrSosG1g7czeA0AJJb+1ejDr+ahdD8ViorpcOjpyXuVNSBF/LOfiVb1TwVEUUfumfS1F/JTAFE2EB6dxu0mUb3iDsvxOuYP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1C7UJBbU; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1C7UJBbU"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-483487335c2so23784525e9.2
        for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 15:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771198425; x=1771803225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ivo/Wb4H9AjzUdzXBvtBO+/I7i8l2LirEG2mTIslkVQ=;
        b=1C7UJBbU00oh3zvE2IY8tv/7GSKRCvXkNv0NuAmND/DNu0t9+BdFSoIMakJnt3U80+
         uusy9nsYGEzg4xeS8aLtto/zo0bk0i+PuX/Og72D8YsOTcGid8J3K9gaAe5Y1ImB0S4y
         aEpRq7C3Fho3uvsp+/XZ8MelvAlPbIgZf2TDUE/sUg7oGVXFiHGSH2IVl/owe0C+riaM
         bMGrhi2Y6KnSF6J+bWgS9H312dup8I0DI7mxSgMj1xKNpN2owF6Fea24MleSJSMdj9jI
         PFfbWvgylpdW5HFBrh0/5Sa8UgPgi1zZAvwMO1o1nYJrRYCFCuHJRA+KGIG2Qhq7ul3R
         xkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771198425; x=1771803225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ivo/Wb4H9AjzUdzXBvtBO+/I7i8l2LirEG2mTIslkVQ=;
        b=kjm5nDluKGrz0wJ4+5B+Q8gunyDJjrozijQMvLKGqmf5/rVOMEIlhYxw0Osv3z/7nj
         K7wyBzLx2/8a+c+YB+xzBgH4fMkoytBDsGjIKMCxoS1112oRU0Zqlw85f/fqSu1w99H0
         y/FS5TRRTSkKsCCeMv6kK7OaUNkNhoDrfxJkwJ/v36wXTnUTRa9ALybSL+i0e5XkOofF
         GFv6Bq6OLL1wzz1N5waTlrvirk4pkI7J2MhEev2K0UMZnBTkNHRAoTYiEy/utW+KKGTV
         u+O8l5D3Sq92H884DgDAw2KjjCY/CTSCEejdgaLXKmVSN5NWjhevVvV5nMVb66jXOHfa
         0VGA==
X-Forwarded-Encrypted: i=1; AJvYcCXngdmk5GCCA+9CvOPX9NUZJKjyD+F4IIwYukZHAnpLFQQ19ILHwP9kUkkS19sI4Shc8rRyeQP6r1B3OQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwenShV2lwLz4QryXHA7jqjUAKmnSzDrK6pojNeGaXGmCOCXrQ2
	VTht9c8aBJqvYvNzLYu7F6Bme8pz0HcmLUH0j9MCLBq6S+K8+N+wFYNbdsb1+Rfjpto=
X-Gm-Gg: AZuq6aIEQkw4B9Tv1CNdoRpYwrZSMp8KZ5K+50OWyNORibh2V9s5q8oWlmOZkr2sQC1
	qoK/VfJptvMpC5WEhyScDIVMPcK8FywuALLvtbM45Qy+P5O4vSpiyvazVq2UVTf2aaciUtqN4J5
	wlzf+/l84qv6+Lt5zITu+9M+mGnLkCJq8G+s1odfNFNmyH72kdKqwUFoddnoJuOM0yuLJV2+ar7
	t0JNHVeQllwrmMJzDTaDW28DoDFcv5XyUY2kAPwgj1D50n+elFaVJXzRbixdJwHIhTF1Fz4hECj
	HvR2zoQHj6VRFIeSeWRVKnw0r5L5B3L4Gcvjdfxhx4wFzpAiudm8r/Si7FgGK1sdT+3HIA9H9+J
	KOAgsEj+ZHQieFe4BSEQyGvkvjJOhn8gKJgfjsDndFCS9yhlIqmSSzJ6/ozTI+3lVP2syZ28E0X
	IFHFjCGtLfG1PEcdoqLpgiZ0e6X1+cLhMHT5pvk8A=
X-Received: by 2002:a05:600c:6989:b0:480:3a71:92b2 with SMTP id 5b1f17b1804b1-48373a44055mr155545025e9.26.1771198425059;
        Sun, 15 Feb 2026 15:33:45 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4834d82a4c4sm661803245e9.10.2026.02.15.15.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 15:33:44 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v5 2/7] fbdev: au1100fb: Mark several local functions as static
Date: Mon, 16 Feb 2026 00:33:18 +0100
Message-ID: <3c08f87439d503ade5a6c0a628ff23f1e32af91e.1771198101.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771198101.git.u.kleine-koenig@baylibre.com>
References: <cover.1771198101.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2959; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=cNISZOqeKk8QMk5edubEElUWhcYpjBpybGx8Xr4QHLk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpklfClP4HcN9n84CROa8hNaWVi+C24Wt3+Mh2+ 206HBosg5qJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaZJXwgAKCRCPgPtYfRL+ TvGHCACQxypYsmo2xxRZ9jvO3UjvW8dFTUZQ4486H52AcIcTov/FuAOG6oOcNUUIh3BzACgp2Vj 7s0K7IY1+5mnJZvKvJFUokOEFrbBJy7vXSRcZ/32Q4G86qfE+Lry3cbfrP5ywxsMiGRYBL9W7h4 9uT5gUrOenc6yyaMzmg/bGZXnaiPAouustxStXI+SpcFKuz+hfGJcSzG8N/U3IvKO3vslLQbKpe FBuWn3OIG8vF0UDfZNnzTwjyZwSC0CkX3ltcwZoUixuYgjD3Dcr2UkWkP6DNrJbi8PAcBqPYnlr 6pYnZs+JHMQZujtHc0YM56WEaIcAmCoEFgG4Siv02catdwj1
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This fixes several (fatal) compiler warnings à la

	drivers/video/fbdev/au1100fb.c:530:6: error: no previous prototype for ‘au1100fb_drv_remove’ [-Werror=missing-prototypes]
	  523 | void au1100fb_drv_remove(struct platform_device *dev)
	      |      ^~~~~~~~~~~~~~~~~~~

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/video/fbdev/au1100fb.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index 7bc224a8455c..1abaa8e81315 100644
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
@@ -219,7 +219,8 @@ int au1100fb_setmode(struct au1100fb_device *fbdev)
 /* fb_setcolreg
  * Set color in LCD palette.
  */
-int au1100fb_fb_setcolreg(unsigned regno, unsigned red, unsigned green, unsigned blue, unsigned transp, struct fb_info *fbi)
+static int au1100fb_fb_setcolreg(unsigned regno, unsigned red, unsigned green, unsigned blue,
+				 unsigned transp, struct fb_info *fbi)
 {
 	struct au1100fb_device *fbdev;
 	u32 *palette;
@@ -278,7 +279,7 @@ int au1100fb_fb_setcolreg(unsigned regno, unsigned red, unsigned green, unsigned
 /* fb_pan_display
  * Pan display in x and/or y as specified
  */
-int au1100fb_fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *fbi)
+static int au1100fb_fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *fbi)
 {
 	struct au1100fb_device *fbdev;
 	int dy;
@@ -325,7 +326,7 @@ int au1100fb_fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *fbi)
  * Map video memory in user space. We don't use the generic fb_mmap method mainly
  * to allow the use of the TLB streaming flag (CCA=6)
  */
-int au1100fb_fb_mmap(struct fb_info *fbi, struct vm_area_struct *vma)
+static int au1100fb_fb_mmap(struct fb_info *fbi, struct vm_area_struct *vma)
 {
 	struct au1100fb_device *fbdev = to_au1100fb_device(fbi);
 
@@ -517,7 +518,7 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 	return -ENODEV;
 }
 
-void au1100fb_drv_remove(struct platform_device *dev)
+static void au1100fb_drv_remove(struct platform_device *dev)
 {
 	struct au1100fb_device *fbdev = NULL;
 
@@ -557,7 +558,7 @@ static int au1100fb_drv_suspend(struct platform_device *dev, pm_message_t state)
 	return 0;
 }
 
-int au1100fb_drv_resume(struct platform_device *dev)
+static int au1100fb_drv_resume(struct platform_device *dev)
 {
 	struct au1100fb_device *fbdev = platform_get_drvdata(dev);
 	int ret;
-- 
2.47.3

