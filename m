Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F07C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed,  4 May 2022 21:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345181AbiEDWAU (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 4 May 2022 18:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357062AbiEDWAT (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 4 May 2022 18:00:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFD244C7B5
        for <linux-fbdev@vger.kernel.org>; Wed,  4 May 2022 14:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651701402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nuNgpe3lAKna2dZKI13IhuymSX1vIwYgln5kdRF+8fw=;
        b=hP6CLL9913Ogp7W4mCc/toyLRARHrpJ9fNCgFlGCKSRzmrPwLtVJLhJT6AmqWhkxj7r17Y
        0AYTQcn40A62da8++1uVdLyV6ZmjiBELWqfFHrcg7k2QySgB/9aBDTVKgOo5PqcxCPOjjo
        lLxk8DKJ2x43z2CfUbX5pj8BrEe6sZw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-344-hEYmOSEvPUWnRMlBB6ZyRQ-1; Wed, 04 May 2022 17:56:41 -0400
X-MC-Unique: hEYmOSEvPUWnRMlBB6ZyRQ-1
Received: by mail-wm1-f71.google.com with SMTP id z23-20020a05600c221700b003942fd37764so3567879wml.8
        for <linux-fbdev@vger.kernel.org>; Wed, 04 May 2022 14:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nuNgpe3lAKna2dZKI13IhuymSX1vIwYgln5kdRF+8fw=;
        b=mot7LqqgYsmTpPddHvOTzYqCr5knCjjvLW+uWx0kQmH7NmU5GSMa1sBnuia6vvVbET
         fzpo8wI/6xJ7dfnAGOlYojPCPj3gbzppg/KYNSjeR+AFOEI7S5bYUgdzZ0DRN2DpoVpp
         VKrZ+8ziSmdDQaauKks6VYbhIgMLVr34GZAigemvfdzQ2QlNBytpWELb47gnXfkWQf5G
         rKapzW8rKoZ4Qkh7RscIvUAG4QfEud5DDLr9M5HrvKhYCSueExKI5VklLn5ZzJ81hLH4
         sBsVMdKXfqbRCV6AET9bN1CiiOZDUm593dKAa0N8ICSnAGxsJS8gwtBzJd1hAWjUvAaC
         7i2w==
X-Gm-Message-State: AOAM531RjFN7g92OQeqzKlsZH3qXRZzUgsp01n8XrlYrsRd9u3iFe6yM
        14d5qUBrZOr2iAaHntTVByueb7cjMjtOVLQrhh/JxYYH92twqxG12ynmwTVow83alGq4vPp144+
        g547kjRwFe0oyMU0h12vf6Zg=
X-Received: by 2002:adf:fc52:0:b0:20c:4c8a:e370 with SMTP id e18-20020adffc52000000b0020c4c8ae370mr18157755wrs.161.1651701399738;
        Wed, 04 May 2022 14:56:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEPrShm5zua4UvoQHUdnN5BxXwamXBRJdW2Ea++RHDLWBCw+teWP2XtDDnUQk73fLTD222dQ==
X-Received: by 2002:adf:fc52:0:b0:20c:4c8a:e370 with SMTP id e18-20020adffc52000000b0020c4c8ae370mr18157745wrs.161.1651701399466;
        Wed, 04 May 2022 14:56:39 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id a25-20020adfb519000000b0020c5253d920sm16164086wrd.108.2022.05.04.14.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 14:56:39 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH 1/3] fbdev: Prevent possible use-after-free in fb_release()
Date:   Wed,  4 May 2022 23:56:31 +0200
Message-Id: <20220504215631.56756-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220504215151.55082-1-javierm@redhat.com>
References: <20220504215151.55082-1-javierm@redhat.com>
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
---

 drivers/video/fbdev/core/fbsysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index 26892940c213..82e31a2d845e 100644
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

