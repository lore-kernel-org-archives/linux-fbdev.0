Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159B9C433F5
	for <linux-fbdev@archiver.kernel.org>; Tue,  8 Feb 2022 22:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387419AbiBHWXz (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386710AbiBHVIl (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 8 Feb 2022 16:08:41 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4479FC0612BA
        for <linux-fbdev@vger.kernel.org>; Tue,  8 Feb 2022 13:08:40 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c192so142065wma.4
        for <linux-fbdev@vger.kernel.org>; Tue, 08 Feb 2022 13:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+/n/16RZ52OxmA0UdDabSATFo04ROfy75nWG7tM3V6I=;
        b=hRasZriqWBEeJzoUOLv/QgNtugplRHjEQRKqik65NeifTKzyRf0hhvBW1KWOkIoadP
         3babK90zxgB9jGgUf/UNp4JC9Y+PrFYPgiRob7sYtSxpvX3uoVU0VosLdxIxxSp78Mvv
         nGxEaJzOsmX/d0hVbISOd5f0gVyHiJlADJFE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+/n/16RZ52OxmA0UdDabSATFo04ROfy75nWG7tM3V6I=;
        b=e8x0MXbWP6KiP9jpb6mjXeRNqF3NRyH2yPDJrYGdBUvwZDoW+QwAxh0Grg1dm1JcuB
         uW3gITsgJdxKuSy8nn4WyL1HEFpdJmOEcMYa3QD6EZe3p8FIjotD1xXNg24CzYCE0H+a
         1o6wSmRKaKlaHxx9pPXeuUXEd1zsL+wkZet5OOcf9yx/CCnw3b1f2nsE2uCvSjTqdA5M
         MxsZTBsGYiSfmSjahWWV4XEk6DdKc1CfmHOaUKdmfBzdbzhMl/KeV7EDFdPolkBylOVP
         67pwhleU93Eye24hmkUZTcypDwgyscovps6OWcikuIgnQm01/bk9ybNNShDaSgAUMrXm
         vogQ==
X-Gm-Message-State: AOAM530wdyIXVLRVonqA8x+RqH41LyhwXTCyfWMok0DjWMn3gCuBVLjE
        Wdb8ss/RT40K2dAsU/U5MLhCRQ==
X-Google-Smtp-Source: ABdhPJxmKGvfzwrGcNB45zpKYvGa2R6htrHXkrCRtBsrNPeFRtFyXvFPfIN1bLeHK+Zv9iVuAwVA7Q==
X-Received: by 2002:a1c:f60b:: with SMTP id w11mr2637250wmc.138.1644354518818;
        Tue, 08 Feb 2022 13:08:38 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o14sm3033561wmr.3.2022.02.08.13.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 13:08:35 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Helge Deller <deller@gmx.de>, Daniel Vetter <daniel@ffwll.ch>,
        Qing Wang <wangqing@vivo.com>
Subject: [PATCH v2 05/19] fbdev/sysfs: Fix locking
Date:   Tue,  8 Feb 2022 22:08:10 +0100
Message-Id: <20220208210824.2238981-6-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
References: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

fb_set_var requires we hold the fb_info lock. Or at least this now
matches what the ioctl does ...

Note that ps3fb and sh_mobile_lcdcfb are busted in different ways here,
but I will not fix them up.

Also in practice this isn't a big deal, because really variable fbdev
state is actually protected by console_lock (because fbcon just
doesn't bother with lock_fb_info() at all), and lock_fb_info
protecting anything is really just a neat lie. But that's a much
bigger fish to fry.

Acked-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Qing Wang <wangqing@vivo.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/video/fbdev/core/fbsysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index 26892940c213..8c1ee9ecec3d 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -91,9 +91,11 @@ static int activate(struct fb_info *fb_info, struct fb_var_screeninfo *var)
 
 	var->activate |= FB_ACTIVATE_FORCE;
 	console_lock();
+	lock_fb_info(fb_info);
 	err = fb_set_var(fb_info, var);
 	if (!err)
 		fbcon_update_vcs(fb_info, var->activate & FB_ACTIVATE_ALL);
+	unlock_fb_info(fb_info);
 	console_unlock();
 	if (err)
 		return err;
-- 
2.34.1

