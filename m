Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71051C433EF
	for <linux-fbdev@archiver.kernel.org>; Thu,  5 May 2022 11:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357449AbiEELfa (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 5 May 2022 07:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351993AbiEELfY (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 5 May 2022 07:35:24 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9AA3926138
        for <linux-fbdev@vger.kernel.org>; Thu,  5 May 2022 04:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651750304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UlMJQ+wz02RD+81KzAT+P3KjFBfmXeVQ3/vybVcCubw=;
        b=OhpD7MTtV/F/p0HJiXjGxYXRle8Vvyz2ckqV85DafRQ+oKBJ2QOsOBVtFZ4vmNz73M5EiN
        VOdMlia4OJamwwFJ/XF6gGe3xCotz9EZUuwTPyrF8X5D47pdO1oVyOCpefjygFvwvVm0MH
        3gyn7fhOarDPZYBBDYuO8su4hnhqJ4I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-97n-bbiPOvSFh0FXFYBl3g-1; Thu, 05 May 2022 07:31:41 -0400
X-MC-Unique: 97n-bbiPOvSFh0FXFYBl3g-1
Received: by mail-wr1-f69.google.com with SMTP id w4-20020adfbac4000000b0020acba4b779so1363930wrg.22
        for <linux-fbdev@vger.kernel.org>; Thu, 05 May 2022 04:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UlMJQ+wz02RD+81KzAT+P3KjFBfmXeVQ3/vybVcCubw=;
        b=dBTIBPYIuxUSGHI7dtXfsB5RMgxrARLcWVVGpLKyS0hj7we1GTkKfCv4sgmoIdRPqk
         JkkrXYhB3S8KNDNacVYhyCyHqZcqxb7cqplHgXtUigWQrvlBeo3INKQcNS6MbyrxSG72
         mV+yuXhi7ox9KRH968Ip8G6jYrjuOM40oEWU1+Q7ZO56jytLFA+lcdFFfLbGecZ9rMiY
         oq++gIGxY1K0CvAYudyVLwHuOVjfcuxIEgfRuTEU0zPl/o/4MnUoyYqWIGOW9Uqv2QNO
         mt3iHcU97NUMdbZIDHt9C+XjGh7jXxRaYu6yZXooFpssv/VczSAXLwA4HtS8y9vnhUPC
         3j/w==
X-Gm-Message-State: AOAM533fukKMS4eIbbzGcsGPwHSHFr4tX1MKJIiM0YEPmahKDGtepxKX
        it5YKJh//aaizbOYM1GuXayqveIh2m8bk1Av+08uVPFzl5nfhHJRVOw2F4Bra3+A/OdFYtV/dNo
        Rhl717N1ZqYKfVJHLvaXPujM=
X-Received: by 2002:a05:6000:1548:b0:20c:5ca8:7722 with SMTP id 8-20020a056000154800b0020c5ca87722mr16350990wry.712.1651750300438;
        Thu, 05 May 2022 04:31:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxug4drE+2lM0Y2bQGAKqHc9/jzcqI1egXtMk1eOS4NmBEoxmupUXagiI2LBGTtqENwnb2VKg==
X-Received: by 2002:a05:6000:1548:b0:20c:5ca8:7722 with SMTP id 8-20020a056000154800b0020c5ca87722mr16350970wry.712.1651750300187;
        Thu, 05 May 2022 04:31:40 -0700 (PDT)
Received: from minerva.. ([90.167.94.135])
        by smtp.gmail.com with ESMTPSA id k1-20020a5d5181000000b0020c5253d8f5sm995809wrv.65.2022.05.05.04.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 04:31:39 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH v2 2/4] fbdev: simplefb: Cleanup fb_info in .fb_destroy rather than .remove
Date:   Thu,  5 May 2022 13:31:25 +0200
Message-Id: <20220505113128.264963-3-javierm@redhat.com>
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

