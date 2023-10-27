Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172E7C25B6E
	for <linux-fbdev@archiver.kernel.org>; Fri, 27 Oct 2023 12:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345802AbjJ0MFw (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Oct 2023 08:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345801AbjJ0MFw (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Oct 2023 08:05:52 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5251BE
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Oct 2023 05:05:49 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507e85ebf50so2726674e87.1
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Oct 2023 05:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698408347; x=1699013147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rtys4OVP5ZzVlnIPSorJGpGjoOL2VcdIqIpp51DIOc0=;
        b=k4SQRzmRV9BFUXc5DNokM8iEZaCj/aOpkp1U/ZSVnN98XzWL6JqXXHO+db86NBfrHk
         dI9/Oylp2mWjdz8oHBPEo4NtbyEn++eAcJE5m1X1a+CIC3dKOk0GYKScJXMyWnixofjJ
         XRaFR++f1r9/oyH7UHEQJ8HK2vYzAAB9y+8XaBeXr76lygsORRwUgirwwn/sEz5gvgJn
         WX7N3X19gsa6fUfeVhfYYd+OnyG4gTsqtJ3o2uHaIP/UzrAyupkX3FbrHYfkj5jI28PK
         ZOPnn9ddeWEReaSpYwunNucDjBL6TSj/LeNKr9+RLg7Bu+Qd2zUA0ULiHp5LAbaeOykg
         N0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698408347; x=1699013147;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rtys4OVP5ZzVlnIPSorJGpGjoOL2VcdIqIpp51DIOc0=;
        b=A5ecTFKjGTuyPwqI2sNs+Ar5Cmu+i7UJZgqxBaeU+iOkmnXi2AHxZuCpd6rp+EHe5b
         fkgfVHUFz1UDTRuIOXEHcEBehoYtuJK6kQOZjHABdcUfaZbpjluiXPDUnOf/y8nlxyhY
         jh4Tze3P/1AgWYgUArYgomG2vN32jzU4fFy6cVLpQKOM1KUptraUVjxHDXLGC4Yaku3r
         zJPudcVBMCzbQUYdABJvlLaUfd6/CbV+dh9y386DJ930o3WxHbpbepV4r/hCcI7EihtD
         XqtU54a8Hxh1gV9r72WSo4Rh62dvYZyNAaks7upIzUiHcTwttzAZ2GcDoFK2vje4do+4
         iL6A==
X-Gm-Message-State: AOJu0Yzn+7I8KKS6WCQ7GXjaj62r17fcLg6ijW4Fat/FfHKUhv2WIYh+
        QmMb6iOuRm5rzms5lnXZW9N2+Q==
X-Google-Smtp-Source: AGHT+IEwMLdMiT1DpGl66JFRaW3Jkd9s7CFvWo0aNUOb8/tWmvL7FTmnMQJ10tzgk46/kJ10FHVi5Q==
X-Received: by 2002:a05:6512:48d1:b0:500:bf33:3add with SMTP id er17-20020a05651248d100b00500bf333addmr1543741lfb.47.1698408347447;
        Fri, 27 Oct 2023 05:05:47 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t20-20020a0560001a5400b0032ddc3b88e9sm1663138wry.0.2023.10.27.05.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 05:05:47 -0700 (PDT)
Date:   Fri, 27 Oct 2023 15:05:44 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] fbdev/imsttfb: fix a resource leak in probe
Message-ID: <71f55328-2275-4e53-98f2-f8a88cbd3399@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <014c0272-0d53-4625-8517-e8b4aa68f4dd@moroto.mountain>
X-Mailer: git-send-email haha only kidding
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

I've re-written the error handling but the bug is that if init_imstt()
fails we need to call iounmap(par->cmap_regs).

Fixes: c75f5a550610 ("fbdev: imsttfb: Fix use after free bug in imsttfb_probe")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/video/fbdev/imsttfb.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index acb943f85700..660499260f46 100644
--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1496,8 +1496,8 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	if (!request_mem_region(addr, size, "imsttfb")) {
 		printk(KERN_ERR "imsttfb: Can't reserve memory region\n");
-		framebuffer_release(info);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto release_info;
 	}
 
 	switch (pdev->device) {
@@ -1514,36 +1514,39 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			printk(KERN_INFO "imsttfb: Device 0x%x unknown, "
 					 "contact maintainer.\n", pdev->device);
 			ret = -ENODEV;
-			goto error;
+			goto release_mem_region;
 	}
 
 	info->fix.smem_start = addr;
 	info->screen_base = (__u8 *)ioremap(addr, par->ramdac == IBM ?
 					    0x400000 : 0x800000);
 	if (!info->screen_base)
-		goto error;
+		goto release_mem_region;
 	info->fix.mmio_start = addr + 0x800000;
 	par->dc_regs = ioremap(addr + 0x800000, 0x1000);
 	if (!par->dc_regs)
-		goto error;
+		goto unmap_screen_base;
 	par->cmap_regs_phys = addr + 0x840000;
 	par->cmap_regs = (__u8 *)ioremap(addr + 0x840000, 0x1000);
 	if (!par->cmap_regs)
-		goto error;
+		goto unmap_dc_regs;
 	info->pseudo_palette = par->palette;
 	ret = init_imstt(info);
 	if (ret)
-		goto error;
+		goto unmap_cmap_regs;
 
 	pci_set_drvdata(pdev, info);
-	return ret;
+	return 0;
 
-error:
-	if (par->dc_regs)
-		iounmap(par->dc_regs);
-	if (info->screen_base)
-		iounmap(info->screen_base);
+unmap_cmap_regs:
+	iounmap(par->cmap_regs);
+unmap_dc_regs:
+	iounmap(par->dc_regs);
+unmap_screen_base:
+	iounmap(info->screen_base);
+release_mem_region:
 	release_mem_region(addr, size);
+release_info:
 	framebuffer_release(info);
 	return ret;
 }
-- 
2.42.0

