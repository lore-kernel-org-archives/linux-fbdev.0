Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830ADC7EE2D
	for <linux-fbdev@archiver.kernel.org>; Mon, 27 Feb 2023 10:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjB0KHn (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 27 Feb 2023 05:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjB0KHm (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 27 Feb 2023 05:07:42 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDC31E286;
        Mon, 27 Feb 2023 02:07:41 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id j2so5551692wrh.9;
        Mon, 27 Feb 2023 02:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jnMX1QvB2TAT+d6bBwXqIXUvE0HfNg38gx5xp0MvMKA=;
        b=j0kwkt5SgEJKfHAWbmCBG9RFTkd8CIloKWFZ4XXSWwHXEI2DFmWxCxaTnTfnWpCyeb
         QV62H/ZNEjBmn8ccxPqO8XxzTyOzCXtOg4qo6m8827dsQA43jTlLHyDCuEUMuqg2XihF
         zPBdt+MsXPcvJVjJwPCE+bk6oe2fP5BHGbQtE7Q4N/fFozfPtKPcc0whXMvfEvPlD1LK
         JD0pLzr+/vQpDHFeggj6kSc1tjk/Z8dRg+u7BTzXYI/ldpOOyrM4RM1EuwrEbSFinJRP
         HvP6R0ux1DPVxzt91otFq8I5V3ajJbnGgUyB5p6F6Hs+jCVQUOo/JkaDHDD3/r3QZNSE
         Y4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jnMX1QvB2TAT+d6bBwXqIXUvE0HfNg38gx5xp0MvMKA=;
        b=BB10TRoNE4a5y1liB8CYtnD+5wQTV9AM/z1Hhq/YDrm6i7ceXHXN2e0EUtq7+oS4ev
         JM865YrlNk7rI1259ruFXpCqxMI+FYCjSddWeO6MRJSAII3eqef/2CGco6Jp1ddavXll
         TGFawfMZ3kr3//tdHIkyOguk1g8ZettVxeCb9ee9iCNt7KBhR720u8VnfNuTJrvP1OuR
         FZ2LU43NrL4S0+B1YhlfoIei/bB1Jz6r15b/1uf4JU7umrOrSqmcGpDp6SG7IdTOi9om
         GukhFj1qOh8ZbOtixQ8iUOEL4VaM8CEqRFsJFP94yuGoLynMSSBf8C+xw5bO6QLgjpZ5
         ul9w==
X-Gm-Message-State: AO0yUKVA0LzW8johkdGKWVug2QfjFLtij0SXwyvaopCoK/CnrH4abY5j
        ay/B1Idpfn/nWVVJ8wagzak=
X-Google-Smtp-Source: AK7set8A/RFwFh8podMXMM5ARoUOWSbyyo9zeJjupddomMttuY/UuYtHi7GPcniDxq6DCLSlWZxXAQ==
X-Received: by 2002:a05:6000:5c1:b0:2c5:4ca3:d56c with SMTP id bh1-20020a05600005c100b002c54ca3d56cmr5407214wrb.0.1677492459988;
        Mon, 27 Feb 2023 02:07:39 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id bg14-20020a05600c3c8e00b003eb395a8280sm7175794wmb.37.2023.02.27.02.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 02:07:39 -0800 (PST)
Date:   Mon, 27 Feb 2023 13:07:35 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] fbdev: chipsfb: Fix error codes in chipsfb_pci_init()
Message-ID: <Y/yA53V/rW8g1Zlm@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The error codes are not set on these error paths.

Fixes: 145eed48de27 ("fbdev: Remove conflicting devices on PCI bus")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/video/fbdev/chipsfb.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/chipsfb.c b/drivers/video/fbdev/chipsfb.c
index cc37ec3f8fc1..98398789528a 100644
--- a/drivers/video/fbdev/chipsfb.c
+++ b/drivers/video/fbdev/chipsfb.c
@@ -358,16 +358,21 @@ static int chipsfb_pci_init(struct pci_dev *dp, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
-	if (pci_enable_device(dp) < 0) {
+	rc = pci_enable_device(dp);
+	if (rc < 0) {
 		dev_err(&dp->dev, "Cannot enable PCI device\n");
 		goto err_out;
 	}
 
-	if ((dp->resource[0].flags & IORESOURCE_MEM) == 0)
+	if ((dp->resource[0].flags & IORESOURCE_MEM) == 0) {
+		rc = -EINVAL;
 		goto err_disable;
+	}
 	addr = pci_resource_start(dp, 0);
-	if (addr == 0)
+	if (addr == 0) {
+		rc = -EINVAL;
 		goto err_disable;
+	}
 
 	p = framebuffer_alloc(0, &dp->dev);
 	if (p == NULL) {
@@ -417,7 +422,8 @@ static int chipsfb_pci_init(struct pci_dev *dp, const struct pci_device_id *ent)
 
 	init_chips(p, addr);
 
-	if (register_framebuffer(p) < 0) {
+	rc = register_framebuffer(p);
+	if (rc < 0) {
 		dev_err(&dp->dev,"C&T 65550 framebuffer failed to register\n");
 		goto err_unmap;
 	}
-- 
2.39.1

