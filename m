Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63546C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed,  4 May 2022 10:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344178AbiEDKz2 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 4 May 2022 06:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235739AbiEDKz1 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 4 May 2022 06:55:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 545BB22B3A
        for <linux-fbdev@vger.kernel.org>; Wed,  4 May 2022 03:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651661510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NJbghp3+LJBmX5DLTTjlRaPAzEhF/Td/rezzenPMwDw=;
        b=Sx7+P8Yfn5aRo9SAuikjdcSjMpfmrg61kYl6mvsG3T5qA4kPsXWm5Fe5m68xqpR9HPQxzN
        KwUohBUlpzm6gLhoQ447q9o5Qr+wr7OUbDrINLHWleY2OBX6xwLWA4z4hye5G4ozgIlfpU
        Cj1ZHHiBR/PY6P/uVRQ1FjHbf9gWhdE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-L2y-0FICNa2hnIjnbwNTDA-1; Wed, 04 May 2022 06:51:49 -0400
X-MC-Unique: L2y-0FICNa2hnIjnbwNTDA-1
Received: by mail-wr1-f70.google.com with SMTP id t17-20020adfa2d1000000b0020ac519c222so250352wra.4
        for <linux-fbdev@vger.kernel.org>; Wed, 04 May 2022 03:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NJbghp3+LJBmX5DLTTjlRaPAzEhF/Td/rezzenPMwDw=;
        b=Nb6jPCsfciGBnDThsAlqwzDmdwELbjf/TgaER/naCba+eLPadXs61+8FfPHp9SLKZx
         zFtN2ukMioOpEJjT7M9VidUgyKeG1csWNE87KbwBNpw1QXGvEK/fpEqdzKdqQFyfIYQa
         wnhTLhU4tSQJfsJlImaxwOIOhb6yq7SmdXL+0sYK1D7/swMRNlPiKUd8209+DrI203St
         bZlnvYK0yNTjuTGySsUJ9kK3hH+Ja0mqHdzfk3nfwr1LdEEhmhVbhhskIxT4tcDzFppz
         D19nJH+PQ68Rm1e6V4Pjygw1CQZsn3/Le1QKpUarVfoIvj0LHmR795Gzt3oqxIXJDprC
         0+Dg==
X-Gm-Message-State: AOAM5335t8qFPZn6q5fl8PSpOILSHl8n48ydu3CVI/NqD1QjkTZj56R8
        375QeyR1GrjTaaKqi1O5s9NY2X9Bh8dxzFfQUGqCt6116IBmx0RbdOt06fy+6zoh5Wnw7MbzSST
        NmbHPFL8dL1US4AtfSAVDpd4=
X-Received: by 2002:a05:600c:3b93:b0:394:57c8:5901 with SMTP id n19-20020a05600c3b9300b0039457c85901mr2728268wms.77.1651661508153;
        Wed, 04 May 2022 03:51:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHwZYfl8uqgIw+kp7JWSBmK2205DO05PCu90DnmuLlXgv2vl2YCs3ySMEP+CKrlNnqkYViRw==
X-Received: by 2002:a05:600c:3b93:b0:394:57c8:5901 with SMTP id n19-20020a05600c3b9300b0039457c85901mr2728247wms.77.1651661507884;
        Wed, 04 May 2022 03:51:47 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n14-20020adfc60e000000b0020c6a524fd5sm6700603wrg.99.2022.05.04.03.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 03:51:47 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH] Revert "fbdev: Make fb_release() return -ENODEV if fbdev was unregistered"
Date:   Wed,  4 May 2022 12:51:40 +0200
Message-Id: <20220504105140.746344-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This reverts commit aafa025c76dcc7d1a8c8f0bdefcbe4eb480b2f6a. That commit
attempted to fix a NULL pointer dereference, caused by the struct fb_info
associated with a framebuffer device to not longer be valid when the file
descriptor was closed.

But the solution was wrong since it was just papering over the issue, and
also would leak any resources that might be reference counted in fb_open.

Instead, the fbdev drivers that are releasing the fb_info too soon should
be fixed to prevent this situation to happen.

Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/video/fbdev/core/fbmem.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 97eb0dee411c..a6bb0e438216 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1434,10 +1434,7 @@ fb_release(struct inode *inode, struct file *file)
 __acquires(&info->lock)
 __releases(&info->lock)
 {
-	struct fb_info * const info = file_fb_info(file);
-
-	if (!info)
-		return -ENODEV;
+	struct fb_info * const info = file->private_data;
 
 	lock_fb_info(info);
 	if (info->fbops->fb_release)
-- 
2.35.1

