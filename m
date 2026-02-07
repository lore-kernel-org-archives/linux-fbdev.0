Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D629332EBA
	for <linux-fbdev@vger.kernel.org>; Sat,  7 Feb 2026 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770478628; cv=none; b=sNvRoyW6B/x+LtfGUFtuBJtbpnKY73/xzjOsUJSTM8Mj/xzuEaTPlOoeRqn6Xf9eMwil+7m5dpxx/N5IZGZj3l+gSOtV4CNsIGgbXWwgfdaSmJNDCtrUcpZCZNEKWWhxhxCm78oLzKLk63+axuS6yLgxIptHgSneGzY0OkwQfDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770478628; c=relaxed/simple;
	bh=1CaCMNykkYUh7hQ+271R0JN0to2NHJtCJ5SjZ5tg02U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjHd2WCVcZGTQdi5AVI10uC9n7v7BK093QT0M5jUR25E6V9dxMTFc+juw+27m/nncLEc5HFNznJzAXkbXFNKxqSVmde8TL+47do32lo24VN/p25IE1GF6/lXxcRVBM30b3qNumwfPJvP6YeAgQDUH0x9+EjTMtePyTQJqE1CJzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ye10WQvT; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ye10WQvT"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b8e9f89a8e3so340910966b.1
        for <linux-fbdev@vger.kernel.org>; Sat, 07 Feb 2026 07:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770478627; x=1771083427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxHH8jkBLGUmEqgSZepVgsJfG6X+09/IxWLokXGo0Zw=;
        b=Ye10WQvTyT7XSyNx0N1oSonPRa7l84uJgVzTVa7V5BaVas3gBSEsSj+izaK23eEg13
         XDSYXMTPjx5R3591tJk3DBjDbYCCSWnopDZ0tk7AXF/7uZXmsty9CR0YqSOEkBSgIXwY
         rAwHwQFeIRmlcYz0UBoHFfMT9pX+WAO/a+5gt4lUob+isnJv0+GxErbhEh4GV5Tmg9kr
         uf1FMOEPl/UtJf2wD4wjZ5JA7q51Lv89eoWCo0nmb07dFDDK4H5YMtEKV60ge6o/aket
         ioYjEuWKzZxXbrgC608UWNRJTgTGtlbTzOEyGAjnXSwoWM6VQ1Cp0P1ZDi4chfQ5ViXA
         SUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770478627; x=1771083427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RxHH8jkBLGUmEqgSZepVgsJfG6X+09/IxWLokXGo0Zw=;
        b=EXVWZyFrz0d/5UgRJoBh7ZjHSxLkUomkhcoyIA2n0XQ512cMLm7vNTSn8map3u5vlP
         5U3n0SsKNq1c6PyIFzruMJ/u7e6tEQ9m4vXWw6OEigUSuSP3RgGKFNxsqK6YKOqr8T2z
         LMm83vNsxYSFGRT/XNPytVJKtvnLO5VbrhL2dF/eG1uFKbyH8mxpA0DOcbYwN3jctR8v
         XNyKN8ZhnWWf6ly6JZAk9VgXtEs0JAdN36cfAHUnCcQYtMckJyk5KvIUJecDGtXaN596
         zCD96MC7RDdvdKVHKP7grOl23s9petX2sp9NuOD6dfOWS2lw47fn2JHMc3Nvm/hCpOgK
         r1PA==
X-Gm-Message-State: AOJu0Yw3TvBz6FNVIAEuhvXVB1r5/cnnzfYKwN/67Me0M9kAtoxVG0Lg
	lmPfpOBJ2q+73itg0PwOuOdAmEzCkhcNWfh1F22XMEWub7SbxxYfP0xU
X-Gm-Gg: AZuq6aLOivS7wbaPSHa8L+Cj768wTc/QPJHG1JZW8l2kiYNt5Fv2eQ8OwpTprIWsORE
	xNE/eOydj7cY4j3dOs0nFN4pTCsxMOIQuekCTwPPNNZ5x5jchj2TJKLC0t51glm7WHmC3ivRQYl
	ktR6t7kZ2nFPXlRR0dth4VAoqpsCWSKIc/ZiwkIQmt5CGgHfp72Xbgqs7mxOXgHNtuj7xBBGRqs
	p239tM3ag1cKeTnMTF1/Y6tfTXSNOM6UkepQliAYFLNXydEczj1yE+D0/Kij1Hleo+/5wDpvfNx
	QPjL92jjIkcm+BjqHF3MF0a40tNKsVNbY2Q/UAoQjq+JfzysoAE7E3PbQKLKNxsQbBDnAMy4pZV
	9cOWxAVRV5C73dDmfUUrLc1VNfR/0K9yLBaGLePbGE9VDl9K/vum/IIe0jtMv0+KBjjpapz4EId
	96rbkHYSXI3kcwKJoEHdNoEICFHEYkxPc6e5VD0tCyJfCg+FIymZmrdJLL6mPzw1whevFeOuTPl
	vFHDhcTl7C21o8t+btsqUj5PXPgxJTP9wNdQ6Pjz9XXOda/6PX3ZVDJ/N6t56oo
X-Received: by 2002:a17:907:6d0c:b0:b8e:d4ed:5ea8 with SMTP id a640c23a62f3a-b8edf2ffe66mr356683766b.42.1770478626661;
        Sat, 07 Feb 2026 07:37:06 -0800 (PST)
Received: from cs-874966990260-default.europe-west4-a.c.od237066db22328bb-tp.internal (170.249.141.34.bc.googleusercontent.com. [34.141.249.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8eda748aa6sm181308666b.1.2026.02.07.07.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 07:37:06 -0800 (PST)
From: Artem Lytkin <iprintercanon@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Artem Lytkin <iprintercanon@gmail.com>
Subject: [PATCH v4 3/3] staging: sm750fb: convert logging to device-based in sm750_hw.c
Date: Sat,  7 Feb 2026 15:37:03 +0000
Message-ID: <20260207153703.2049-4-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260207153703.2049-1-iprintercanon@gmail.com>
References: <20260207153703.2049-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace pr_err() calls with dev_err() using &pdev->dev or
&sm750_dev->pdev->dev to provide proper device context in log
messages. This makes it easier to identify which device generated
the message when multiple framebuffer devices are present.

Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 drivers/staging/sm750fb/sm750_hw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 983b51164..22cbabd26 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -42,7 +42,7 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	 */
 	ret = pci_request_region(pdev, 1, "sm750fb");
 	if (ret) {
-		pr_err("Can not request PCI regions.\n");
+		dev_err(&pdev->dev, "Can not request PCI regions.\n");
 		goto exit;
 	}
 
@@ -50,7 +50,7 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	sm750_dev->pvReg =
 		ioremap(sm750_dev->vidreg_start, sm750_dev->vidreg_size);
 	if (!sm750_dev->pvReg) {
-		pr_err("mmio failed\n");
+		dev_err(&pdev->dev, "mmio failed\n");
 		ret = -EFAULT;
 		goto exit;
 	}
@@ -75,7 +75,7 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 		ioremap_wc(sm750_dev->vidmem_start, sm750_dev->vidmem_size);
 	if (!sm750_dev->pvMem) {
 		iounmap(sm750_dev->pvReg);
-		pr_err("Map video memory failed\n");
+		dev_err(&pdev->dev, "Map video memory failed\n");
 		ret = -EFAULT;
 		goto exit;
 	}
@@ -291,7 +291,7 @@ int hw_sm750_crtc_set_mode(struct lynxfb_crtc *crtc,
 
 	ret = ddk750_set_mode_timing(&modparm, clock);
 	if (ret) {
-		pr_err("Set mode timing failed\n");
+		dev_err(&sm750_dev->pdev->dev, "Set mode timing failed\n");
 		goto exit;
 	}
 
-- 
2.43.0

