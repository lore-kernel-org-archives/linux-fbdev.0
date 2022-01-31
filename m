Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AA3C433FE
	for <linux-fbdev@archiver.kernel.org>; Mon, 31 Jan 2022 21:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379750AbiAaVGw (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 31 Jan 2022 16:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379844AbiAaVGt (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 31 Jan 2022 16:06:49 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F122AC061759
        for <linux-fbdev@vger.kernel.org>; Mon, 31 Jan 2022 13:06:42 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id e2so27977304wra.2
        for <linux-fbdev@vger.kernel.org>; Mon, 31 Jan 2022 13:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gNEcCsAHbmO8BObbR0rzHcF3KU0XqbiUyO0AgqiLr9Q=;
        b=XB0If8d+oNzt5EGFOz/pJSfVqwossHreq5Z3/8sGNGT1tWVb8HeX+PuSX4HzuKCtxL
         85Ce3vd3TA/uayqURoZ6LVnYYD+zcPj1L3cM6aaDGzt5LCXHqB2YeYKof0DAcvGHjWoE
         WAj/NXLBP9zyNJqrR3yjJ4zw+CAjDKmq/tKN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gNEcCsAHbmO8BObbR0rzHcF3KU0XqbiUyO0AgqiLr9Q=;
        b=mC8VSeyLgldefumImMTfRKu/bUVSbFOnGcdLnY+GEDEq079RmatfJqjSSguksvVaOe
         SeWNUYomvdShrBKFGrtM9J5sESfZwZzeg3QlSjtZpmIqmAEI7+PLOy3lGKibHWGoCtXe
         pcpARNiFsyhVUFBPiLELnBnEH4sQKamIajjbmL3zSUe1Rs3opnv9b53w1AYye3oFnwSM
         TOyh7Mv8Q3X85RvUdOcp3mHAbFc67eroL4vKlQyYx6mTzL5V/wiLwoXuo3+N+2+In9fn
         0IzO+2WVTrOdDX8YUn47A2aVRjG2PfD20A+IFRWpLRXlWF/O40BxjM9E3VvdWGkApZ4c
         9QTg==
X-Gm-Message-State: AOAM5338bTIMpSFMEgaUbz3XGqTinPlp9tCtL7XQ1hvfXzXsTtr+So+g
        liR8moYwekP/QrAIPya5yccrRA==
X-Google-Smtp-Source: ABdhPJyCY4pMX5KDnbLHXSX+AzjieeB1bfyqYC6ZVcKQr80N8d2mwo0uPWz2LhfKAg4dG48zDem7wQ==
X-Received: by 2002:a05:6000:1d90:: with SMTP id bk16mr9737566wrb.217.1643663201557;
        Mon, 31 Jan 2022 13:06:41 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b11sm314961wmq.46.2022.01.31.13.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 13:06:41 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Helge Deller <deller@gmx.de>, Daniel Vetter <daniel@ffwll.ch>,
        Qing Wang <wangqing@vivo.com>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 07/21] fbdev/sysfs: Fix locking
Date:   Mon, 31 Jan 2022 22:05:38 +0100
Message-Id: <20220131210552.482606-8-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
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
2.33.0

