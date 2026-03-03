Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EBD175A89
	for <linux-fbdev@vger.kernel.org>; Tue,  3 Mar 2026 12:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772540621; cv=none; b=Rwb+WbDZmllGhnZplqKlqtE15MfOaWaOCUoesypTBe84HsPVKZwP9loCEQnB5t2UnBl0f0+MEQ/+EPEcOus2VJUnzLHuSVgILPgCbn0w1idWr7YV0HAPq0k3Z6l7toguY/pNwujEQZyp5e+XUGaAKu9Umq0PKquzBY4+5s2GZO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772540621; c=relaxed/simple;
	bh=VaG5WWK3PEEYYRL3hvYzQ6mrxETdljwGnFaNLiRNSxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gYgUSBXO+eGq1sgWuSHJ9ipILYLz18Ke/erGJ2IT6zTtqimeAHLWOFZ8OPZ6zRTMMA4yTAY71eUWhEzm1BiPtyTSb9YTKCVck+BzX1Mqib5WTejnw80TkW/g/UDlWmib3xTAUmMcuLwVa19bYH7mRNS6Abttj8zp2m6efrpkolQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsL2O9pj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsL2O9pj"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4836f4cbe0bso47917635e9.3
        for <linux-fbdev@vger.kernel.org>; Tue, 03 Mar 2026 04:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772540618; x=1773145418; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xJ7JLm9HHhra60wi72CXzKV/8KnCXZClrEsgloI2Vjc=;
        b=nsL2O9pjKuZB/S9xv75n8eGxztBp2yfyP8qXmbWvcZTRheF9X0Nt+cT5CXX2Eoz/1r
         Eh/abmaCTj5eupOFoBeubkX0FSLOmmpXUJSJBJO0djpEdAzRDLhXZ1TH1VUl06cJAJeQ
         saK9te93nGMmLZPChn2CQYYN6G+9RZ8kOH23vsJbMzM5jq5Ca+L9LujK6ocPOa2CAWXa
         JtMaENTFaMmr4kf8yfH6jqN8RFqxNThD73tybHhHdo/i8V6P7Ph/dCmz3GdtvC09uuDq
         M4ofk16yQOYu4vQTPo8Nmd47hXu3Nt3i7zFCkZH5/LMOrelaTPeKj+zsrDnjFHBFHlxB
         rbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772540618; x=1773145418;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJ7JLm9HHhra60wi72CXzKV/8KnCXZClrEsgloI2Vjc=;
        b=I47D8es/f8RUbGbzbt1x5EUw1/HhOfIyKyvqxLaVjdgM6VQbcECN5Wk+K/Aqz+yzsI
         9LEi7MiIAg95dGdljbL1HdN2pmM0nP3JgjHB/T4oFNUzvSFGs25drgbYWcekWW16dc4T
         ozfFm5HfmXMEoexzMa796e++N7+wc7j4s+qiPyFLqEl0MUbwQ71yulFNa3aYArhE5Q4H
         xMbWSAuljLl+20P4gwv/ZyVL1MIdKhMQq0c0Beba94AQ7IKBuQIWT1VosrRNWKSiRs1W
         Qzx/wsKPh8s7MH8WQJkdUYE1iH7cMhc2jamtTSi981QfHaLq4RmOpNVDN9C7T5oirbDy
         GWXQ==
X-Gm-Message-State: AOJu0YwiUQ17YRPsGEITPjmJYNMDgUTwpB9NdvTD3RPjwxVSok9zOlIw
	PVff+RKfJSNXmcVOi39hBVVQyle7zNX18AtfpBC90EuBqCIHdt9xMLUB
X-Gm-Gg: ATEYQzxIosWUTrdmXQQUcaucV/mDoY55+LAl4nYZiZAr+Af/LpRE6DWya81WkI8X5nN
	9UHQfS4NjtGFW3YIrEdVKvm799jMlH4r6rUa6merIid6QV/v8QFeZfFUwG5l+UDTBlE2nGFYQcY
	5ivJrMIZoPA9jekivXVLJ/GupQuyMm+K7CzxqCt8hzJ5Vpeu6ysVReRK0y7iLiMftMEWTJZUwBS
	xg5OQs1gjRSpIintvHF4k1JmkENOlAefoGH8N9QtqIKZuuRrG012Xqc52qBGCnWCUgoozDhiPHo
	ng6UrIDnktw30KQ8CQB6QbC1H7vi6T796HR1mI2xjn6qh/g3dOnRAu5J3LJZpA/jK2AXfrVBqoN
	Lij1sGc7a3YhvT1XnDMMt7uWTifniIMKlIXe335ls6mMlhPwFCgu57/dtJGoSNKAhsmkM9/kyCQ
	hNSQSdKG64Prq942inHmaqhrQwONOCEvj8oh1Zzxy0JQw9q6rx5HaSNFnE3/rdpfsFPpqgNOZ/p
	/YlGZ48to7tM1sA90msRq81kqcIUQ==
X-Received: by 2002:a05:600c:c16e:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-483c9bf448bmr279884895e9.24.1772540617896;
        Tue, 03 Mar 2026 04:23:37 -0800 (PST)
Received: from [127.0.1.1] (2a01cb06907588f0d6267e1b423820b8.ipv6.abo.wanadoo.fr. [2a01:cb06:9075:88f0:d626:7e1b:4238:20b8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439abdf5430sm23922899f8f.5.2026.03.03.04.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 04:23:37 -0800 (PST)
From: Amin GATTOUT <amin.gattout@gmail.com>
Date: Tue, 03 Mar 2026 13:22:24 +0100
Subject: [PATCH] fbdev: goldfishfb: use devm_platform_ioremap_resource()
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-master-v1-1-85eb5ff584b0@gmail.com>
X-B4-Tracking: v=1; b=H4sIAH/SpmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwNj3dzE4pLUIl1jE8NUcwODRCMzS0sloOKCotS0zAqwQdGxtbUAK/1
 wflgAAAA=
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Amin GATTOUT <amin.gattout@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772540616; l=1990;
 i=amin.gattout@gmail.com; h=from:subject:message-id;
 bh=VaG5WWK3PEEYYRL3hvYzQ6mrxETdljwGnFaNLiRNSxs=;
 b=lVG5GTj/mX7rh2hMdUCHq5iZE7MhF1bTee8t0BYfN09GJ89vBP26l4TVOoAE1jsdSg1Giabkj
 QwYhrCt0YB0AhEwqlZmAo/1x2BT/41wBlYN8eo3FyO+0xXO3to+ZVJc
X-Developer-Key: i=amin.gattout@gmail.com; a=ed25519;
 pk=C9HM6Jf5d9dPl9fnP9pM/nhMwm+c280ldqYZ0ESu3a8=

Replace the open-coded platform_get_resource() + ioremap() pair with
devm_platform_ioremap_resource(), which requests the memory region and
maps it in a single call, with automatic cleanup on device removal.

Signed-off-by: Amin GATTOUT <amin.gattout@gmail.com>
---
 drivers/video/fbdev/goldfishfb.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/goldfishfb.c b/drivers/video/fbdev/goldfishfb.c
index ffe33a36b944..c9871281bc1d 100644
--- a/drivers/video/fbdev/goldfishfb.c
+++ b/drivers/video/fbdev/goldfishfb.c
@@ -174,7 +174,6 @@ static const struct fb_ops goldfish_fb_ops = {
 static int goldfish_fb_probe(struct platform_device *pdev)
 {
 	int ret;
-	struct resource *r;
 	struct goldfish_fb *fb;
 	size_t framesize;
 	u32 width, height;
@@ -189,14 +188,9 @@ static int goldfish_fb_probe(struct platform_device *pdev)
 	init_waitqueue_head(&fb->wait);
 	platform_set_drvdata(pdev, fb);
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (r == NULL) {
-		ret = -ENODEV;
-		goto err_no_io_base;
-	}
-	fb->reg_base = ioremap(r->start, PAGE_SIZE);
-	if (fb->reg_base == NULL) {
-		ret = -ENOMEM;
+	fb->reg_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(fb->reg_base)) {
+		ret = PTR_ERR(fb->reg_base);
 		goto err_no_io_base;
 	}
 
@@ -273,7 +267,6 @@ static int goldfish_fb_probe(struct platform_device *pdev)
 				fb->fb.fix.smem_start);
 err_alloc_screen_base_failed:
 err_no_irq:
-	iounmap(fb->reg_base);
 err_no_io_base:
 	kfree(fb);
 err_fb_alloc_failed:
@@ -291,7 +284,6 @@ static void goldfish_fb_remove(struct platform_device *pdev)
 
 	dma_free_coherent(&pdev->dev, framesize, (void *)fb->fb.screen_base,
 						fb->fb.fix.smem_start);
-	iounmap(fb->reg_base);
 	kfree(fb);
 }
 

---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20260303-master-341e700a2699

Best regards,
-- 
Amin GATTOUT <amin.gattout@gmail.com>

