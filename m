Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A63C433FE
	for <linux-fbdev@archiver.kernel.org>; Fri, 29 Apr 2022 08:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356001AbiD2Iqq (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 29 Apr 2022 04:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355974AbiD2Iqn (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 29 Apr 2022 04:46:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5846C3EA5
        for <linux-fbdev@vger.kernel.org>; Fri, 29 Apr 2022 01:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651221800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u/nkZHXCBB5ZrJnB24ro/1pCmNvdbhB1vwTZ80wJLns=;
        b=eETKrAnUtaKf3YNwNIkU0gjWjnir1lCPhqv2nHuZC4i11qP3ZZWMZkuocy8mkQtQ7BcT5l
        czLU8lU43hE/CNCpxq1hZ9qeupK0I3eHT71uHbTmVV6VdX18ZPT4+Zwsg4GLvckdJ5Cz2s
        49ceEQFfVrk7RjFzixtklAr+mwjVQq0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-kR9SQXwEOcK_RoSmpJeshA-1; Fri, 29 Apr 2022 04:43:19 -0400
X-MC-Unique: kR9SQXwEOcK_RoSmpJeshA-1
Received: by mail-wm1-f72.google.com with SMTP id bh11-20020a05600c3d0b00b003928fe7ba07so2222539wmb.6
        for <linux-fbdev@vger.kernel.org>; Fri, 29 Apr 2022 01:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u/nkZHXCBB5ZrJnB24ro/1pCmNvdbhB1vwTZ80wJLns=;
        b=Wc6zPS+C0Q9T4yLLPoin8HOpVvBcFzOLiqIfkCIsNrPibzVM22elmjMHlHUVvy6rNw
         hM/CyX146Z+yjKljihtx5vJQ/5ppEbyEy9MsQpKuMU42j3T514acsFbvrya7lc382fFB
         +zM9RnWwoTRqQMm8lFZ7RXMHbFOlr+qNvtPpiPVI7Q8Oh/vyqLMc2593L8dJaTDBs8mq
         rzGQINKtZGrzwaFkOU8j3huDkqeLAN4rGtqT7fWBVS3WCFzZu/N79wp5xI7Gax2hPccj
         d9Yr7or5Pf+glMOxBehSp1N6L2B9IC9ItsmXEXWrxqNqTihrAsZhnyYBQ9Y1Qd6k1n1e
         8ULw==
X-Gm-Message-State: AOAM533xdqolwQ9b36p50jk4eBAA+ce9j5czmPkqRK+DO/FCuK5RyNpS
        iRXyFEr/tUSAYpukh6XaGaBQmY+BmKX3CfBKYj6F2GLAu8A/dOPTuuyG9Es3FdPA9e2T09td5ez
        MdrnZnmyGtk1lPO1Su42nHrY=
X-Received: by 2002:adf:decb:0:b0:20a:c975:8eec with SMTP id i11-20020adfdecb000000b0020ac9758eecmr28946000wrn.438.1651221797471;
        Fri, 29 Apr 2022 01:43:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8Bnodipm9XVNni3rYsFrTH34G/LMUhH0fq+PeE59BdcIE+fgw0hrkNZbBfqT2Hiuz7RWIbw==
X-Received: by 2002:adf:decb:0:b0:20a:c975:8eec with SMTP id i11-20020adfdecb000000b0020ac9758eecmr28945970wrn.438.1651221797201;
        Fri, 29 Apr 2022 01:43:17 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c4e8700b00393f1393abfsm7199256wmq.41.2022.04.29.01.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 01:43:16 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-fbdev@vger.kernel.org
Subject: [RFC PATCH v4 08/11] fbdev: Fix race between sysfb and framebuffer devices registration
Date:   Fri, 29 Apr 2022 10:42:50 +0200
Message-Id: <20220429084253.1085911-9-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429084253.1085911-1-javierm@redhat.com>
References: <20220429084253.1085911-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The platform devices registered by sysfb match with firmware-based DRM or
fbdev drivers, that are used to have early graphics using a framebuffer
provided by the system firmware.

DRM or fbdev drivers later are probed and remove all conflicting framebuffers,
leading to these platform devices for generic drivers to be unregistered.

But the current solution has a race, since the sysfb_init() function could
be called after a DRM driver is probed and requested to unregister devices
for drivers with conflicting framebuffes.

To prevent this, disable any future sysfb platform device registration by
calling sysfb_disable(), if either a framebuffer device or a DRM device is
registered. Since in that case a display will already be present.

Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v3)

Changes in v3:
- Call sysfb_disable() when a fbdev framebuffer is registered rather
  than when conflicting framebuffers are removed (Thomas Zimmermann).
- Drop Daniel Vetter's Reviewed-by tag since patch changed a lot.

Changes in v2:
- Explain in the commit message that fbmem has to unregister the device
  as fallback if a driver registered the device itself (Daniel Vetter).
- Also explain that fallback in a comment in the code (Daniel Vetter).
- Don't encode in fbmem the assumption that sysfb will always register
  platform devices (Daniel Vetter).
- Add a FIXME comment about drivers registering devices (Daniel Vetter).

 drivers/video/fbdev/core/fbmem.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index d6ae33990f40..7583296481b0 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/major.h>
 #include <linux/slab.h>
+#include <linux/sysfb.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/vt.h>
@@ -1903,6 +1904,17 @@ register_framebuffer(struct fb_info *fb_info)
 	ret = do_register_framebuffer(fb_info);
 	mutex_unlock(&registration_lock);
 
+	/*
+	 * If a driver registers a framebuffer device, then it can be assumed
+	 * that a display will be present and there is no need for a generic
+	 * driver using the firmware setup system framebuffer.
+	 *
+	 * Disable sysfb and prevent registering simple framebuffer devices,
+	 * but only do it for framebuffers that are not provided by firmware.
+	 */
+	if (!(fb_info->flags & FBINFO_MISC_FIRMWARE))
+		sysfb_disable();
+
 	return ret;
 }
 EXPORT_SYMBOL(register_framebuffer);
-- 
2.35.1

