Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAB7C433FE
	for <linux-fbdev@archiver.kernel.org>; Wed, 20 Apr 2022 08:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376992AbiDTI4N (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 20 Apr 2022 04:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376984AbiDTI4K (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 20 Apr 2022 04:56:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FFD13818C
        for <linux-fbdev@vger.kernel.org>; Wed, 20 Apr 2022 01:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650444804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Brj5kPf1vp2+xvAmZf1o0QRVBdqqcyn2KbRWKGy9p24=;
        b=LKoBTEmSFbu6Hb/PWvw2HxpFZdPyIxF6zb5C0GtmJVD6hEVTYTa7/mHdvFu8O4y2fDmKMv
        fBDAngLp7GiJ0LjJDl0K8T+K3BwvqKZPuVrm3S4LTJCxEedjp9IWQkjJkTYgaRJ6KD4zqY
        0rwOE3DhM/XI3tD8g4CzQMN26ytJ/V4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-MSxn-xiPMq2FyC5PEYjL2w-1; Wed, 20 Apr 2022 04:53:20 -0400
X-MC-Unique: MSxn-xiPMq2FyC5PEYjL2w-1
Received: by mail-wm1-f71.google.com with SMTP id 125-20020a1c0283000000b003928cd3853aso2160664wmc.9
        for <linux-fbdev@vger.kernel.org>; Wed, 20 Apr 2022 01:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Brj5kPf1vp2+xvAmZf1o0QRVBdqqcyn2KbRWKGy9p24=;
        b=g1EbbHnV182lm2a8rLBaRu9RWEzeKS2lkVzdTNdfFFeBezHGxlx8rgTQYbkWtOQEXJ
         oGRXti0AsmXUlgkFdNQ5grxD0EE1sPg31p+o0nfO7kye847+ERa3vKhtnczNQ6Jmchee
         uwo4SjSbL3I9RpYvKlVy3eOwGZW4qK0s3WhjD2BrVtfeADlZKJBpZB8N2eT3rLDlWb4x
         sE97a1ZvF6lF1Yld0r5P7z3GeKS3N152SPF7BftJr+PcGgJOj9OXaB01GnzaKfJlgJdT
         V+f6rAW0QaOf568g4VDnMtYSYTcRJPVaJZY8W8fmuSMc+MORFzUgCKDF26uZBo58S2ck
         8SkQ==
X-Gm-Message-State: AOAM5339buZE1GsKUB6O+SO04QY6or5a3iJdXKJSP8qUNXA2F7Dxpx9n
        IFHHgzs5L0d0T52AjSZDjIQyriF1DbhWjqnh6rH9hlMw5rsKM9yi2S8PyQZ2Xf9IqvFBYH8AafQ
        j2jiplsWU9iSRE6DcwxhZWDE=
X-Received: by 2002:a1c:3b87:0:b0:38e:ae26:87c3 with SMTP id i129-20020a1c3b87000000b0038eae2687c3mr2579007wma.117.1650444799066;
        Wed, 20 Apr 2022 01:53:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzisiOp22RzVsqiZMkzUyzv5bMt9mjVky1BUXdtYfPSyZywBr9TqZ6k14/+L6ay5mbfLa1Byw==
X-Received: by 2002:a1c:3b87:0:b0:38e:ae26:87c3 with SMTP id i129-20020a1c3b87000000b0038eae2687c3mr2578982wma.117.1650444798811;
        Wed, 20 Apr 2022 01:53:18 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i14-20020a0560001ace00b0020aac00f862sm1895343wry.98.2022.04.20.01.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 01:53:18 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-fbdev@vger.kernel.org
Subject: [PATCH v3 3/5] fbdev: Restart conflicting fb removal loop when unregistering devices
Date:   Wed, 20 Apr 2022 10:53:01 +0200
Message-Id: <20220420085303.100654-4-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420085303.100654-1-javierm@redhat.com>
References: <20220420085303.100654-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Drivers that want to remove registered conflicting framebuffers prior to
register their own framebuffer, calls remove_conflicting_framebuffers().

This function takes the registration_lock mutex, to prevent a races when
drivers register framebuffer devices. But if a conflicting framebuffer
device is found, the underlaying platform device is unregistered and this
will lead to the platform driver .remove callback to be called, which in
turn will call to the unregister_framebuffer() that takes the same lock.

To prevent this, a struct fb_info.forced_out field was used as indication
to unregister_framebuffer() whether the mutex has to be grabbed or not.

A cleaner solution is to drop the lock before platform_device_unregister()
so unregister_framebuffer() can take it when called from the fbdev driver,
and just grab the lock again after the device has been registered and do
a removal loop restart.

Since the framebuffer devices will already be removed, the loop would just
finish when no more conflicting framebuffers are found.

Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---

(no changes since v1)

 drivers/video/fbdev/core/fbmem.c | 22 +++++++++++++++-------
 include/linux/fb.h               |  1 -
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 84427470367b..0bb459258df3 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1553,6 +1553,7 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
 {
 	int i;
 
+restart_removal:
 	/* check all firmware fbs and kick off if the base addr overlaps */
 	for_each_registered_fb(i) {
 		struct apertures_struct *gen_aper;
@@ -1585,12 +1586,23 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
 				pr_warn("fb%d: no device set\n", i);
 				do_unregister_framebuffer(registered_fb[i]);
 			} else if (dev_is_platform(device)) {
-				registered_fb[i]->forced_out = true;
+				/*
+				 * Drop the lock because if the device is unregistered, its
+				 * driver will call to unregister_framebuffer(), that takes
+				 * this lock.
+				 */
+				mutex_unlock(&registration_lock);
 				platform_device_unregister(to_platform_device(device));
+				mutex_lock(&registration_lock);
 			} else {
 				pr_warn("fb%d: cannot remove device\n", i);
 				do_unregister_framebuffer(registered_fb[i]);
 			}
+			/*
+			 * Restart the removal loop now that the device has been
+			 * unregistered and its associated framebuffer gone.
+			 */
+			goto restart_removal;
 		}
 	}
 }
@@ -1897,13 +1909,9 @@ EXPORT_SYMBOL(register_framebuffer);
 void
 unregister_framebuffer(struct fb_info *fb_info)
 {
-	bool forced_out = fb_info->forced_out;
-
-	if (!forced_out)
-		mutex_lock(&registration_lock);
+	mutex_lock(&registration_lock);
 	do_unregister_framebuffer(fb_info);
-	if (!forced_out)
-		mutex_unlock(&registration_lock);
+	mutex_unlock(&registration_lock);
 }
 EXPORT_SYMBOL(unregister_framebuffer);
 
diff --git a/include/linux/fb.h b/include/linux/fb.h
index f95da1af9ff6..b781bc721113 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -502,7 +502,6 @@ struct fb_info {
 	} *apertures;
 
 	bool skip_vt_switch; /* no VT switch on suspend/resume required */
-	bool forced_out; /* set when being removed by another driver */
 };
 
 static inline struct apertures_struct *alloc_apertures(unsigned int max_num) {
-- 
2.35.1

