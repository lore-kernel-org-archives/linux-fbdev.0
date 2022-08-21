Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6F7C00140
	for <linux-fbdev@archiver.kernel.org>; Sun, 21 Aug 2022 11:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiHULRr (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 21 Aug 2022 07:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiHULRq (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 21 Aug 2022 07:17:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13614267E
        for <linux-fbdev@vger.kernel.org>; Sun, 21 Aug 2022 04:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661080662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AxRts5aJ3HNvwn7dKavqQBNSNcUCmP54o8Yv9Iyp9m8=;
        b=QX+/DQd4kMm+qXpd4NAIY58fbgErGzZ0LXKLlKNdboqoA75Lox28dT4oqa6LafGNwgeI3D
        ppGsMRC9qeq09WhFWADMZvtQfvdfZm8pFApUduEVSpXnrKC0ZiP6DABp2G2YTzyQygpCjF
        gIfO/SLtQVyKRHEc3xpcgitwMH3alNg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-170-O2uTnf06Ns-SB7qyXtUxJQ-1; Sun, 21 Aug 2022 07:17:41 -0400
X-MC-Unique: O2uTnf06Ns-SB7qyXtUxJQ-1
Received: by mail-pj1-f69.google.com with SMTP id rj3-20020a17090b3e8300b001fae0be4dc4so4568960pjb.7
        for <linux-fbdev@vger.kernel.org>; Sun, 21 Aug 2022 04:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=AxRts5aJ3HNvwn7dKavqQBNSNcUCmP54o8Yv9Iyp9m8=;
        b=QYEGv+iv7nbZ1OkNVLplCQodr1Zc68QjvRwMs63oYydpTOQyIhPu+9j4qF3zmwlW7C
         2jKa66/wrAvo8xuFfltO8QAd2Qz4K1iAuyyu91tEDVMIxAke71lSAmaFpLTdHsK/GrJv
         qW4xaRbTzZWlBHT1pJSyDyrhdjreCO79Wn1OjfYTa8F4NnYD5gUa5hTvcFFWIu+oen7/
         sGZXW/297h8dYvNcI500cLAQuhxEJwqzIJ9w7WJJUeCFPswPFyWwi2+WYe8V1j72cgaF
         d1o2IZaG7AlPhGU7+7JTp7ju9hZ7lrZrMsdX/EV1aDa/mhwwkv7/I7JZYTxMLY453Gcg
         yOvA==
X-Gm-Message-State: ACgBeo0l/8iYoNAD/mR7NNeHoLCTPO5P39+leJxw2DHXhcG1lrfHFZJI
        PeEUHjZz3i7JPgt5nlyvyOYSuqpi5x/8JQZwn7sU1p53nECarPfvjEzmJ9PqtqJLcKAUfWFFM3f
        cNQFZ7KdgU3fkSCihFhiKDKo=
X-Received: by 2002:a17:90a:e586:b0:1fa:d28b:ab9b with SMTP id g6-20020a17090ae58600b001fad28bab9bmr16538360pjz.47.1661080660366;
        Sun, 21 Aug 2022 04:17:40 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4kgULb8Oe4M5i8Q1aOVIChTcGskCxiNDQX9B8sJq/7wZLjPKLFXM/9i4rUtW/O1NjahDdO7Q==
X-Received: by 2002:a17:90a:e586:b0:1fa:d28b:ab9b with SMTP id g6-20020a17090ae58600b001fad28bab9bmr16538337pjz.47.1661080660102;
        Sun, 21 Aug 2022 04:17:40 -0700 (PDT)
Received: from xps13.. ([240d:1a:c0d:9f00:4f2f:926a:23dd:8588])
        by smtp.gmail.com with ESMTPSA id w128-20020a623086000000b00536463e3802sm2835382pfw.36.2022.08.21.04.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 04:17:39 -0700 (PDT)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH] fbcon: Destroy mutex on freeing struct fb_info
Date:   Sun, 21 Aug 2022 20:17:31 +0900
Message-Id: <20220821111731.247446-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

It's needed to destroy bl_curve_mutex on freeing struct fb_info since
the mutex is embedded in the structure and initialized when it's
allocated.

Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 drivers/video/fbdev/core/fbsysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index c2a60b187467..4d7f63892dcc 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -84,6 +84,10 @@ void framebuffer_release(struct fb_info *info)
 	if (WARN_ON(refcount_read(&info->count)))
 		return;
 
+#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
+	mutex_destroy(&info->bl_curve_mutex);
+#endif
+
 	kfree(info->apertures);
 	kfree(info);
 }
-- 
2.37.2

