Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674D7C433F5
	for <linux-fbdev@archiver.kernel.org>; Thu,  5 May 2022 22:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386196AbiEEWKa (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 5 May 2022 18:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386186AbiEEWK0 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 5 May 2022 18:10:26 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7ACFA5E17F
        for <linux-fbdev@vger.kernel.org>; Thu,  5 May 2022 15:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651788402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2QUs/dFpZjXD63m2oUdzjI7+Wpnx04uqjBRSmxR+fJo=;
        b=WcESISWiMzZAVXZlC6Auoti3kaoDmdKBICe0Pz2eeq57Z2nenRQ+QMDjYAxb7WHB8gzBN1
        2nGtV2y0xieLFClKbUi/R1nGUA980/flHtICAI02uxOQqn0npEPZvF1j8+Njc9I5UVLL3t
        Nq8yEwWk044gwhpf9GjwnJEeW2j5vl4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-PavVowaPOgOuqeQ3TPByUw-1; Thu, 05 May 2022 18:06:34 -0400
X-MC-Unique: PavVowaPOgOuqeQ3TPByUw-1
Received: by mail-wm1-f70.google.com with SMTP id t184-20020a1c46c1000000b00394209f54f1so2214560wma.4
        for <linux-fbdev@vger.kernel.org>; Thu, 05 May 2022 15:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2QUs/dFpZjXD63m2oUdzjI7+Wpnx04uqjBRSmxR+fJo=;
        b=w6N3MbrU9o44NNQJ4A/oqkWtCP7QYm39ppmzIsY5ByTeZeFAyMqaAy7/o892s1yJKv
         s9SAPAmr+O3qoLkUfpRaJulWjmYOxX+Yv/YDOX4gUA5FpmdrnmNe6r1fH7mWxxELpCCU
         vtILzAprDRPRAPN3VSuEmcY/sHUALAD/c438Dvvx05qRRONCNcgmJb9qbSgF7nK/Fnvf
         cIWCzC90+qQ47Md0ay2fTdJ4HbNSuv2OzCxejI9zqzWJampYQQP7Wj4h378xB3bMRg8O
         htAgg/7sJxeliC5hpka9H4tA0/RmZTyYQLa1zn+VGZ5NYakVSAJr3y2HSZ2+xSh6CzG+
         Wfqw==
X-Gm-Message-State: AOAM531J/GPmnSO8M8bHNj8I4tB3c9gvIy+0F320gWUVCe8O+33GS3QH
        UAkcp0cHqNcMBzoSJqIX0IpJUnnwXXz4QMGi1a23ohsUPvm3kdJivwl2N6g1jVFSqdn3IbrcyRI
        bGCLfK6m+2C7KcJjIhyoJ40o=
X-Received: by 2002:a5d:6dd1:0:b0:207:92c4:eaef with SMTP id d17-20020a5d6dd1000000b0020792c4eaefmr165075wrz.498.1651788393674;
        Thu, 05 May 2022 15:06:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJuZtwlqObinYznGZMuIaaeVki7i2UMoMVMO9mJCvQ2FsqRQYwPdVCdFx20Il32JBmnuIcGA==
X-Received: by 2002:a5d:6dd1:0:b0:207:92c4:eaef with SMTP id d17-20020a5d6dd1000000b0020792c4eaefmr165062wrz.498.1651788393466;
        Thu, 05 May 2022 15:06:33 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n11-20020a056000170b00b0020c5253d8c7sm2040236wrc.19.2022.05.05.15.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 15:06:33 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 4/4] fbdev: vesafb: Cleanup fb_info in .fb_destroy rather than .remove
Date:   Fri,  6 May 2022 00:06:31 +0200
Message-Id: <20220505220631.366371-1-javierm@redhat.com>
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

Changes in v3:
- Only move framebuffer_release() and don't do any other change
  (Daniel Vetter).

Changes in v2:
- Also do the change for vesafb (Thomas Zimmermann).

 drivers/video/fbdev/vesafb.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
index df6de5a9dd4c..e25e8de5ff67 100644
--- a/drivers/video/fbdev/vesafb.c
+++ b/drivers/video/fbdev/vesafb.c
@@ -179,6 +179,10 @@ static int vesafb_setcolreg(unsigned regno, unsigned red, unsigned green,
 	return err;
 }
 
+/*
+ * fb_ops.fb_destroy is called by the last put_fb_info() call at the end
+ * of unregister_framebuffer() or fb_release(). Do any cleanup here.
+ */
 static void vesafb_destroy(struct fb_info *info)
 {
 	struct vesafb_par *par = info->par;
@@ -188,6 +192,8 @@ static void vesafb_destroy(struct fb_info *info)
 	if (info->screen_base)
 		iounmap(info->screen_base);
 	release_mem_region(info->apertures->ranges[0].base, info->apertures->ranges[0].size);
+
+	framebuffer_release(info);
 }
 
 static struct fb_ops vesafb_ops = {
@@ -484,10 +490,10 @@ static int vesafb_remove(struct platform_device *pdev)
 {
 	struct fb_info *info = platform_get_drvdata(pdev);
 
+	/* vesafb_destroy takes care of info cleanup */
 	unregister_framebuffer(info);
 	if (((struct vesafb_par *)(info->par))->region)
 		release_region(0x3c0, 32);
-	framebuffer_release(info);
 
 	return 0;
 }
-- 
2.35.1

