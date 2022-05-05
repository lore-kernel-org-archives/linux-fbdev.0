Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C19C433F5
	for <linux-fbdev@archiver.kernel.org>; Thu,  5 May 2022 22:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245599AbiEEWJl (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 5 May 2022 18:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237116AbiEEWJj (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 5 May 2022 18:09:39 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BBC95DBF5
        for <linux-fbdev@vger.kernel.org>; Thu,  5 May 2022 15:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651788357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XOMIAnnTamSRotiOWkLRdWbDfwtm7Vtf7J5gIUBLvsY=;
        b=Ba1xRvzB9SAXzBEcc7v3Ut+zYDe2RBV33jCalF3XsLrAW3XtcdZVtzzLVzO7fa7eCxeiPu
        GI2paM6ysQt+cMJODb8LtFpA7WFU5P8Vt+6q1Cri7LPfax4uoXseBdTO2eo6EUnhd27qxl
        od8dfrpQ2gvCHswWY5g2/W6t/ZaPtoU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-1PNBX738OZS9aY7Xo9CV5A-1; Thu, 05 May 2022 18:05:56 -0400
X-MC-Unique: 1PNBX738OZS9aY7Xo9CV5A-1
Received: by mail-wm1-f72.google.com with SMTP id s14-20020a05600c29ce00b00394611a8059so2377367wmd.4
        for <linux-fbdev@vger.kernel.org>; Thu, 05 May 2022 15:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XOMIAnnTamSRotiOWkLRdWbDfwtm7Vtf7J5gIUBLvsY=;
        b=4lpCJ2rz2gwqNpIRZjz+a5iljVYSpDn7EWNZRuRf7rxwQijp9ReR2FeQHvzGk4j/C8
         ZZU0tuvopEsqi2qPtoi+l4zJG45QhKPLs/xRxuzgizt8ymhbfSgef3eP6ugflpeo3Ute
         bH/ACs8xn6FAGnKXYFpnhG3kkmIf+VcZZuUvFU0BCOtOKjzrPV6IietLdZ4m5SVHfdQ1
         xaiDr8lUFb6/r5QK9aaSNnsJLeVNQlpIKyOldHiDsNBSUTo56gLh3UQD6p9yksY+Dqf6
         hGuc1qvtjngEWkt3kb8p6nV7WznAb2cYB+OXh+R9lrxHYOKEGBQMD/HHJV94Qt0/NRJL
         HRCw==
X-Gm-Message-State: AOAM532w0Bc1rPe8k6mTHC/b6qrGjhQG2Nqh29eCtoAHl/BdsQB+QnoK
        BJ0NXssRUJFL3cgTy0ZfuzGAt5H2b8UKEl2msDLgAOuxiwq2oCG/6hjK9PEPM4gMpd1nKhpmPL7
        2f/XFIahl79CdYvuTwh1tDNA=
X-Received: by 2002:a05:600c:214c:b0:394:2dfe:2754 with SMTP id v12-20020a05600c214c00b003942dfe2754mr287441wml.135.1651788354979;
        Thu, 05 May 2022 15:05:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeda1HHZwr4FX+lwN/TaIHgdOKHms0BlDVvSG/oTgRzg2lXGiKrE9u+GvlU9S+3hDsIgrQvw==
X-Received: by 2002:a05:600c:214c:b0:394:2dfe:2754 with SMTP id v12-20020a05600c214c00b003942dfe2754mr287430wml.135.1651788354747;
        Thu, 05 May 2022 15:05:54 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j28-20020a05600c1c1c00b003942a244f39sm7291679wms.18.2022.05.05.15.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 15:05:54 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>, Peter Jones <pjones@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 3/4] fbdev: efifb: Cleanup fb_info in .fb_destroy rather than .remove
Date:   Fri,  6 May 2022 00:05:40 +0200
Message-Id: <20220505220540.366218-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505215947.364694-1-javierm@redhat.com>
References: <20220505215947.364694-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The driver is calling framebuffer_release() in its .remove callback, but
this will cause the struct fb_info to be freed too early. Since it could
be that a reference is still hold to it if user-space opened the fbdev.

This would lead to a use-after-free error if the framebuffer device was
unregistered but later a user-space process tries to close the fbdev fd.

To prevent this, move the framebuffer_release() call to fb_ops.fb_destroy
instead of doing it in the driver's .remove callback.

Strictly speaking, the code flow in the driver is still wrong because all
the hardware cleanupd (i.e: iounmap) should be done in .remove while the
software cleanup (i.e: releasing the framebuffer) should be done in the
.fb_destroy handler. But this at least makes to match the behavior before
commit 27599aacbaef ("fbdev: Hot-unplug firmware fb devices on forced removal").

Fixes: 27599aacbaef ("fbdev: Hot-unplug firmware fb devices on forced removal")
Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---

(no changes since v1)

 drivers/video/fbdev/efifb.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index ea42ba6445b2..cfa3dc0b4eee 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -243,6 +243,10 @@ static void efifb_show_boot_graphics(struct fb_info *info)
 static inline void efifb_show_boot_graphics(struct fb_info *info) {}
 #endif
 
+/*
+ * fb_ops.fb_destroy is called by the last put_fb_info() call at the end
+ * of unregister_framebuffer() or fb_release(). Do any cleanup here.
+ */
 static void efifb_destroy(struct fb_info *info)
 {
 	if (efifb_pci_dev)
@@ -254,6 +258,9 @@ static void efifb_destroy(struct fb_info *info)
 		else
 			memunmap(info->screen_base);
 	}
+
+	framebuffer_release(info);
+
 	if (request_mem_succeeded)
 		release_mem_region(info->apertures->ranges[0].base,
 				   info->apertures->ranges[0].size);
@@ -620,9 +627,9 @@ static int efifb_remove(struct platform_device *pdev)
 {
 	struct fb_info *info = platform_get_drvdata(pdev);
 
+	/* efifb_destroy takes care of info cleanup */
 	unregister_framebuffer(info);
 	sysfs_remove_groups(&pdev->dev.kobj, efifb_groups);
-	framebuffer_release(info);
 
 	return 0;
 }
-- 
2.35.1

