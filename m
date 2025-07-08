Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2162A1BA;
	Tue,  8 Jul 2025 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986108; cv=none; b=jdSko6jkYbUXF3kKY5eLo/6rVBYCQwaRUQWwMynyMrC4Pwp3y72GhRY+t+4Pu7qxDVohi+1JafYs/MHG55AJ0B7m+lxc9ZXdyar6T0USEjQOLK/z4pgznTGIGHAthsFoqkNmDBJLbebjNJm4fnUGFGMWJ2y6EpkEeVKh8gjHHPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986108; c=relaxed/simple;
	bh=fKviyD22F+hVHHHW5cTd5fatxKS2bwf0e1y33GhF/uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZRIeUSepO2csstPIrIBtcExS8oAT6Wl55hfUjqhPqdtDlpFLWyIo7xoSt2aUl6bY4jWIIWdyScyVNaYC1R+qFikdgxEWtf3zxQVS0siRdrjUIG3YY2phZpNyB+LGpVECnmGi8hqX0RIgMSWdBWT5r+OpxeS4EO3A4+kbZhjdhfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXxzEz84; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXxzEz84"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60c6fea6742so9282158a12.1;
        Tue, 08 Jul 2025 07:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751986105; x=1752590905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cZemC5M/f+XMzPt6vXwq1Cy6fTiGZG5DlF15jcMv3ts=;
        b=eXxzEz847+c5gBBUpocOJn60voaJ11FmdDklBLkHWufydPuinwqw0pqeA/PXPBQJ2q
         jX9mZHX7ly4DGukhlCac4Ek3w7/vTYhu8EIQxE4SvUmwM/helFiGjlLDtpXPbpcnDGD7
         kB/KufsZbKmP7SK3rBX9IR5J7B/NnsR/+atHvTeUcki0udzgchIB7xnVFNAsUVNYikXs
         2CHNZz8Wk3oaMXoHBS3VyJkb9AAIwklFNHKsg83uDjD4rGV1eW9GT6lmemSotx9RA5Ps
         bjPzCCXJlJRRA3cRXqRvWVVW0RwFuPP13PMbqdA8rarPNppdDN/aShQLjy3ikmWbjEOn
         DeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751986105; x=1752590905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZemC5M/f+XMzPt6vXwq1Cy6fTiGZG5DlF15jcMv3ts=;
        b=r7sdx+xw+Ni6/X9XFMoHu4WH2CXvCVFAA4Vc47j6K3qRBAn9ZFSh13uUuz3aL0uoHk
         Tlf/ru2vWqk/iOoGUHz0uwzfH34mqs3jPi++Ir1QVKwIaBjAy48CLp+pUhEui2ugKeGr
         lEkhKMgMrTaWy4+TzKmfdDs12RQg67iITsKygDhPLOu5BP4b3goqFvcOKFolyr/0zosp
         cGfK8+oHm2mrjC1a53gu6rmweNwZ0MF47FDc6IlLtyWJVlVOrxYyvs9zjXjH0trV0B0l
         yw6bkXxXvfJt2qfdZ/a7AgycQnZYAyCHViJWZ2CCxy0KY6w8mmmwC8PmtaANQJ/ZAJz8
         eB1g==
X-Forwarded-Encrypted: i=1; AJvYcCUy0qUYYgR+0JJf+m2qzilpMPi/PI7jxfnBtAP8UOHmutau/Ojhy+4oTb95JvghuRzygo1IdrdEBiQYCA==@vger.kernel.org, AJvYcCW2LYSaYctN24HhSfYcKIqzYod+Rcr2GCnrNmC/Z3c+r1uqfSl8Q4wJBjOkltvRiFDEc21hsxEFKpN91ZwO@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4HJDr+Mba2gcjqCOU5LC7NwcbkoSFbzZ9yCgd38Ozx5eG8tnL
	ORx6sUM2D/2s79ryC0g+428QygBXPI/J9hPoBa9M4ee61b6ZDWsWXJaS
X-Gm-Gg: ASbGncvnipcapeGIUiLJknDrVTPiybhTN81bj3GTYzlnbyr97YL85VNHOniVFWSvRJ3
	m6/aWKPlMZN+nPGGfW/iJGklrlHCTZFulPRF5jfMZqDLLZ9WvzseENMq/Y9DTx5wsv917ANMMJQ
	IdXzKBW8f1pMd3gHtWzrcpg8RRerzQh5DO0bygkY3K45oj97ff+A/2t4DYjGbixHx+JGPPBDOaB
	6aIKKUroKUkHFO1CVPfktj7UQCPGFibeMevyskn2Iwg/CR55kGXE5OtzQs0G0wFln3osIml8gz7
	PhhnGuOBfvNTouNRaZsQsUxYAL2MalFBaRkh4sf0NX5jw4/bmDa/kEx7QFUsnk0mS1HmVT7RkEV
	EqSs1beQvYJIoTICmXQgHwjMCbyf+j0YD0n9Z9ANFJ3xtY0qvgzOX8zgbk8TZOh4wAHkQzB3/4+
	wGkg==
X-Google-Smtp-Source: AGHT+IFsuIaKI0izTH3oNbXTJfvb1BnkMXqq0i8PV+xLu7L0gkffGVaywqrJjFHAjd9/+hN5OUwLZQ==
X-Received: by 2002:a17:906:af89:b0:ae3:635c:53c1 with SMTP id a640c23a62f3a-ae6b025962fmr330465066b.54.1751986104383;
        Tue, 08 Jul 2025 07:48:24 -0700 (PDT)
Received: from kubuntu-e14.homenet.telecomitalia.it (host-87-21-242-88.retail.telecomitalia.it. [87.21.242.88])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb0c892csm7367056a12.38.2025.07.08.07.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 07:48:24 -0700 (PDT)
From: Giovanni Di Santi <giovanni.disanti.lkl@gmail.com>
To: deller@gmx.de
Cc: tzimmermann@suse.de,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Giovanni Di Santi <giovanni.disanti.lkl@gmail.com>
Subject: [PATCH] fbdev: kyro: Add missing PCI memory region request
Date: Tue,  8 Jul 2025 16:46:59 +0200
Message-ID: <20250708144659.787676-1-giovanni.disanti.lkl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kyro framebuffer driver did not request its PCI memory regions,
which could lead to conflicts with other drivers.  This change
addresses the task "Request memory regions in all fbdev drivers"
from the file Documentation/gpu/todo.rst.

pci_request_regions() is now called during probe. To ensure proper
cleanup, the corresponding pci_release_regions() and a missing
pci_disable_device() call are added to both the driver's remove
function and the probe's error handling path.

Signed-off-by: Giovanni Di Santi <giovanni.disanti.lkl@gmail.com>
---
 drivers/video/fbdev/kyro/fbdev.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/kyro/fbdev.c b/drivers/video/fbdev/kyro/fbdev.c
index 08ee8baa79f8..80ac17337c1b 100644
--- a/drivers/video/fbdev/kyro/fbdev.c
+++ b/drivers/video/fbdev/kyro/fbdev.c
@@ -685,8 +685,14 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	info = framebuffer_alloc(sizeof(struct kyrofb_info), &pdev->dev);
-	if (!info)
-		return -ENOMEM;
+	if (!info) {
+		err = -ENOMEM;
+		goto out_disable;
+	}
+
+	err = pci_request_regions(pdev, "kyrofb");
+	if (err)
+		goto out_free_fb;
 
 	currentpar = info->par;
 
@@ -695,10 +701,11 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	kyro_fix.mmio_start = pci_resource_start(pdev, 1);
 	kyro_fix.mmio_len   = pci_resource_len(pdev, 1);
 
+	err = -EINVAL;
 	currentpar->regbase = deviceInfo.pSTGReg =
 		ioremap(kyro_fix.mmio_start, kyro_fix.mmio_len);
 	if (!currentpar->regbase)
-		goto out_free_fb;
+		goto out_release;
 
 	info->screen_base = pci_ioremap_wc_bar(pdev, 0);
 	if (!info->screen_base)
@@ -752,10 +759,13 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	iounmap(info->screen_base);
 out_unmap_regs:
 	iounmap(currentpar->regbase);
+out_release:
+	pci_release_regions(pdev);
 out_free_fb:
 	framebuffer_release(info);
-
-	return -EINVAL;
+out_disable:
+	pci_disable_device(pdev);
+	return err;
 }
 
 static void kyrofb_remove(struct pci_dev *pdev)
@@ -780,6 +790,9 @@ static void kyrofb_remove(struct pci_dev *pdev)
 
 	unregister_framebuffer(info);
 	framebuffer_release(info);
+
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
 }
 
 static int __init kyrofb_init(void)
-- 
2.43.0

