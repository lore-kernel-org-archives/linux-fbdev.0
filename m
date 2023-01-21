Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055EBC25B50
	for <linux-fbdev@archiver.kernel.org>; Sat, 21 Jan 2023 19:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjAUT0U (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 21 Jan 2023 14:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjAUT0P (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 21 Jan 2023 14:26:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127F22B0AF
        for <linux-fbdev@vger.kernel.org>; Sat, 21 Jan 2023 11:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674329088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5yb3FH8jX0MWRXyzAKd1yTC1HwTjMT1KOtJHzdpTmLM=;
        b=JoSuW22kD4TqqlrfuHNe42PBpjKHYTsC1g9ogMSXkOL6chSmXJuGZ8XYBNsyBPNrWiBJbT
        0XbURgn32N0X58rZpypWRPxu9EyDUG78ZYWwyoU5hq8Fio5x9gNZVufHPcc/YT9FEuqbI/
        Bte3HR08zhhdT1+7wrPcpiDMrpGv6M8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-187-WbY8f10iMyaN3fcdWhfXGg-1; Sat, 21 Jan 2023 14:24:47 -0500
X-MC-Unique: WbY8f10iMyaN3fcdWhfXGg-1
Received: by mail-wr1-f70.google.com with SMTP id v15-20020adfe4cf000000b002bf9413bc50so627731wrm.16
        for <linux-fbdev@vger.kernel.org>; Sat, 21 Jan 2023 11:24:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5yb3FH8jX0MWRXyzAKd1yTC1HwTjMT1KOtJHzdpTmLM=;
        b=qsOOsM+8mzlh5A8SvlfHNnRQ8odXdZedf/cjw7rkGrzP6oa9DTCYYzHIL7bGirioad
         PZwtlUa56Qqn8V0U5ffrDNQS3TFhfKuqLGH7BHvU3VnZQxhd5Z63bWQfMo4Ji3ZQM2Gl
         yB5LsY2CmYYVPPixTKqbc4ZNLkgq20yqeCsNVLc7ZqvPVH7w6HhspA5V7wHssHLubOrc
         5zBCepBGC/6236YYhGYnVX/ADuI+WD7kvJ0acvGMMX1mm8NV/FLVT9bvAbT3rUKXtHT5
         glD/HiZhX2iKZ5ctMGfyc9lprwUl556tl2ofXP04mvCyeL0pm19E63mQb7hJsPC243ep
         IYrw==
X-Gm-Message-State: AFqh2kplVu/Uu+j8yo581WFxQ1V4MmbH5bsoWMgLGznhWcLlO0uR8S7m
        gNbQUXw+8AA07xRXTfVIM50Q0dJ94ePBrY9/SgMhnXGIbYJLaiVMrXQyjmZQPEaLH1lbVpI7Wjg
        Wu36K7+vGZ9Num1Vregus1k0=
X-Received: by 2002:a05:600c:2255:b0:3da:f950:8168 with SMTP id a21-20020a05600c225500b003daf9508168mr17593294wmm.35.1674329085898;
        Sat, 21 Jan 2023 11:24:45 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu7/XGYvbQvHdPX4KdE971lVGAfQ0ExgfrXkYtLzVOSmg7BGN71xkjtA3ao8ZGPeTndCrBicQ==
X-Received: by 2002:a05:600c:2255:b0:3da:f950:8168 with SMTP id a21-20020a05600c225500b003daf9508168mr17593290wmm.35.1674329085743;
        Sat, 21 Jan 2023 11:24:45 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b003daff80f16esm8544321wmg.27.2023.01.21.11.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 11:24:45 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <mripard@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Jaya Kumar <jayalk@intworks.biz>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v2 1/3] fbdev: Remove unused struct fb_deferred_io .first_io field
Date:   Sat, 21 Jan 2023 20:24:16 +0100
Message-Id: <20230121192418.2814955-2-javierm@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121192418.2814955-1-javierm@redhat.com>
References: <20230121192418.2814955-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This optional callback was added in the commit 1f45f9dbb392 ("fb_defio:
add first_io callback") but it was never used by a driver. Let's remove
it since it's unlikely that will be used after a decade that was added.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---

(no changes since v1)

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

