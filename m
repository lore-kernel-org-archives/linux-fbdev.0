Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6DFC433FE
	for <linux-fbdev@archiver.kernel.org>; Wed,  4 May 2022 21:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353639AbiEDWBz (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 4 May 2022 18:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241111AbiEDWBy (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 4 May 2022 18:01:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F9564C7AC
        for <linux-fbdev@vger.kernel.org>; Wed,  4 May 2022 14:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651701496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J9HgWbd8sU4BMyUvUsTJN8e3BPoAu1T5H5ui+stohEE=;
        b=So+BpLNVPCiQ/WB/zdHMlSMLOY7MabjIy6VhzSe276e0FxsFeJrmZ+6kwjepD12Jprjeo4
        QltDsQVOPboIuIeUAno0QAKL05YKLcFGfrweQIcew7Gf1qW3JKkYVGwebgMQJWnc0PhRo/
        3wa77LW6Bw2DXmyTulz4n4y2WYgljq4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-320-kfFbgcjPMMi-LH3TTjh-Eg-1; Wed, 04 May 2022 17:58:15 -0400
X-MC-Unique: kfFbgcjPMMi-LH3TTjh-Eg-1
Received: by mail-wr1-f71.google.com with SMTP id m8-20020adfc588000000b0020c4edd8a57so816775wrg.10
        for <linux-fbdev@vger.kernel.org>; Wed, 04 May 2022 14:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J9HgWbd8sU4BMyUvUsTJN8e3BPoAu1T5H5ui+stohEE=;
        b=o/dnbyE2WR5pgObKcSFNcX1ijHhmve3ZU6ZoWEoLDb0hiTcq4Wu5SStKYWYNhVcWRp
         VQ2RXYE2YI6H8QhwuM/wJW0cDZCFGWwqgi4RTfrWFmBXsvyn8sviEgcNgxWB87zG23rQ
         w3FUoiam89Rs0NVGHeljUe4sJoxpN2siUQgSvQ1TUSR4Ka8jHBkEHBCcTc7CamczoRTB
         ypkM877ogkffsAZ7+krjTt3ajFXgwZDO/79eUTgCA9WPgVmhoiHRKaH985XluC5zy1jM
         bxccL3XB83ysq5dgvHEkAmNz6enPsWPhcpy7QflwALCy9ya2wQKP17BRuhXLQRW1qIQU
         dAEQ==
X-Gm-Message-State: AOAM532OOPtlChTtQ2tJuPbAmegFdy+MSNr/hwrmRN7Z5tXuKcAmZnsK
        kbVkJdpyFN6JgrQjbCLWnvcC0Zcz0vjWnEo6/DhMzqxCbGC/kjy/Y1haxOOpmdCxqA5EE0RFFQY
        w0ghFY9JINXUZsDVfMcCSHDE=
X-Received: by 2002:a5d:584a:0:b0:20c:5a8b:cee7 with SMTP id i10-20020a5d584a000000b0020c5a8bcee7mr14891884wrf.111.1651701494278;
        Wed, 04 May 2022 14:58:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyi1rI7Ysw/yS2KuEXDRIJhqrF+e633rbFMsZfhkqQBH5RX7aHp1FggslnaX3+T4EtZ2beo3g==
X-Received: by 2002:a5d:584a:0:b0:20c:5a8b:cee7 with SMTP id i10-20020a5d584a000000b0020c5a8bcee7mr14891871wrf.111.1651701494069;
        Wed, 04 May 2022 14:58:14 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q10-20020a1cf30a000000b003942a244ee9sm4553648wmq.46.2022.05.04.14.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 14:58:13 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>, Peter Jones <pjones@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH 3/3] fbdev/efifb: Cleanup fb_info in .fb_destroy rather than .remove
Date:   Wed,  4 May 2022 23:58:06 +0200
Message-Id: <20220504215806.57147-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220504215151.55082-1-javierm@redhat.com>
References: <20220504215151.55082-1-javierm@redhat.com>
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

The correct thing to do is to only unregister the framebuffer in the
driver's .remove callback, but do any cleanup in the fb_ops.fb_destroy.

Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

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

