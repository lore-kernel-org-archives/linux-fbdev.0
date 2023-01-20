Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2A7C05027
	for <linux-fbdev@archiver.kernel.org>; Fri, 20 Jan 2023 12:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjATMJT (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 20 Jan 2023 07:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjATMJT (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 20 Jan 2023 07:09:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D4BA5CFE
        for <linux-fbdev@vger.kernel.org>; Fri, 20 Jan 2023 04:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674216511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zizGqLgDtMjJvJ8Y3gxXr4ehRe41Dz0Ln+Ptew+d+Lc=;
        b=eIZiPK+wIvIMWXlBtnGsbDSRXjGB5QLJaazXA9bMNv2lf+CVC6lQqzGRWadh2c8YVWWVLA
        pgRqv6y0UYiJmo5fODVquOfBEroC3zhUuYgL1Txlv/zKU83nfhVUFCTKQTh9Gy6CY90ewJ
        sPg/gViIzY7xB2NtBFQw4v+u6Dzdl4w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-637-aLRPZDIlOfmR82igGrVs5g-1; Fri, 20 Jan 2023 07:08:30 -0500
X-MC-Unique: aLRPZDIlOfmR82igGrVs5g-1
Received: by mail-wm1-f69.google.com with SMTP id q19-20020a1cf313000000b003d96c95e2f9so1255294wmq.2
        for <linux-fbdev@vger.kernel.org>; Fri, 20 Jan 2023 04:08:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zizGqLgDtMjJvJ8Y3gxXr4ehRe41Dz0Ln+Ptew+d+Lc=;
        b=BZVuoZcxCIEDN9jusekCRnqV23ZxbHZ1xqaD3+v8wwhdDYcv2lnC3Dgpe9DGqnWWbX
         fZrD5Bov/6y2kt7n4F/hNM6h/gQNH+McSE0uMLP72KVkrWQ33noYbZtHLr29Ix/aCUlH
         6CfR2+N2B0uIeSQfodE+QFzTC0YGT/QdmP39qUVlRforHXo+NBIHmBNCntb5raWATsAG
         vyMmnjkhSjBG2l5DrfFTb+pr2yU6tR3ttLy7XNRWMsv7bQHJTmSRjIwsdJj9q3wnbca6
         uEJix1mveyemKaoAQCu/nl17F50mJUUNnc9mT173fhjMVNIuqcA0qnapH3/aVyztc1Tb
         Dc2A==
X-Gm-Message-State: AFqh2koXRLsWoDUqQbVzmLUtktECvd6zteKG/mjolrSCgdxm/4G9RRSg
        6Arw2TWlzZRu0AMCP3UW+s+SzsaGUcvOv2e4AnYg3JZ39Xyxbz8YVbYENAafwtZxa4lawYbtrUL
        k6QFDZ40iAl9+Fm2gh6xid8k=
X-Received: by 2002:a05:6000:178a:b0:2be:276c:fb60 with SMTP id e10-20020a056000178a00b002be276cfb60mr15613278wrg.64.1674216508963;
        Fri, 20 Jan 2023 04:08:28 -0800 (PST)
X-Google-Smtp-Source: AMrXdXviXDLfJrvvimx9Nj+OGPkScIhm/b1eowt9jkmdc00+VtEL6f75NCTIAkwUkDVqtpQmvMRwHg==
X-Received: by 2002:a05:6000:178a:b0:2be:276c:fb60 with SMTP id e10-20020a056000178a00b002be276cfb60mr15613257wrg.64.1674216508766;
        Fri, 20 Jan 2023 04:08:28 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600012c400b002bbb2d43f65sm32766336wrx.14.2023.01.20.04.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 04:08:27 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Jaya Kumar <jayalk@intworks.biz>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 1/3] fbdev: Remove unused struct fb_deferred_io .first_io field
Date:   Fri, 20 Jan 2023 13:08:20 +0100
Message-Id: <20230120120822.2536032-2-javierm@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120120822.2536032-1-javierm@redhat.com>
References: <20230120120822.2536032-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This optional callback was added in the commit 1f45f9dbb392 ("fb_defio:
add first_io callback") but it was never used by a driver. Let's remove
it since it's unlikely that will be used after a decade that was added.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/video/fbdev/core/fb_defio.c | 4 ----
 include/linux/fb.h                  | 1 -
 2 files changed, 5 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index c730253ab85c..1b680742b7f3 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -157,10 +157,6 @@ static vm_fault_t fb_deferred_io_track_page(struct fb_info *info, unsigned long
 	/* protect against the workqueue changing the page list */
 	mutex_lock(&fbdefio->lock);
 
-	/* first write in this cycle, notify the driver */
-	if (fbdefio->first_io && list_empty(&fbdefio->pagereflist))
-		fbdefio->first_io(info);
-
 	pageref = fb_deferred_io_pageref_get(info, offset, page);
 	if (WARN_ON_ONCE(!pageref)) {
 		ret = VM_FAULT_OOM;
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 30183fd259ae..daf336385613 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -215,7 +215,6 @@ struct fb_deferred_io {
 	struct mutex lock; /* mutex that protects the pageref list */
 	struct list_head pagereflist; /* list of pagerefs for touched pages */
 	/* callback */
-	void (*first_io)(struct fb_info *info);
 	void (*deferred_io)(struct fb_info *info, struct list_head *pagelist);
 };
 #endif
-- 
2.39.0

