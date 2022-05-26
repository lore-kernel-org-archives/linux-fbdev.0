Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD61C433EF
	for <linux-fbdev@archiver.kernel.org>; Thu, 26 May 2022 19:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344272AbiEZTsC (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 26 May 2022 15:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiEZTsA (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 26 May 2022 15:48:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8ABE47092F
        for <linux-fbdev@vger.kernel.org>; Thu, 26 May 2022 12:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653594478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IqmegdZhOWmFPqYA7uqlJOlfLWdBgu4zMEYzTrKy8L4=;
        b=V/2nmagLfGFdE4nO4sbTSJ6YYRNjbgybUs8kWCMd4VF9U8hNMpkQWo4hqdEIj2jmYKCO39
        fXJPwetzyBjcPOhSCm9UJ2sMvDBTU1gJTYHDWN184yYQJEuLSwFzKEeqbaHL2D7PUdVu33
        65OBdDFC0Rs0jL5npHSsnxDQfplezhc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-WM1Iv947PL6A5rosQHUOzw-1; Thu, 26 May 2022 15:47:57 -0400
X-MC-Unique: WM1Iv947PL6A5rosQHUOzw-1
Received: by mail-wm1-f70.google.com with SMTP id n25-20020a05600c3b9900b0039733081b4dso1478072wms.7
        for <linux-fbdev@vger.kernel.org>; Thu, 26 May 2022 12:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IqmegdZhOWmFPqYA7uqlJOlfLWdBgu4zMEYzTrKy8L4=;
        b=WOhyQ1BSmJI9yfmtsHmhnx/TvAxEmehskgv941qWS7msIuH1dfYXVfofrtZOaIcFvM
         B80hFuJ45VpAVw8sO9mEhpvtvgNlLXHFQII43Ov4OlHrvsUhraaCPW9YZTEAiORD0kFQ
         Oje9k90RMkADcbilNaCLTdTFeqA7LG96GNwG9kNg/tNTo1SQrhhYESzd/I6Y+QA1jqw8
         hoKJ6Xx4rjlyxi4/wlm1AYeqG1XtXeKKngAtOVneFM3dL4NqSlVs9WwZUzl/8DT+WUZ2
         5m/gyIBUtf9H1dnXOyYP/5YU6fzPSpzMulRhmuSox2O14yUu1qxjJz5mJTX42MsMdRMS
         oPkg==
X-Gm-Message-State: AOAM530PhyMVin9xoYcmp2H26rjh12V4tNLRB6OV4eiOSQk68QW6aMq1
        TwBmuXaTpC6a2XO7+XEzZU/CAwD6JY6neMs/bAmkbJ5WWKkIgcaZ0BDSYv0Nyp+NL8zrD7ojr9m
        f4jjiYbJCem+aOOmveOtx710=
X-Received: by 2002:a05:6000:783:b0:210:179b:1ff4 with SMTP id bu3-20020a056000078300b00210179b1ff4mr147084wrb.168.1653594476086;
        Thu, 26 May 2022 12:47:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyt0PbPjNk+g5Uz3e3z7a4zGdrz/A2I0RbjgSsZZj2AKebvL330j4C2+ucus1UQuH8ZJcnOrg==
X-Received: by 2002:a05:6000:783:b0:210:179b:1ff4 with SMTP id bu3-20020a056000078300b00210179b1ff4mr147071wrb.168.1653594475802;
        Thu, 26 May 2022 12:47:55 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id az26-20020a05600c601a00b003942a244edfsm25101wmb.36.2022.05.26.12.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 12:47:55 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pascal Ernster <dri-devel@hardfalcon.net>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH] fbdev: vesafb: Fix a use-after-free due early fb_info cleanup
Date:   Thu, 26 May 2022 21:47:52 +0200
Message-Id: <20220526194752.307192-1-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Commit b3c9a924aab6 ("fbdev: vesafb: Cleanup fb_info in .fb_destroy rather
than .remove") fixed a use-after-free error due the vesafb driver freeing
the fb_info in the .remove handler instead of doing it in .fb_destroy.

This can happen if the .fb_destroy callback is executed after the .remove
callback, since the former tries to access a pointer freed by the latter.

But that change didn't take into account that another possible scenario is
that .fb_destroy is called before the .remove callback. For example, if no
process has the fbdev chardev opened by the time the driver is removed.

If that's the case, fb_info will be freed when unregister_framebuffer() is
called, making the fb_info pointer accessed in vesafb_remove() after that
to no longer be valid.

To prevent that, move the expression containing the info->par to happen
before the unregister_framebuffer() function call.

Fixes: b3c9a924aab6 ("fbdev: vesafb: Cleanup fb_info in .fb_destroy rather than .remove")
Reported-by: Pascal Ernster <dri-devel@hardfalcon.net>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/video/fbdev/vesafb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
index e25e8de5ff67..929d4775cb4b 100644
--- a/drivers/video/fbdev/vesafb.c
+++ b/drivers/video/fbdev/vesafb.c
@@ -490,11 +490,12 @@ static int vesafb_remove(struct platform_device *pdev)
 {
 	struct fb_info *info = platform_get_drvdata(pdev);
 
-	/* vesafb_destroy takes care of info cleanup */
-	unregister_framebuffer(info);
 	if (((struct vesafb_par *)(info->par))->region)
 		release_region(0x3c0, 32);
 
+	/* vesafb_destroy takes care of info cleanup */
+	unregister_framebuffer(info);
+
 	return 0;
 }
 
-- 
2.36.1

