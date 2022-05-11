Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A923EC433EF
	for <linux-fbdev@archiver.kernel.org>; Wed, 11 May 2022 11:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbiEKLcb (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 11 May 2022 07:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240566AbiEKLc3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 11 May 2022 07:32:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BE8D23BB7B
        for <linux-fbdev@vger.kernel.org>; Wed, 11 May 2022 04:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652268743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UDplaZMb5YseJ+Hq/qs3ip7VsbbgryHldJFcbzukwP8=;
        b=hoDQq/OPlPA1jIbWxLpQn1eaMCxeQk0RSlIkcJZiZ0i1/bLzwG8WTGnBA/CABRbdFhK/gN
        I60tCXvY26uk2UjfG/gnDuGI27/SRafC2SVLITBo7+M2GVBt3xZcqB/aRY9wuflFTBOk7r
        8T3xUgLXEozVJLsbmvoQHQNjjSTgdCU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-J983cpqMNe6iVep0K9utpQ-1; Wed, 11 May 2022 07:32:22 -0400
X-MC-Unique: J983cpqMNe6iVep0K9utpQ-1
Received: by mail-wr1-f71.google.com with SMTP id e4-20020a056000034400b0020cdf0dbf49so465776wre.20
        for <linux-fbdev@vger.kernel.org>; Wed, 11 May 2022 04:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UDplaZMb5YseJ+Hq/qs3ip7VsbbgryHldJFcbzukwP8=;
        b=FszPVWpTKntDOR0Vv0ugop2MPrpDjiL3PPYzu3zPu7r1lED2nMt5yeHJRUPyNlCF+P
         Q8vwhJUF2rlTGqbRbVThW0NLJAaD0RaNMl/6mIG7JZCvOwyI0TZah9pLZeyDZMzh20R3
         fMLYOLw6/mf74MOrEf/bit62EOAzwLsjRA/UEvwTopOENRPnwY1XY5dFcoKhE5JZFvib
         +ZtWYcyBy86IcBmGvlMEaTiZmxfTSmSzvzpsGvy8uDAkcdIN2WJTl8kz5FaXjkepgsLm
         5IsFNUm1+bvUGquDlRm25qsMIAgwLzz07E3GhRuOy8BvmbG44+++oEVxjHgWoUKrH1en
         SchQ==
X-Gm-Message-State: AOAM532xrQ4g6AhXJU3wdXphxOSnHgXVjd8POcoU01zEELSLfBu2tCp2
        R+B3nV35K7hmYpfzwwdbV+zl2BFq2gsbrNAf0LCzOOS4dMekajItJesJJJgiP3ruE00mmE2h8G5
        PHyNfUhUWZUJ4I9kj7jbK0q8=
X-Received: by 2002:a05:6000:1d8b:b0:20c:54e6:1659 with SMTP id bk11-20020a0560001d8b00b0020c54e61659mr22002275wrb.169.1652268741177;
        Wed, 11 May 2022 04:32:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8DOa4eVy/j4OxWjmKfDXFScY2hy71AEkR7bJehfJjo+JROKXYZWV1lJqXARoz2/Z0HXw3aQ==
X-Received: by 2002:a05:6000:1d8b:b0:20c:54e6:1659 with SMTP id bk11-20020a0560001d8b00b0020c54e61659mr22002251wrb.169.1652268740906;
        Wed, 11 May 2022 04:32:20 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id w12-20020adfde8c000000b0020c5253d8dfsm1476857wrl.43.2022.05.11.04.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 04:32:20 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zack Rusin <zackr@vmware.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilya Trukhanov <lahvuun@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Jones <pjones@redhat.com>
Subject: [PATCH v5 6/7] Revert "fbdev: Prevent probing generic drivers if a FB is already registered"
Date:   Wed, 11 May 2022 13:32:04 +0200
Message-Id: <20220511113204.1252828-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511112438.1251024-1-javierm@redhat.com>
References: <20220511112438.1251024-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Daniel Vetter <daniel.vetter@ffwll.ch>

This reverts commit fb561bf9abde49f7e00fdbf9ed2ccf2d86cac8ee.

With

commit 27599aacbaefcbf2af7b06b0029459bbf682000d
Author: Thomas Zimmermann <tzimmermann@suse.de>
Date:   Tue Jan 25 10:12:18 2022 +0100

    fbdev: Hot-unplug firmware fb devices on forced removal

this should be fixed properly and we can remove this somewhat hackish
check here (e.g. this won't catch drm drivers if fbdev emulation isn't
enabled).

Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Zack Rusin <zackr@vmware.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Zack Rusin <zackr@vmware.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Ilya Trukhanov <lahvuun@gmail.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Cc: Peter Jones <pjones@redhat.com>
Cc: linux-fbdev@vger.kernel.org

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/video/fbdev/efifb.c    | 11 -----------
 drivers/video/fbdev/simplefb.c | 11 -----------
 2 files changed, 22 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index ea42ba6445b2..edca3703b964 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -351,17 +351,6 @@ static int efifb_probe(struct platform_device *dev)
 	char *option = NULL;
 	efi_memory_desc_t md;
 
-	/*
-	 * Generic drivers must not be registered if a framebuffer exists.
-	 * If a native driver was probed, the display hardware was already
-	 * taken and attempting to use the system framebuffer is dangerous.
-	 */
-	if (num_registered_fb > 0) {
-		dev_err(&dev->dev,
-			"efifb: a framebuffer is already registered\n");
-		return -EINVAL;
-	}
-
 	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI || pci_dev_disabled)
 		return -ENODEV;
 
diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index 94fc9c6d0411..0ef41173325a 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -413,17 +413,6 @@ static int simplefb_probe(struct platform_device *pdev)
 	struct simplefb_par *par;
 	struct resource *res, *mem;
 
-	/*
-	 * Generic drivers must not be registered if a framebuffer exists.
-	 * If a native driver was probed, the display hardware was already
-	 * taken and attempting to use the system framebuffer is dangerous.
-	 */
-	if (num_registered_fb > 0) {
-		dev_err(&pdev->dev,
-			"simplefb: a framebuffer is already registered\n");
-		return -EINVAL;
-	}
-
 	if (fb_get_options("simplefb", NULL))
 		return -ENODEV;
 
-- 
2.35.1

