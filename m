Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EA1C433EF
	for <linux-fbdev@archiver.kernel.org>; Wed,  4 May 2022 21:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbiEDWBM (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 4 May 2022 18:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352006AbiEDWBL (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 4 May 2022 18:01:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 354944C7B3
        for <linux-fbdev@vger.kernel.org>; Wed,  4 May 2022 14:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651701452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d5E68EYuJS0cLv3NadyCR6Subawx0t/0D3XRnBIF5EA=;
        b=B1jkjqHLDlL5FaW6/IJrxYQ63GM9qf0gCZ8pb/QKj+XOhRdUtJhLtZCF5n25AUrBfcB1v1
        OoxlI6yp/6lXVc0OfwFdJ4m+6LaRh+d3pOYmgKEyv42F5F3ScOvsCOW3TnhnNehz2lvoZm
        H+JoVUJIrIMBQRT4J+UZ9XGzCYBoWnI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-GsOuTOL3Ns-BVcdMwakH1g-1; Wed, 04 May 2022 17:57:31 -0400
X-MC-Unique: GsOuTOL3Ns-BVcdMwakH1g-1
Received: by mail-wr1-f71.google.com with SMTP id k29-20020adfb35d000000b0020adc94662dso812743wrd.12
        for <linux-fbdev@vger.kernel.org>; Wed, 04 May 2022 14:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d5E68EYuJS0cLv3NadyCR6Subawx0t/0D3XRnBIF5EA=;
        b=NILIWst/+41lfN9DugRU2BBWn1XFJnGzb9XURDjuwghQK2GeJHlrmAaTaUG/m1rnPj
         txJ7CAMpZDl6gAyUQUmOtkRbVEKQiCK5TdYoFtW9Eud8afej+Z9gCJkKex6Elm7VwbSl
         pFfni3lUPz/UuPgbW76GJtmYZyMR1h3B+FVsCm+0hQ1xtjmPO9APBEOzvAm2FtLrzQzo
         pqbnsgJOwqbfGjCdS5wqEiZis4ztoxRlGj0FtOFpIUUnUTMvTWUvloSThdeQT7A99fWZ
         sBe4jCos7L0za0vBNEbrQxrcqvK0pXiOjb0m2sTCAXrl2ipwr5mYbdHokpcrWl9NmiCE
         ujog==
X-Gm-Message-State: AOAM531kvgPtoox+9bScra2rb9gokkjNpnK7SzuIE17e6s06rZY1ljgt
        h4hznVyANEmxP8pUFoqqJz/8xJL0vjjaGPy15W0YKn+U5HZyMDbkMXHJT0/GwJFIFbXvKcqMhzm
        cmCKbMKYpFuPXCwsd8gNx6us=
X-Received: by 2002:a7b:c199:0:b0:394:26d0:a6a9 with SMTP id y25-20020a7bc199000000b0039426d0a6a9mr1363672wmi.116.1651701450032;
        Wed, 04 May 2022 14:57:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1qMT5MICoWPkF4Ji0uGyxOCxsrRQ04CuhwRhiVVfyNZ8vIEl2jgygGi1ttKO9pWOlUIHlhA==
X-Received: by 2002:a7b:c199:0:b0:394:26d0:a6a9 with SMTP id y25-20020a7bc199000000b0039426d0a6a9mr1363665wmi.116.1651701449798;
        Wed, 04 May 2022 14:57:29 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c264b00b0039444973258sm5213068wmy.0.2022.05.04.14.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 14:57:29 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH 2/3] fbdev/simplefb: Cleanup fb_info in .fb_destroy rather than .remove
Date:   Wed,  4 May 2022 23:57:22 +0200
Message-Id: <20220504215722.56970-1-javierm@redhat.com>
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

