Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36D6C433EF
	for <linux-fbdev@archiver.kernel.org>; Thu,  5 May 2022 22:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352708AbiEEWII (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 5 May 2022 18:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237116AbiEEWII (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 5 May 2022 18:08:08 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B7F71EEF0
        for <linux-fbdev@vger.kernel.org>; Thu,  5 May 2022 15:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651788266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ncwUrPXa6D//xAE+gUKX4W9jlEJvsWNrctcaxVQSCb8=;
        b=Isl8L8SfNHWV+t69isu/BtN20Sgshf/20p+Iu+td7e6wq1+qXH2knLE4E/Uhwye1+93X0Y
        IHG2r22GyP17PK67t3geDT+zboBJqO/ytwvdrjtbwsE5lolvvk2LpZIsMYKCkwo6F7cMxG
        /n3gjTxzKGS0hfURfM3Q8/z6dBSem2g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-B5bSwudJNImKQaS0N_vm6g-1; Thu, 05 May 2022 18:04:25 -0400
X-MC-Unique: B5bSwudJNImKQaS0N_vm6g-1
Received: by mail-wr1-f72.google.com with SMTP id p18-20020adf9592000000b00207bc12decbso1870534wrp.21
        for <linux-fbdev@vger.kernel.org>; Thu, 05 May 2022 15:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ncwUrPXa6D//xAE+gUKX4W9jlEJvsWNrctcaxVQSCb8=;
        b=Jd2nA0/2oBAZ8KcHOL0tKHQpGZqKSLK1BmWvrWDghM2cUtfWohFrR8TEFg9j9qN1vM
         UcRrF/Pjm8eoLMXfAu4FBHpTr/+Bn8t0r5SpXJOLBqMHQ2v6xZdYXqYOyQtxBDxRClvr
         LNkWYvR8TEc5NUcy/NvyJ/JSzQH7Ulgf9XyCGdUs44RQ/vx3ntWcmFGrqw/eQGn2vdkp
         /lGb/Iebj7ZGoGRQmfyg2JHjEoO9PxfUzBJvW78POlZ+OowmZFwryMEh6eo2UN3PEtjq
         wuqhsicADAWmNieHTC7QC0WmMTO0jh8hT0lxiVbjULSdyFOK9690OKvAfSsZ0XVeKxw6
         jzIA==
X-Gm-Message-State: AOAM5303pt01BGDpn2Xrqt5nBP70t0XadhV1YiMzZwmL2PQBz7RyYB9q
        vbLfS/bDKTt2aGY5jZC//TbMgKTjrxNR2x22SiBk6Fr3U/ZZjgIdlhxGxL2COwdRFMusOaeEomT
        q4C0FuFisy3HI9N+mbp/jeY8=
X-Received: by 2002:a05:600c:3d8c:b0:394:6097:9994 with SMTP id bi12-20020a05600c3d8c00b0039460979994mr6726651wmb.29.1651788263959;
        Thu, 05 May 2022 15:04:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfwhAOIQeVF2O3srNOg8rIqNBWMADJBM0ucjW4JDKss+KaRrP/Oe0Hd/iuu0biw9+SXEcE9g==
X-Received: by 2002:a05:600c:3d8c:b0:394:6097:9994 with SMTP id bi12-20020a05600c3d8c00b0039460979994mr6726643wmb.29.1651788263758;
        Thu, 05 May 2022 15:04:23 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c3b1500b003942a244f4bsm7980875wms.36.2022.05.05.15.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 15:04:23 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 1/4] fbdev: Prevent possible use-after-free in fb_release()
Date:   Fri,  6 May 2022 00:04:13 +0200
Message-Id: <20220505220413.365977-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505215947.364694-1-javierm@redhat.com>
References: <20220505215947.364694-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Daniel Vetter <daniel.vetter@ffwll.ch>

Most fbdev drivers have issues with the fb_info lifetime, because call to
framebuffer_release() from their driver's .remove callback, rather than
doing from fbops.fb_destroy callback.

Doing that will destroy the fb_info too early, while references to it may
still exist, leading to a use-after-free error.

To prevent this, check the fb_info reference counter when attempting to
kfree the data structure in framebuffer_release(). That will leak it but
at least will prevent the mentioned error.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---

(no changes since v1)

 drivers/video/fbdev/core/fbsysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index 8c1ee9ecec3d..c2a60b187467 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -80,6 +80,10 @@ void framebuffer_release(struct fb_info *info)
 {
 	if (!info)
 		return;
+
+	if (WARN_ON(refcount_read(&info->count)))
+		return;
+
 	kfree(info->apertures);
 	kfree(info);
 }
-- 
2.35.1

