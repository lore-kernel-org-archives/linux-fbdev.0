Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23590C433EF
	for <linux-fbdev@archiver.kernel.org>; Wed, 11 May 2022 11:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbiEKLcE (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 11 May 2022 07:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238770AbiEKLcA (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 11 May 2022 07:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 792CC483B5
        for <linux-fbdev@vger.kernel.org>; Wed, 11 May 2022 04:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652268711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R2kp5jYCNfGNB7HC1VHLTEN7JTAmf+2Dpd6yPG+mBtE=;
        b=fdcVmaj6mD/KUJUzSGwyM2Xm4IpdMvN3dT+TwMry+vTe3gRvVc7sE1cbCJB030xQ1iKrLh
        pOWIsSKyR8qjOJ15xjoZKiBLWtkp1PF3qzGcKYwQmorvxHmHFjatqkI/Vq9CK5WAnv7DMs
        zwSPzcfnpASXXYg47Auakmd2RMRR3q0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-TJSpBrzSMcmGkVOshWUVtg-1; Wed, 11 May 2022 07:31:50 -0400
X-MC-Unique: TJSpBrzSMcmGkVOshWUVtg-1
Received: by mail-wr1-f70.google.com with SMTP id u11-20020a056000038b00b0020c9ea8b64fso738157wrf.2
        for <linux-fbdev@vger.kernel.org>; Wed, 11 May 2022 04:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R2kp5jYCNfGNB7HC1VHLTEN7JTAmf+2Dpd6yPG+mBtE=;
        b=7buTtT5FWAMHAHebxa7XY4GvV95o0FWkD0zR8mOp+95oVdy0wfSNDv376zamKabhvE
         WiRvoDWlfqHyAJ3RVBcA9GgBbWiMmOVsLZPbZnXZpv6Rtx6Bvs/SlkDiyXawOmGDmxux
         kqC5/RjXdKI0VlNT3DH27pvm4bsus9pxi7Emx4Ve5SyT/uWkehHy2OfP/TxRxLOtej7h
         1s5L8xdJZhuTWLY/1Fk1T3OBG92VUVVqh72rDg+YlxW79NayQsv8DYlvmlCLrLJIV8Ip
         vJspRuzHmUxoHG/rlrJUvluY1k/xMvS6vJ2iVUNZvdRYLMbzHFRT1CMltQ+czHxlGNHx
         baNA==
X-Gm-Message-State: AOAM533t5ia0ilafAV0V2vrK/kCQC1d7PWgHM+9YTuv0/fAUEIfWEMKd
        KVtl5mTrlUx9HiKH54ZALJftHFZSSBDihpssiwotffSzpLmFxYC1yXBgAxwLP2jKPdLkkXw389f
        Weptg9Z8W5YVS0lVlIKMkRqc=
X-Received: by 2002:a1c:4d10:0:b0:394:788a:24d7 with SMTP id o16-20020a1c4d10000000b00394788a24d7mr4323364wmh.113.1652268709256;
        Wed, 11 May 2022 04:31:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVdOZ6jj+GkTcslb2h+9g+NLK3aby//uMM8giiBszt74nPvf6lrNJh9rn58+o3dxXtHD+dwg==
X-Received: by 2002:a1c:4d10:0:b0:394:788a:24d7 with SMTP id o16-20020a1c4d10000000b00394788a24d7mr4323344wmh.113.1652268709014;
        Wed, 11 May 2022 04:31:49 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e8-20020a5d5308000000b0020c5253d8c2sm1450213wrv.14.2022.05.11.04.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 04:31:48 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5 5/7] fbdev: Disable sysfb device registration when removing conflicting FBs
Date:   Wed, 11 May 2022 13:31:44 +0200
Message-Id: <20220511113144.1252729-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511112438.1251024-1-javierm@redhat.com>
References: <20220511112438.1251024-1-javierm@redhat.com>
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
be called after a DRM or fbdev driver is probed and request to unregister
the devices for drivers with conflicting framebuffes.

To prevent this, disable any future sysfb platform device registration by
calling sysfb_disable(), if a driver requests to remove the conflicting
framebuffers.

Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---

Changes in v5:
- Move the sysfb_disable() call at conflicting framebuffers again to
  avoid the need of a DRIVER_FIRMWARE capability flag.
- Add Daniel Vetter's Reviewed-by tag again since reverted to the old
  patch that he already reviewed in v2.

Changes in v3:
- Call sysfb_disable() when a DRM dev and a fbdev are registered rather
  than when conflicting framebuffers are removed (Thomas Zimmermann).
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

 drivers/video/fbdev/core/fbmem.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 9b035ef4d552..265efa189bcc 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1789,6 +1789,17 @@ int remove_conflicting_framebuffers(struct apertures_struct *a,
 	if (do_free)
 		kfree(a);
 
+	/*
+	 * If a driver asked to unregister a platform device registered by
+	 * sysfb, then can be assumed that this is a driver for a display
+	 * that is set up by the system firmware and has a generic driver.
+	 *
+	 * Drivers for devices that don't have a generic driver will never
+	 * ask for this, so let's assume that a real driver for the display
+	 * was already probed and prevent sysfb to register devices later.
+	 */
+	sysfb_disable();
+
 	return 0;
 }
 EXPORT_SYMBOL(remove_conflicting_framebuffers);
-- 
2.35.1

