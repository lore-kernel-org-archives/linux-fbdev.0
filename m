Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73C3361DD0
	for <linux-fbdev@vger.kernel.org>; Sat,  9 May 2026 13:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778335089; cv=none; b=tp7l9PF+q4a07183Gtl+A/GXxO1+ax4xGtgmOyI0DkdZY7EpJhP0QrQyy3Ufnl3dcg63bnKfF5+BtNSydMkJJYzeb15Dv91IDj2in87uJq5yHtF8V+GRfqPpg50r4GgdqHsuJhBjdR70Hqy71n0buI93KjUzadzoZSVCeFGFQH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778335089; c=relaxed/simple;
	bh=zIpT8yZ3M5XwJMWP5PLyD7I/o2enwmiwMF5etMhXeBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cE4Yjb74Av095CIuyrJP5t7+Qy8mnnfveqjMJSa5O0ViCBDKHKmyKABJJnfEmG4Rk4gwi84lJukqD8W3657KN8l+pe/qFIrg3IlfulpbCaJOzQV4orG6UzQpP55V6ryUdNRLwLUzaePTXGYnDiWfIU77maMQkMd5bGEnWkOYXs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmKEHi6z; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmKEHi6z"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso20249955e9.1
        for <linux-fbdev@vger.kernel.org>; Sat, 09 May 2026 06:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778335086; x=1778939886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JUti0+dSrRWKVryrgT/4Dh3EjusVIM58YtILlWK34V8=;
        b=gmKEHi6zbujjornk6AjwkKx1VPBDSlS6SartOyLhR+EU/VNfpr64/tFv97S7weiYeN
         eHbh4eMHRlDbxFP+FiGsJ7lB+NgzANDPQPo7GwfIwExH6YuuSsDtaM/Om0gpWUreIVzJ
         KFFt7Co31dTH+95Qg94rjVnJfhHVRdDO0Nku0HHZvPzwCum1TWzQI4hrw0K3uJEHb3Aq
         gZFD1ixM5L4WDYH2DauUjauB0PZqEQjXvB2IN+0Uyqs+Trx+KdfedfQGJ3TpmpfaGqoc
         h1d1qKyoRpJVD9f0Me11m1r9proo5WkXnZpckEs3CgtfzWLrViEFCa1oF44xlRiq3rkP
         3hWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778335086; x=1778939886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUti0+dSrRWKVryrgT/4Dh3EjusVIM58YtILlWK34V8=;
        b=i5+2ADj+pBh2JHUZF4CM+EuTOysfFo5wX0oprDIEehnDNnKYP5OuLMrmE6wtxJgCph
         1K1b1XgiX9l4CoR1GOLzcuv6glrF8uqE7aVAJK4/V04vUyWfUGprCguUKnk11wVV9tkt
         jToXCXBYTWj5SclGaUFLt+6FSK8i2jXINrSv+NRn9yEFdaNMtWKMwheM0a2mYWzNbY5E
         x5uUep35CpRg7iAKhDsUasBtgYf+9xQjXjsdaPRedq4q5TWHxJUNM3bClMvN0YgOQS6a
         cjY9uclj6clHnelr08zVVPBtQchQ0vGRqsitgdPNcoeEfxQP7J4nIYAmSTwIWlo07eNF
         2s+g==
X-Gm-Message-State: AOJu0YxgdZNQ3XAI7V0oIWwTYo32yb0LLkkeAAxGV35FoTjTMwMPCbdn
	NThJObqTTOr6a6Cmq/33WdeubxiBp3OSudA1tNzMFMZdY5om6ejdG7QNz7K+8cZ8jWs=
X-Gm-Gg: Acq92OH2L04V6hKgouQh+fmHQTe9IgrI+gKuT97l+5h5xdIMKH6PEuY7OWZ9wtuIq2Z
	YbW5I8D7HXA7pcBxuMp1nmKlO2R38WnCI26l6NUbtm8pEAvQvbpppJOzoSMtIPHFdkPpKdcIkGR
	Od7oAmUZ+j+bPmO0pSUTDw9plp50sBsJuxU/RIouBmQrKpNuuWIP14UiL+WKXYuUwKvFGv0bjmh
	9bu6eKnxmtyuKPlZ5HEsXpqVzBhUBjrsF59KeD/+UW57eMjEt72MnY9OP16NrbbQ+dv6RIdXPDC
	POcOMrwwPD7XfKzshlaMhi7uCFOFckXf8jwoRmIE2Po+m21F4urxH/jMYqh0FlVADdHCQvOLu/V
	eFyr7O7MBUjv++qixxhuKMh8TO+vwBC+54I5mx/uCeln7VoSd1R7d6rt62KJUMlJ5UmdFkrHKSz
	pEwrD00QNhd0axXPdGIeYoK25meL/x5p/s7sMD9FX+Sy9v
X-Received: by 2002:a05:600c:8908:b0:48e:6275:27ec with SMTP id 5b1f17b1804b1-48e676b6393mr72783285e9.24.1778335085773;
        Sat, 09 May 2026 06:58:05 -0700 (PDT)
Received: from RM.localdomain ([92.53.30.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702e5614sm53450105e9.9.2026.05.09.06.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 06:58:05 -0700 (PDT)
From: =?UTF-8?q?Rahman=20Mahmutovi=C4=87?= <mahmutovicrahman5@gmail.com>
To: linux-fbdev@vger.kernel.org
Cc: deller@gmx.de,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rahman=20Mahmutovi=C4=87?= <mahmutovicrahman5@gmail.com>
Subject: [PATCH] fbdev: sunxvr2500: replace printk with device-aware logging functions
Date: Sat,  9 May 2026 15:57:59 +0200
Message-ID: <20260509135759.1391-1-mahmutovicrahman5@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace all printk() calls with appropriate device-aware logging
functions to properly associate log messages with the PCI device.

- Use pci_err() for errors where struct pci_dev is available
- Use pci_info() for info messages where struct pci_dev is available
- Use dev_err() for errors where only struct fb_info is available

Remove redundant 's3d:' prefix and pci_name() calls as device-aware
functions include device identification automatically.

Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Rahman Mahmutović <mahmutovicrahman5@gmail.com>
---
 drivers/video/fbdev/sunxvr2500.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/video/fbdev/sunxvr2500.c b/drivers/video/fbdev/sunxvr2500.c
index 42426d09b..3a36e7524 100644
--- a/drivers/video/fbdev/sunxvr2500.c
+++ b/drivers/video/fbdev/sunxvr2500.c
@@ -38,8 +38,7 @@ static int s3d_get_props(struct s3d_info *sp)
 	sp->depth = of_getintprop_default(sp->of_node, "depth", 8);
 
 	if (!sp->width || !sp->height) {
-		printk(KERN_ERR "s3d: Critical properties missing for %s\n",
-		       pci_name(sp->pdev));
+		pci_err(sp->pdev, "Critical properties missing\n");
 		return -EINVAL;
 	}
 
@@ -107,7 +106,7 @@ static int s3d_set_fbinfo(struct s3d_info *sp)
 	var->transp.length = 0;
 
 	if (fb_alloc_cmap(&info->cmap, 256, 0)) {
-		printk(KERN_ERR "s3d: Cannot allocate color map.\n");
+		dev_err(info->dev, "Cannot allocate color map\n");
 		return -ENOMEM;
 	}
 
@@ -127,8 +126,7 @@ static int s3d_pci_register(struct pci_dev *pdev,
 
 	err = pci_enable_device(pdev);
 	if (err < 0) {
-		printk(KERN_ERR "s3d: Cannot enable PCI device %s\n",
-		       pci_name(pdev));
+		pci_err(pdev, "Cannot enable PCI device\n");
 		goto err_out;
 	}
 
@@ -143,8 +141,7 @@ static int s3d_pci_register(struct pci_dev *pdev,
 	sp->pdev = pdev;
 	sp->of_node = pci_device_to_OF_node(pdev);
 	if (!sp->of_node) {
-		printk(KERN_ERR "s3d: Cannot find OF node of %s\n",
-		       pci_name(pdev));
+		pci_err(pdev, "Cannot find OF node\n");
 		err = -ENODEV;
 		goto err_release_fb;
 	}
@@ -153,8 +150,7 @@ static int s3d_pci_register(struct pci_dev *pdev,
 
 	err = pci_request_region(pdev, 1, "s3d framebuffer");
 	if (err < 0) {
-		printk("s3d: Cannot request region 1 for %s\n",
-		       pci_name(pdev));
+		pci_err(pdev, "Cannot request region 1\n");
 		goto err_release_fb;
 	}
 
@@ -194,12 +190,11 @@ static int s3d_pci_register(struct pci_dev *pdev,
 
 	pci_set_drvdata(pdev, info);
 
-	printk("s3d: Found device at %s\n", pci_name(pdev));
+	pci_info(pdev, "Found device\n");
 
 	err = register_framebuffer(info);
 	if (err < 0) {
-		printk(KERN_ERR "s3d: Could not register framebuffer %s\n",
-		       pci_name(pdev));
+		pci_err(pdev, "Could not register framebuffer\n");
 		goto err_unmap_fb;
 	}
 
-- 
2.43.0

