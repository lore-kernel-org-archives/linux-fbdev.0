Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDF1C433EF
	for <linux-fbdev@archiver.kernel.org>; Fri, 29 Apr 2022 08:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355974AbiD2Iqr (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 29 Apr 2022 04:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355984AbiD2Iqn (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 29 Apr 2022 04:46:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7060AC42CE
        for <linux-fbdev@vger.kernel.org>; Fri, 29 Apr 2022 01:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651221803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UDplaZMb5YseJ+Hq/qs3ip7VsbbgryHldJFcbzukwP8=;
        b=U7i50dcwnuVcFg7vzfU0Odeyc2piyfq7FGbYmQLgAeMThQ5bcHxHu1/eKjl3TfVdokUn94
        6Yib/O6obMEgArnquFQDmF3Vu/p/VAjt3VUh+PJpPcYmuJDa2iRvE5Ref8odRTBdOgDfi3
        xPprOQZKM9C0AV8crvVI03LwKEVdJvU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135--tqRpApdN_GPB4ltMmKkVg-1; Fri, 29 Apr 2022 04:43:21 -0400
X-MC-Unique: -tqRpApdN_GPB4ltMmKkVg-1
Received: by mail-wr1-f69.google.com with SMTP id o11-20020adfca0b000000b0020adc114131so2804881wrh.8
        for <linux-fbdev@vger.kernel.org>; Fri, 29 Apr 2022 01:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UDplaZMb5YseJ+Hq/qs3ip7VsbbgryHldJFcbzukwP8=;
        b=J/nQMROjkaUar8yW0+yd6m288U7xKPozORWdFvebzduRo1zu2LwkBqLHF1Bkzf8PlZ
         CPychKGZgRbGMD8VedmAWhhG09r6GqA2/dUJXNPs1AbY9gKPqFfL63wdc6HYopXMEc4Z
         mJ2HaIUAdOikiZR0VMNosg/1KNFLPNdNt16KAuD+havxBI1NkkezdTvC+NfZgSJjjXRd
         peq8jli2/VSVwp6zyEUfeY/9YAPC8TWgQ6ZiG7OBu7mZlmydgZhsobrH/2MVXpCCwiyM
         AUDrEHE9TyOgjlg+4YTktxZde4/Zmw3rmXeD6ZmEsF2nkN5vjz6NWg37uTFR5vbmh9v9
         XvvQ==
X-Gm-Message-State: AOAM531PKZZLU0qMzCCwN+qZm7+svkeKCp4ZROg120zQPwj/Ta37PgBv
        CtgNYu0eyAfsFAvJkJlk0cw5O5g3IW52EIzfXk2BDx+kR63eaf42ZdoiNFUw8CF94bXR8VMsE5Y
        DURy3Vgh6E+PAkGeLWZjtp9w=
X-Received: by 2002:a05:600c:502b:b0:38f:f7c6:3609 with SMTP id n43-20020a05600c502b00b0038ff7c63609mr2151323wmr.15.1651221800681;
        Fri, 29 Apr 2022 01:43:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUhJr7adxWPTzLPcLhzy6SAp4kBXCJcXEMXapEUCxJwsbfEcTFBfqvmjks4+3ERNh1qQu2xw==
X-Received: by 2002:a05:600c:502b:b0:38f:f7c6:3609 with SMTP id n43-20020a05600c502b00b0038ff7c63609mr2151311wmr.15.1651221800430;
        Fri, 29 Apr 2022 01:43:20 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c4e8700b00393f1393abfsm7199256wmq.41.2022.04.29.01.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 01:43:20 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Zack Rusin <zackr@vmware.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilya Trukhanov <lahvuun@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Jones <pjones@redhat.com>, linux-fbdev@vger.kernel.org,
        Helge Deller <deller@gmx.de>
Subject: [RFC PATCH v4 10/11] Revert "fbdev: Prevent probing generic drivers if a FB is already registered"
Date:   Fri, 29 Apr 2022 10:42:52 +0200
Message-Id: <20220429084253.1085911-11-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429084253.1085911-1-javierm@redhat.com>
References: <20220429084253.1085911-1-javierm@redhat.com>
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

