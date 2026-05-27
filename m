Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91F640149B
	for <linux-fbdev@vger.kernel.org>; Wed, 27 May 2026 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896369; cv=none; b=uWafd215mIevzy4kuL+pVpnbWTbT/ZN8QQzRomxpwRxz6S7O0kZsHU1MQ6qRcj0W26zXaW70wMJEeOa1ZXxlobBjgKqPsGY8jIgq7oUQew10IN1BKOlb9uNwgd7bLTruy+ZQixQNuGAyVRJRZSBwZU07+W4a5Nh7rvtrlHw/tic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896369; c=relaxed/simple;
	bh=SZl0ZZ7Nk5+70c1aao78jyHVyCFkqKgvd/ZaC6sV7gw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vCkWCS1KsRhxi/ZBWEvYKU9tyqei2VjzoCck/EJFg1E1RNgygCq+Wx1E5uPIuOP/dZADwE25lVca/PpWlfI0DP/TrrTMOEJZPF/g5a4H3hSeFKfQS+T957Il7PEm3I+VsSUkzySaL+iWx2awdvm8NlxNTDuV5Z2G9g2DA549VWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mampa31n; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mampa31n"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49048f70faaso4010605e9.3
        for <linux-fbdev@vger.kernel.org>; Wed, 27 May 2026 08:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779896366; x=1780501166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ADHAKXLPSV+B46SoR3AVK3+w80ncz+/VZrd71fy3Anc=;
        b=Mampa31nK2C3CaNVzQKmW1TuqaqxPQ3JYp1i8wF9Iz4RB++d8vOI9btDAh4Rs2YA5y
         Qgi44NwkRcqlcAn0FWN6sWql93LWLn2wPyoqzad544EfpwDc+VK0XLtIFqf92S/aNcq3
         D3oykZb+NL4e/6/BuD9iGpkMMK69WDC7R0W5LidboGJWZG8XIQUmySfCyFxCvq0fe7dI
         vfQMQrGZSSwi123fQs3vnIwmFP+adOltnp8mXw3SvReQcAGu94STDRwrsmXMZy40suhX
         LDWL5RwdpQ16kBAkeabFvSgRIulXWP/d2zrCyoibpVfEXh5ReU4wR42EkqDX2Ul2xPTh
         IM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779896366; x=1780501166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADHAKXLPSV+B46SoR3AVK3+w80ncz+/VZrd71fy3Anc=;
        b=tHPfYCPwPQIm7wh5tW9qu43tWMe8D9vwg2aPbyaenMeHAYgKN7dEOlLjO8j+XC66Ua
         7PcHddkwRUcqoB6vjAvcESV7otBw4Mb1Rwg7aNT3ZQ/rybPjgdGtuhxoQxVZEX6ScdrY
         Q6hLZlg4UGlpOOB9iAKvmyf+zNUca0FD8Qozx4Lx09AJw5cUDSTBUzBR6ZqBBPfC9Coz
         NaY1EbLy2vUgrGbYtXclj0cB5SDc1BE3epr5aFG0EiAAIqTGy2l1v0fkU2GOJFV8JXYP
         9wr0VAJAVpIVDk6GAAuTnwzha99XtcNeeRguINSjP3WZ274DtqjETBNstYGHH4EdXuhQ
         pJIw==
X-Gm-Message-State: AOJu0YyH1jyV8dcgS8pcYgfTWa1X3XQBz8jObFp0kw5BL0xh0ytZl5gD
	AKKAv7QCz9LfUbGKqD5C9a+gT6zX4GhlLOitC2H/r3k9jkeDR/h89M2Q
X-Gm-Gg: Acq92OFHI++C9FoBQvze3mMxTiKX264T00p8k8Jbrwck2EH3kMJDRs0Uxy69diPcdj4
	P7dL3zcTZw/e2GekCn5Yg7SawHj/c2nsF41Kra9EgaSeKdT4C9+rP1toxYfkX8hR1PYGyGYJ8s3
	V9yRCch8BsvreT5XVvqlP/JaaZI7FjAWwbpfh35PMwwAafOhYRbh7UKY/bZqPopkluNyc9NGuv3
	XsP6L9LtXEPjHL6FzyePsfvzXEkH668CzCbZ4rbuHOvIuCJpWrP10qc4OO02XpDB1BpgMypJvyg
	nlSacttTm3nLAHrfH1BlKaD5L5uwuRBf1wdH8G2Ers2LKRXfW4NiuD7yft8Aj9ZIIsUyDDdAFzP
	GuAV4ZUTPusEXMOTBHkLpZOSY4RSpyuLVkLjVylcBQxgDl/2lEnGwmald1dFJLQ2ajlAmOifAG9
	ppHdRaipCs3j86OKeKUcdhVe+qwaCiznLwPh658G8Uak3DC9W+2R/3KoqzWAjcp9/Wd9VefCT28
	qogbuMeA1M=
X-Received: by 2002:a05:600c:4ecc:b0:490:502:8422 with SMTP id 5b1f17b1804b1-490428e2ceamr162598325e9.6.1779896366116;
        Wed, 27 May 2026 08:39:26 -0700 (PDT)
Received: from simuladores.arostegui.proxmox (178.pool85-58-80.dynamic.orange.es. [85.58.80.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb54a6cdsm7241937f8f.2.2026.05.27.08.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 08:39:25 -0700 (PDT)
From: =?UTF-8?q?Alberto=20Ar=C3=B3stegui?= <aarosteguig@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	AlbertoArostegui <aarosteguig@gmail.com>
Subject: [PATCH] fbdev: pxa168fb: use devm_ioremap_resource() for MMIO
Date: Wed, 27 May 2026 15:39:13 +0000
Message-ID: <20260527153913.33342-1-aarosteguig@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: AlbertoArostegui <aarosteguig@gmail.com>

pxa168fb maps the LCD controller register resource with devm_ioremap(),
which does not request the memory region. Use devm_ioremap_resource()
instead so the MMIO range is claimed before being mapped.

This also handles cleanup automatically.

Signed-off-by: AlbertoArostegui <aarosteguig@gmail.com>
---
 drivers/video/fbdev/pxa168fb.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
index ec602f7776eb..6784888d93c9 100644
--- a/drivers/video/fbdev/pxa168fb.c
+++ b/drivers/video/fbdev/pxa168fb.c
@@ -653,10 +653,9 @@ static int pxa168fb_probe(struct platform_device *pdev)
 	/*
 	 * Map LCD controller registers.
 	 */
-	fbi->reg_base = devm_ioremap(&pdev->dev, res->start,
-					     resource_size(res));
-	if (fbi->reg_base == NULL) {
-		ret = -ENOMEM;
+	fbi->reg_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(fbi->reg_base)) {
+		ret = PTR_ERR(fbi->reg_base);
 		goto failed_free_info;
 	}
 
-- 
2.43.0

