Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AC7C433F5
	for <linux-fbdev@archiver.kernel.org>; Thu, 11 Nov 2021 09:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86D7D61268
	for <linux-fbdev@archiver.kernel.org>; Thu, 11 Nov 2021 09:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbhKKJX7 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 11 Nov 2021 04:23:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48789 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232649AbhKKJXx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 11 Nov 2021 04:23:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636622464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=M7EnEFZM8hpmKbZzBB2524z5yoBtQtMivZ7RH2EH6gg=;
        b=PX4R1m79QGqC9agcCQuFvNIsFtUVB2SNOYKGV+9n/D0dU3TKd5tvGNcJIqho3rqz/40k8c
        PqEKrXsElN5RKxCZHu/cz1L3cZoLKgSf/yWjAtHDjUKvsMel6wA0d3u00SfNVKHbZfPPg3
        qDl4L+ONgveUxEz++sf+XP+dA60s8OY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-eZQ2otg5PymE8iXjnsvzYA-1; Thu, 11 Nov 2021 04:21:02 -0500
X-MC-Unique: eZQ2otg5PymE8iXjnsvzYA-1
Received: by mail-wm1-f72.google.com with SMTP id z126-20020a1c7e84000000b003335e5dc26bso1163361wmc.8
        for <linux-fbdev@vger.kernel.org>; Thu, 11 Nov 2021 01:21:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M7EnEFZM8hpmKbZzBB2524z5yoBtQtMivZ7RH2EH6gg=;
        b=kDMZtWUIjjTJ87TVnf+bTWx/mrdglN9M5qcqREt7m20BoZXvU8IDFTvRH+tCs7aumv
         MXlHwm8U2WQH2lFjK48QJVyuh8jCoEUJez3Z0fwHn20wGXx1bAOwxsCdHUFUWhIqdK7N
         AIkTR4i5OqeXKXr+3GURJ6nRToS3ZQztHBX5NQ03Xy2cU+CeV1li/r9XbHEe3hs6eCGo
         ZDosKHwKyAgrBUyV7MY/dXy50oKmHW8+YBq+mlOEwClSRKXv8gj9cyQc0glBNkmKocCy
         omWGcwRtuiV9Y5H+TXimGiplUmxKVqZn+kVpSJ8ZaUndPbEzt+G9+mxdORqYUdTioYYH
         qopA==
X-Gm-Message-State: AOAM532lC9BhHUrYuR6f1T1iR8mYkH6BmTUjpYhaVXzDWRBVWa831wMb
        icwnM2O+IcZKDABpHwSM3ebMk3NU99ym4vXt2t/IbIQpQedt2o4ouOX5uv8MjvnvYKaCfGGGR40
        BtoG7UOneAcxqM3eiFk1HOvo=
X-Received: by 2002:a5d:6e8c:: with SMTP id k12mr6960355wrz.401.1636622461414;
        Thu, 11 Nov 2021 01:21:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwoCpfVGEoP5JTD2lYYhZ8BrAUpodfbF1IJMQ5/neOUnHUU1QzYlFJgKjg18hFHJMVZCV5Zog==
X-Received: by 2002:a5d:6e8c:: with SMTP id k12mr6960329wrz.401.1636622461175;
        Thu, 11 Nov 2021 01:21:01 -0800 (PST)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id c6sm10242842wmq.46.2021.11.11.01.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 01:21:00 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ilya Trukhanov <lahvuun@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH] fbdev: Prevent probing generic drivers if a FB is already registered
Date:   Thu, 11 Nov 2021 10:20:53 +0100
Message-Id: <20211111092053.1328304-1-javierm@redhat.com>
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

Reported-by: Ilya Trukhanov <lahvuun@gmail.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/video/fbdev/efifb.c    | 6 ++++++
 drivers/video/fbdev/simplefb.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git drivers/video/fbdev/efifb.c drivers/video/fbdev/efifb.c
index edca3703b964..76325c07cf0c 100644
--- drivers/video/fbdev/efifb.c
+++ drivers/video/fbdev/efifb.c
@@ -351,6 +351,12 @@ static int efifb_probe(struct platform_device *dev)
 	char *option = NULL;
 	efi_memory_desc_t md;
 
+	if (num_registered_fb > 0) {
+		dev_err(&dev->dev,
+			"efifb: a framebuffer is already registered\n");
+		return -EINVAL;
+	}
+
 	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI || pci_dev_disabled)
 		return -ENODEV;
 
diff --git drivers/video/fbdev/simplefb.c drivers/video/fbdev/simplefb.c
index 62f0ded70681..55c1f54d7663 100644
--- drivers/video/fbdev/simplefb.c
+++ drivers/video/fbdev/simplefb.c
@@ -407,6 +407,12 @@ static int simplefb_probe(struct platform_device *pdev)
 	struct simplefb_par *par;
 	struct resource *mem;
 
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

