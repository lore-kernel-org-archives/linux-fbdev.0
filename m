Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07FFC64ED8
	for <linux-fbdev@archiver.kernel.org>; Mon, 27 Feb 2023 10:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjB0Kdj (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 27 Feb 2023 05:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjB0Kdi (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 27 Feb 2023 05:33:38 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E948F5275;
        Mon, 27 Feb 2023 02:33:35 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q16so5670363wrw.2;
        Mon, 27 Feb 2023 02:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K9odxWzvzue9z1NrNjPL2bn7gUkLmctX3VvfrU8oiAk=;
        b=dav+XCq3c710V4HBALG6vLCxdDuPp7pufLGks1XX8cO0PLFYMr1J0HuHDHUsvura72
         oSt6KEUgkKLQ43IqrrrwqoWj8MPOm7E3JkZvYicVha2tqRUDRHyMGo9UQrVp+0kU/uMG
         WOyaK0qXat3vhS4VJZv/BkmQSUn+zqc5sEZn2sPG1dVwbssa4kQlcuFOSlvp6hwOIWPA
         gOcR2Su1+Hvrg2ep4CsA4qUo2gZUa0MTj2kwtx+tQR2i3ZUXQpAH4YAphiOs+57REEs3
         D12dQ5f0cTaLgmWVfCj7EfwbnHGSyQpQv68W0AZe971j0+b7fHK3ft67fuu2+iLn7SLS
         JbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K9odxWzvzue9z1NrNjPL2bn7gUkLmctX3VvfrU8oiAk=;
        b=5xepJ5BFa0P6+RnblyBOH2G8Tb4vgnk+CIpf+wU/b4iqmGJPpj8wa/gXieAzDHkJtM
         oqOpGAzhiteT8WpsbKJTM0g2TYSrD8axcPZDlX0YWHYYnmnCHF65IjJDzaRrz5Ms4DkS
         E8WAo1XqVNmE4Rr98pHyENGA5El8A5AqMi5XArmVLip+j/7LJjPGIl2fXLY+tewZ3CEn
         nc49BuQ/8Kb2xD0fuppVBoRaMediHq5NmUEgJffUcGlDSJ9GiKYW1NyV/PZmGbDQwIbL
         SdWg4WLbUD+fvxZMZ4hBg0SnzCIsmX3wWFvj7GMxqUlKLLBQBidFQyz0vIFTDxlkiMeD
         0zIA==
X-Gm-Message-State: AO0yUKUwD0x8WEsgSFyQMR8CSgVlBtaMMlV0Gbvx8rkT8e08XMZR19is
        q+cZLFJVhSW1GTQU/gT/nZpSnNHNWXfIuA==
X-Google-Smtp-Source: AK7set9+9zFd2aJkifJYbiHWR4I7Zsn9y0bCJ5P9tNnwHzorUqaB02E6KU0aYOs4YojoMt78neFgrA==
X-Received: by 2002:adf:ef0d:0:b0:2c5:587e:75ba with SMTP id e13-20020adfef0d000000b002c5587e75bamr19380603wro.55.1677494014479;
        Mon, 27 Feb 2023 02:33:34 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r1-20020a1c2b01000000b003e9ae2a8cbfsm8854770wmr.2.2023.02.27.02.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 02:33:33 -0800 (PST)
Date:   Mon, 27 Feb 2023 13:33:30 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2] fbdev: chipsfb: Fix error codes in chipsfb_pci_init()
Message-ID: <Y/yG+sm2mhdJeTZW@kili>
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
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---
v2: I accidentally returned -EINVAL instead -ENODEV.
    Add Thomas's Reviewed-by tag.

 drivers/video/fbdev/chipsfb.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/chipsfb.c b/drivers/video/fbdev/chipsfb.c
index cc37ec3f8fc1..7799d52a651f 100644
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
+		rc = -ENODEV;
 		goto err_disable;
+	}
 	addr = pci_resource_start(dp, 0);
-	if (addr == 0)
+	if (addr == 0) {
+		rc = -ENODEV;
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

