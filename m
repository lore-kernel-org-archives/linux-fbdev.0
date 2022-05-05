Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5015BC433F5
	for <linux-fbdev@archiver.kernel.org>; Thu,  5 May 2022 11:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351993AbiEELfc (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 5 May 2022 07:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357400AbiEELf2 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 5 May 2022 07:35:28 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3AFF506E2
        for <linux-fbdev@vger.kernel.org>; Thu,  5 May 2022 04:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651750306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kHj6RqHilBMUbncDK/2tHoS4NrC5xcTylW4aCqmdFU0=;
        b=XffKnjZ7c9IQRIGKetdXVt6z96vaslUVAtIW+TOpKAHTPkbrIrI8m8Ve7G+A2uQcSbmOK5
        2CiXpKisoJrR4FZQX/sYrpaZSnjDvVNeRzXjRdrPAiqcBnSbL+IKIf2qfXOpzWqt4NJsws
        AjIlME2iBoyM2cO2nn3qNCXvXQrvB5I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-5Psu2eLUOhGshI107QokPQ-1; Thu, 05 May 2022 07:31:43 -0400
X-MC-Unique: 5Psu2eLUOhGshI107QokPQ-1
Received: by mail-wr1-f69.google.com with SMTP id v29-20020adfa1dd000000b0020ad932b7c0so1350976wrv.0
        for <linux-fbdev@vger.kernel.org>; Thu, 05 May 2022 04:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kHj6RqHilBMUbncDK/2tHoS4NrC5xcTylW4aCqmdFU0=;
        b=HnK8LSM45rzuxmcBkh0QPG2fHXcIgguYg8aAV9EilkNqYQCz1NxZuMpNwWh/QPugn/
         Czmhy9e+1Ph8aQCEaqAFV6NSjt03zS5nqhVJqkzjJH8534r5go7lcBfu2WtJSY0ZPeNx
         Ph7xjRq96MHl9QiEvgiodpPDuTLT+t9sff2L6Irlcker8+0R4o1KkF/fYqiuA9Z5DVCF
         udZvDpKVh6qcs+vcYZnBErHDcFCNk8ILFqXDd0mtawgIhdu0sPO6iOwGSWraVC+lOyyt
         6NJSEDQVANlpAiLHumN8uft12T9wuIB+IAsE1pMf2Ail3SpeLRvD4OS2mP3JiLFdyA+8
         /xTw==
X-Gm-Message-State: AOAM531YrGIwhwal7CODIxF6z0WaAwZ5/dZmJWjvUcxgxXY2JrSLNu4P
        kPYcWJnDv0ZPaGWDFOpVym3iY/OCFJxWPXNbn+sircUnwEVI3UjN6USuV/PYmxaeS0lZ0ha/ESy
        qYg34Nwvg9XSXs2tW5dCm1FA=
X-Received: by 2002:a05:600c:48a6:b0:394:39c3:52 with SMTP id j38-20020a05600c48a600b0039439c30052mr4238781wmp.66.1651750302492;
        Thu, 05 May 2022 04:31:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0kdiNiZLFcv712Ydt7i9wnRcz/9iaODWbWGG3Ol0GG6/v5Xr4uslaghhGTnrCqtdWkt6x7A==
X-Received: by 2002:a05:600c:48a6:b0:394:39c3:52 with SMTP id j38-20020a05600c48a600b0039439c30052mr4238760wmp.66.1651750302269;
        Thu, 05 May 2022 04:31:42 -0700 (PDT)
Received: from minerva.. ([90.167.94.135])
        by smtp.gmail.com with ESMTPSA id k1-20020a5d5181000000b0020c5253d8f5sm995809wrv.65.2022.05.05.04.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 04:31:41 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>, Peter Jones <pjones@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v2 3/4] fbdev: efifb: Cleanup fb_info in .fb_destroy rather than .remove
Date:   Thu,  5 May 2022 13:31:26 +0200
Message-Id: <20220505113128.264963-4-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505113128.264963-1-javierm@redhat.com>
References: <20220505113128.264963-1-javierm@redhat.com>
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
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
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

