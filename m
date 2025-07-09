Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D1128936B;
	Wed,  9 Jul 2025 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752054860; cv=none; b=D/A7i5Oy6ziKNzITe6p4OaW2rv5A7ntaF41SN118MBmMPnVq8c9KhlijugdU2Mg+TcE0BVKfYp1ykVnppYsYX14cxA6im/9zGmMzDBGoHjToSxDarkD9tbv363KzCrT7YP6sYNqymYtjhSLHuKrME/UBYQvAPMDIFSg1bBEXfDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752054860; c=relaxed/simple;
	bh=h4gpVGYUUOWAeyRTD1SOCa8+XXStWpcmhFICs+EJe0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dH+5PpwMRO+lVmnPYXxAMe6oNktSEJ1SWTrNf/c2ohJGmxMkdN4OgAUZNLjTTvo5Jx6qFQrlUrP0uhglrcuu5AKSbEoBU/svNpofZVpjqI4p+NC/tcaCGsGdbytoCgP3r1f051elihYPiS825CcEFnl7U8eeLRCtoNJ7HUftK1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2bcxkhs; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2bcxkhs"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae0dd7ac1f5so1015213566b.2;
        Wed, 09 Jul 2025 02:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752054857; x=1752659657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/xA8RBMxt3BQS7+pWU6O20VRxuNRUsOkplI0dlKzd4=;
        b=O2bcxkhswyxV2JqaOSA4iJqT/7NnBGAOCsB7ps153tO9S1a/lUDkFYX+HpMe3CpGF4
         43869pRueZi4S/Yps227Wy1UtZa42oD6gJYgmAyGg6Svvb7umrTdS2hLjWeKa2Pc5gVd
         zE0h5RwqtKtQU2TbbRLoRYeC0Ndjjm9z8dEROFWvZ7NZE1ODL8dOhdLfUymXC++VzZLA
         CzF1MfLewRYHxBfAf7/Q+piRJBgFk4SaBDfAr7x7W5FLtxctedxfKt/L1EoUdoB1+fUx
         YKyGwE56ADdINTNT+/XmjB9+ptvWGfLLR+LMIz+EXRxwpH1aZUmU+1iceBI7ZODJSkrb
         okkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752054857; x=1752659657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/xA8RBMxt3BQS7+pWU6O20VRxuNRUsOkplI0dlKzd4=;
        b=rRHCbTPzyY1n5GJXdofpXWILsjP6fg/HZb2tWVv95IoXj3ILnINNomMmJkOK/n6fg6
         ZUGeAHo/udDY9w22FLkr5kkLpP1/DB6ECoyGa0dkQDZ+2s+EQo0h7zVqVJzCC4KTuDPd
         UiTan73MdqT4I1ST/6CScqW2KJQ0zhf7wTGamjaeY5v3D+9XQ8PRTanxBLQ7H2kF8CnL
         nrfK6+UQ+xhQxLgWR0eIRLzIqqUiCyrmezjlZfxBDp72vKREUX3Or8RJNSDcpWVxTxBn
         mch0kIqBxeDQW8CSYQOmUWxgoAuq4s6w3FfNnN/HwaC7GR+hP83bJnXC2t5G24No3ZJe
         3o6g==
X-Forwarded-Encrypted: i=1; AJvYcCXwVQOed74eFOZ1t6WdXQ0awEew0iQLh0L+NUQJ1xZ4LI8IE+r00uttkmakhJ5OysiQAP5xxJ0B43hNaOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCxoqHU008KKwvPw1TaA9P9OvihiNK2DCUkv1UJvomLgEnQw7b
	8KzC+5KFwBK9VU2JsZI0FTDxa78xmtdt+pY6ORqlnH6xp9piM7xjreGMd48Gp7Ix
X-Gm-Gg: ASbGncuQyT80b2jJkY06bWSeQeHpL1TXB+HL9V5Po2qsGXaXeXAoU5gLgHnmXK8076t
	xfG63/jRlL1u/W7rR+/6+wcMyyjQMxAXFtLlgLJcBSmj+ODjRgDcUpo7c/tJ5KWJtx3Xc5aeziY
	SeVnv4B10UA2tKqQgQKknq+kjHtxrFcbdwsHLkrx07+LMrAJbdRB+VEqe7nStH+XsvNCB32B5Tz
	EZHEbRZUhUF1sYv8iKmVdfxLYiu3T3pcjifQBOPAwF9kT4nmOuMe7xpZA9AGmWCxh1LQyDvrV5O
	ijra5dGhfM583Q6kJe7/JSrB/f1RB7j7nMT6GDP3p+ih4G+MZ+om10iY00eqb/fdz65VOjFFdHv
	STv6icHO85ldWvTBsJs9qZl/jd0VCdFL5gLgbc+r3o7uuvkNoJTBq/9p8/Bvs1+zzwRlY29weyD
	L1BQ==
X-Google-Smtp-Source: AGHT+IHL8xKvtzSGhMBpsn0NwBZB7qQ7UJ2fZ6LEEU4qkuyxDrV1Z4wSVwIi7Pi8zmbRHLIkbKU4wQ==
X-Received: by 2002:a17:907:728c:b0:ae0:a590:bc64 with SMTP id a640c23a62f3a-ae6cf685479mr214095666b.18.1752054856747;
        Wed, 09 Jul 2025 02:54:16 -0700 (PDT)
Received: from kubuntu-e14.homenet.telecomitalia.it (host-87-21-242-88.retail.telecomitalia.it. [87.21.242.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6949cb2sm1074172266b.67.2025.07.09.02.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 02:54:16 -0700 (PDT)
From: Giovanni Di Santi <giovanni.disanti.lkl@gmail.com>
To: tzimmermann@suse.de,
	deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Giovanni Di Santi <giovanni.disanti.lkl@gmail.com>
Subject: [PATCH v3 3/3] fbdev: kyro: Use devm_ioremap_wc() for screen mem
Date: Wed,  9 Jul 2025 11:53:54 +0200
Message-ID: <20250709095354.931589-4-giovanni.disanti.lkl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709095354.931589-1-giovanni.disanti.lkl@gmail.com>
References: <20250709095354.931589-1-giovanni.disanti.lkl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the manual pci_ioremap_wc() call for mapping screen memory with the
device-managed devm_ioremap_wc() variant.

This simplifies the driver's resource management by ensuring the memory is
automatically unmapped when the driver detaches from the device.

Signed-off-by: Giovanni Di Santi <giovanni.disanti.lkl@gmail.com>
---
 drivers/video/fbdev/kyro/fbdev.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/kyro/fbdev.c b/drivers/video/fbdev/kyro/fbdev.c
index ddc241f508b1..c8b1dfa456a3 100644
--- a/drivers/video/fbdev/kyro/fbdev.c
+++ b/drivers/video/fbdev/kyro/fbdev.c
@@ -706,7 +706,8 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!currentpar->regbase)
 		goto out_free_fb;
 
-	info->screen_base = pci_ioremap_wc_bar(pdev, 0);
+	info->screen_base = devm_ioremap_wc(&pdev->dev, kyro_fix.smem_start,
+					    kyro_fix.smem_len);
 	if (!info->screen_base)
 		goto out_free_fb;
 
@@ -743,7 +744,7 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	fb_memset_io(info->screen_base, 0, size);
 
 	if (register_framebuffer(info) < 0)
-		goto out_unmap;
+		goto out_free_fb;
 
 	fb_info(info, "%s frame buffer device, at %dx%d@%d using %ldk/%ldk of VRAM\n",
 		info->fix.id,
@@ -754,8 +755,6 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	return 0;
 
-out_unmap:
-	iounmap(info->screen_base);
 out_free_fb:
 	framebuffer_release(info);
 
@@ -777,8 +776,6 @@ static void kyrofb_remove(struct pci_dev *pdev)
 	deviceInfo.ulNextFreeVidMem = 0;
 	deviceInfo.ulOverlayOffset = 0;
 
-	iounmap(info->screen_base);
-
 	arch_phys_wc_del(par->wc_cookie);
 
 	unregister_framebuffer(info);
-- 
2.43.0

