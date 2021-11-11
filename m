Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098CDC433FE
	for <linux-fbdev@archiver.kernel.org>; Thu, 11 Nov 2021 11:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E06A561381
	for <linux-fbdev@archiver.kernel.org>; Thu, 11 Nov 2021 11:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbhKKLOh (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 11 Nov 2021 06:14:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34432 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233062AbhKKLOg (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 11 Nov 2021 06:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636629107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6eGvVdE+WOQI0n1vAW2uJhdmDZdRKNo3k8x27QeGSUs=;
        b=OBiPJVT8VtQoBR6gHEWaMjlYe6pqexa2UpgMl/Tk7Xb7F2cU/1+9KEHfrOcgQyukEnlplh
        WuagTGy7czdRxTc4DhWLqeJQPZ+6QxktNPskPTWgKQZbZ+wkBmIi/FIxAWlx++9yjQqhMC
        mLS1VEzY7urp1wu1AYLU7aY1gaw83jI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-aJQSpVqkMb6yHs3BmxakJw-1; Thu, 11 Nov 2021 06:11:46 -0500
X-MC-Unique: aJQSpVqkMb6yHs3BmxakJw-1
Received: by mail-wr1-f72.google.com with SMTP id r12-20020adfdc8c000000b0017d703c07c0so970261wrj.0
        for <linux-fbdev@vger.kernel.org>; Thu, 11 Nov 2021 03:11:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6eGvVdE+WOQI0n1vAW2uJhdmDZdRKNo3k8x27QeGSUs=;
        b=0RnPMo7nSzIIPCkVXJmLO7cNPWtZDluwYpRiVXOifrABLuyKPGZAiLAlgb5Eud/SlN
         pFV8yWNbRLT2N2l90T03ujxNESU+soeXmSk0ZO5zgin/QPcHTX/yKmXuOQBgGq3nRd7L
         weJ2Y2t1qQDuUiYyPcPGKOA33tALnNlNhi36NET0+WgEJ2ie8qVHVNDMGyw8wms9SK4m
         o1Y8W2lm9k4z81XVMGSbr0kuEHmCxGijBUgnWWyTIjuaNnhndaxpDGqdOaSV6nMnuWll
         5UmGNgDcNKe2dsc+Hc+eYL13mfVR6ca8wiB2tWcbIPrwqHq0ASrNyERutTTwG+pNbExr
         IjzA==
X-Gm-Message-State: AOAM531TaC/a7PYDf0yUM15/I49S/J7J+IBlAIihfxK9WpDIAhUbW/w3
        BVXZayJJDIrhyUVYzoYfrjLXUCmwslsPcVoDt54+5t3LacxaTMPo27NDZiwYaea+8+BT7C72ZJx
        RSJsh9jIc/aeX019La2QLhuc=
X-Received: by 2002:a5d:548d:: with SMTP id h13mr7729993wrv.30.1636629104856;
        Thu, 11 Nov 2021 03:11:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwpiIEii6T7ztWVEFXdyjsxYX2ZgZCjRy/OqBzYjm9qowfTgAkURfVua5FAPoeW2C2TpR0nOg==
X-Received: by 2002:a5d:548d:: with SMTP id h13mr7729960wrv.30.1636629104600;
        Thu, 11 Nov 2021 03:11:44 -0800 (PST)
Received: from minerva.redhat.com ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id f7sm7937292wmg.6.2021.11.11.03.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 03:11:44 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Peter Jones <pjones@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Ilya Trukhanov <lahvuun@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2] fbdev: Prevent probing generic drivers if a FB is already registered
Date:   Thu, 11 Nov 2021 12:11:20 +0100
Message-Id: <20211111111120.1344613-1-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The efifb and simplefb drivers just render to a pre-allocated frame buffer
and rely on the display hardware being initialized before the kernel boots.

But if another driver already probed correctly and registered a fbdev, the
generic drivers shouldn't be probed since an actual driver for the display
hardware is already present.

This is more likely to occur after commit d391c5827107 ("drivers/firmware:
move x86 Generic System Framebuffers support") since the "efi-framebuffer"
and "simple-framebuffer" platform devices are registered at a later time.

Link: https://lore.kernel.org/r/20211110200253.rfudkt3edbd3nsyj@lahvuun/
Fixes: d391c5827107 ("drivers/firmware: move x86 Generic System Framebuffers support")
Reported-by: Ilya Trukhanov <lahvuun@gmail.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---

Changes in v2:
- Add a Link: tag with a reference to the bug report (Thorsten Leemhuis).
- Add a comment explaining why the probe fails earlier (Daniel Vetter).
- Add a Fixes: tag for stable to pick the fix (Daniel Vetter).
- Add Daniel Vetter's Reviewed-by: tag.
- Improve the commit message and mention the culprit commit

 drivers/video/fbdev/efifb.c    | 11 +++++++++++
 drivers/video/fbdev/simplefb.c | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git drivers/video/fbdev/efifb.c drivers/video/fbdev/efifb.c
index edca3703b964..ea42ba6445b2 100644
--- drivers/video/fbdev/efifb.c
+++ drivers/video/fbdev/efifb.c
@@ -351,6 +351,17 @@ static int efifb_probe(struct platform_device *dev)
 	char *option = NULL;
 	efi_memory_desc_t md;
 
+	/*
+	 * Generic drivers must not be registered if a framebuffer exists.
+	 * If a native driver was probed, the display hardware was already
+	 * taken and attempting to use the system framebuffer is dangerous.
+	 */
+	if (num_registered_fb > 0) {
+		dev_err(&dev->dev,
+			"efifb: a framebuffer is already registered\n");
+		return -EINVAL;
+	}
+
 	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI || pci_dev_disabled)
 		return -ENODEV;
 
diff --git drivers/video/fbdev/simplefb.c drivers/video/fbdev/simplefb.c
index 62f0ded70681..b63074fd892e 100644
--- drivers/video/fbdev/simplefb.c
+++ drivers/video/fbdev/simplefb.c
@@ -407,6 +407,17 @@ static int simplefb_probe(struct platform_device *pdev)
 	struct simplefb_par *par;
 	struct resource *mem;
 
+	/*
+	 * Generic drivers must not be registered if a framebuffer exists.
+	 * If a native driver was probed, the display hardware was already
+	 * taken and attempting to use the system framebuffer is dangerous.
+	 */
+	if (num_registered_fb > 0) {
+		dev_err(&pdev->dev,
+			"simplefb: a framebuffer is already registered\n");
+		return -EINVAL;
+	}
+
 	if (fb_get_options("simplefb", NULL))
 		return -ENODEV;
 
-- 
2.33.1

