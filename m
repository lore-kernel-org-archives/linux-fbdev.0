Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F5AC433F5
	for <linux-fbdev@archiver.kernel.org>; Fri,  6 May 2022 13:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392421AbiEFN0c (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 6 May 2022 09:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392425AbiEFN02 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 6 May 2022 09:26:28 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD6E3689B3
        for <linux-fbdev@vger.kernel.org>; Fri,  6 May 2022 06:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651843364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ntfBkmjNjhrxvA8xhvwrtXUPZhy6WpJ5yDdT5A+/C00=;
        b=Wtk74G+V7aYi6mde13y1K7Fa8NuxGF0Hyf731kBLC7M2YKnml3AvC1mXkIUeofmlOzFPmE
        LfJo3q/yMVR8D2N6cZXjkfjbgMMnNYAClohUQp2YVR23vtAw8NYmeoyyssHLL6wZdrccQW
        qptb008pMC8Y+307xBhxDRoyT+tqnmM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-59-5vXJ61ADOrONyzaCbrDGbA-1; Fri, 06 May 2022 09:22:43 -0400
X-MC-Unique: 5vXJ61ADOrONyzaCbrDGbA-1
Received: by mail-wm1-f72.google.com with SMTP id t2-20020a7bc3c2000000b003528fe59cb9so2608599wmj.5
        for <linux-fbdev@vger.kernel.org>; Fri, 06 May 2022 06:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ntfBkmjNjhrxvA8xhvwrtXUPZhy6WpJ5yDdT5A+/C00=;
        b=ppduLzyW2CKtbkgF/nRPRrGQb0Kwkpm2+Oj+XLM2PJXH3D2SCIroucsCkh694gpJ15
         /JHRzX4z+07vCapjN9WzWsRkbXHRTNAKHcbxMuhzoEdl/SZRBXCNXjQnF9JLHyvH5Iml
         55UJPKIwAxl2jM7yBzvG0L1gCLcv/1zfCgaNDIFmgoIlBoMrtWkGR0lFsjWy/fZiV772
         KN9F2Q2oL5Xpfu2hgoEUD7KvWG/xYQemKTxukp9ZnpUR2nVOmgziHxSspBUnDl1Sje1f
         vTb8bUZ9Uxi4qWR1zPkuj1FGimWjKa7LOAA/WFkVOHfgrpEZkPKKffsupdqkw9gz5r5I
         2iZg==
X-Gm-Message-State: AOAM531DsRJC5IEgQJE33/4XgoRNeomnMWFN36n76vtcBN6fGQCaf7Lc
        JxuHZANXEFvXGRZMX+6UTScE/dLQd9ucrY7Bf9CIwP0RQzCwN/JRh86gSQWCmuThqnJO2s/RdpW
        e89ED1rVJAvo7tPYtBanVk5c=
X-Received: by 2002:a05:600c:20e:b0:394:2985:6d0c with SMTP id 14-20020a05600c020e00b0039429856d0cmr9784110wmi.106.1651843362146;
        Fri, 06 May 2022 06:22:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoBGIqiXlxsybVbyUOYtj+ac6M3xoMutesjNKS5Waxldl///9zmVAj4E/EHzyx2X+CmF9+Qw==
X-Received: by 2002:a05:600c:20e:b0:394:2985:6d0c with SMTP id 14-20020a05600c020e00b0039429856d0cmr9784085wmi.106.1651843361915;
        Fri, 06 May 2022 06:22:41 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l16-20020a7bcf10000000b003942a244f54sm10378255wmg.45.2022.05.06.06.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 06:22:41 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, intel-gfx@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>, Peter Jones <pjones@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH] fbdev: efifb: Fix a use-after-free due early fb_info cleanup
Date:   Fri,  6 May 2022 15:22:25 +0200
Message-Id: <20220506132225.588379-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Commit d258d00fb9c7 ("fbdev: efifb: Cleanup fb_info in .fb_destroy rather
than .remove") attempted to fix a use-after-free error due driver freeing
the fb_info in the .remove handler instead of doing it in .fb_destroy.

But ironically that change introduced yet another use-after-free since the
fb_info was still used after the free.

This should fix for good by freeing the fb_info at the end of the handler.

Fixes: d258d00fb9c7 ("fbdev: efifb: Cleanup fb_info in .fb_destroy rather than .remove")
Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Reported-by: Andrzej Hajda <andrzej.hajda@intel.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/video/fbdev/efifb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index cfa3dc0b4eee..b3d5f884c544 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -259,12 +259,12 @@ static void efifb_destroy(struct fb_info *info)
 			memunmap(info->screen_base);
 	}
 
-	framebuffer_release(info);
-
 	if (request_mem_succeeded)
 		release_mem_region(info->apertures->ranges[0].base,
 				   info->apertures->ranges[0].size);
 	fb_dealloc_cmap(&info->cmap);
+
+	framebuffer_release(info);
 }
 
 static const struct fb_ops efifb_ops = {
-- 
2.35.1

