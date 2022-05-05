Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D323C433F5
	for <linux-fbdev@archiver.kernel.org>; Thu,  5 May 2022 22:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiEEWJF (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 5 May 2022 18:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245662AbiEEWIt (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 5 May 2022 18:08:49 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19FAE5C64F
        for <linux-fbdev@vger.kernel.org>; Thu,  5 May 2022 15:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651788308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CpySyazXcP9jeQEo03DKJEoNJ7MOw25wdUGi6hnO0cY=;
        b=Tv5Cn2NQWTmW/dIbpECPwyLPLHqHjROL43HRs6dwHygl2YsVs4kCbOo3jrzFrr4C/v7LWn
        VYi6wxz4ZGygO0FQIiv+pqH6G5rZuEso829J7Pp8CSFCXO81eMEVPPa8mSUz9Zf8WfoOX1
        1TvURTOn1MvV+U+PuF6i/AIGoW8QDYU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-z0VxhYQ2M4CtEAVgycIWFA-1; Thu, 05 May 2022 18:05:07 -0400
X-MC-Unique: z0VxhYQ2M4CtEAVgycIWFA-1
Received: by mail-wm1-f69.google.com with SMTP id c62-20020a1c3541000000b0038ec265155fso5104116wma.6
        for <linux-fbdev@vger.kernel.org>; Thu, 05 May 2022 15:05:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CpySyazXcP9jeQEo03DKJEoNJ7MOw25wdUGi6hnO0cY=;
        b=FLJSYXBK5P8FUVEt11UEB1+yURLfpjmG8oASigrfyjX4QgL0+OrDy/TUlt2aB4p2SU
         WmaiiPeF1k5YIsyqDEGiIbdHnKCdhiKhgKlv1iMWW77SzkSJFdNhow13tg6eII6TCCVY
         Ya55rC1bSncfcxbgPhoTPoOV0VM58a4gm0xrQOwTW4jnCdFTCHe8OSAKdW7tQ7tuXyXD
         yjJ0k5KEfTlePzt92SRZaRmjYybkeRk6dj21XmaIyzlfDOMjV/JrcssYa34U1iToHAIU
         ZGUfH5TP6/du6AcNO8YrKkzTUfJ0iNd+lQgbK4GOE11SXW4q7W3tnhDoQ2zvGFHPAP2J
         fNPA==
X-Gm-Message-State: AOAM532LcPHJySb0IfN2cTD1b9mO819tKyx8R/bq/pMOocUPtAaub5Bk
        JoCnADUDpErOnJwBeWaNNOtdukauJ7+npnbclGL1k+ER1nUujXkCzEx31KItj3yH46OXgxnFHXb
        nH0VQIazve56kdIxOZOA5ExY=
X-Received: by 2002:a5d:6c65:0:b0:20c:5230:f145 with SMTP id r5-20020a5d6c65000000b0020c5230f145mr142606wrz.337.1651788305743;
        Thu, 05 May 2022 15:05:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzx4hSKJf5+8gqVXy4SQIIH/+d18yIIzPchwfl0/SeHroDdEocZasvgfA/q6M9W6ITqVZA+Yg==
X-Received: by 2002:a5d:6c65:0:b0:20c:5230:f145 with SMTP id r5-20020a5d6c65000000b0020c5230f145mr142590wrz.337.1651788305549;
        Thu, 05 May 2022 15:05:05 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n21-20020a7bc5d5000000b003942a244f47sm7942360wmk.32.2022.05.05.15.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 15:05:05 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 2/4] fbdev: simplefb: Cleanup fb_info in .fb_destroy rather than .remove
Date:   Fri,  6 May 2022 00:04:56 +0200
Message-Id: <20220505220456.366090-1-javierm@redhat.com>
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

 drivers/video/fbdev/simplefb.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index 94fc9c6d0411..2c198561c338 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -84,6 +84,10 @@ struct simplefb_par {
 static void simplefb_clocks_destroy(struct simplefb_par *par);
 static void simplefb_regulators_destroy(struct simplefb_par *par);
 
+/*
+ * fb_ops.fb_destroy is called by the last put_fb_info() call at the end
+ * of unregister_framebuffer() or fb_release(). Do any cleanup here.
+ */
 static void simplefb_destroy(struct fb_info *info)
 {
 	struct simplefb_par *par = info->par;
@@ -94,6 +98,8 @@ static void simplefb_destroy(struct fb_info *info)
 	if (info->screen_base)
 		iounmap(info->screen_base);
 
+	framebuffer_release(info);
+
 	if (mem)
 		release_mem_region(mem->start, resource_size(mem));
 }
@@ -545,8 +551,8 @@ static int simplefb_remove(struct platform_device *pdev)
 {
 	struct fb_info *info = platform_get_drvdata(pdev);
 
+	/* simplefb_destroy takes care of info cleanup */
 	unregister_framebuffer(info);
-	framebuffer_release(info);
 
 	return 0;
 }
-- 
2.35.1

