Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17496C433F5
	for <linux-fbdev@archiver.kernel.org>; Mon, 31 Jan 2022 21:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380698AbiAaVHN (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 31 Jan 2022 16:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379706AbiAaVGu (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 31 Jan 2022 16:06:50 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9173EC06173D
        for <linux-fbdev@vger.kernel.org>; Mon, 31 Jan 2022 13:06:45 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so254728wmb.1
        for <linux-fbdev@vger.kernel.org>; Mon, 31 Jan 2022 13:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fEFT7RaLl3MIWyBeJu8+YbW4+Kc4zGdBG2ByELA82FY=;
        b=GUAHnoGJ2g60XQIxA1S0UBTEjmAhGsZ5SnXwaSbMm4WguOGFJ080okWbKoG6WuelXb
         voQq0GCXWqeAxlMSnqXUzcMTJe09M5cg5JRDYNy2F4304We++p19+m+1PzPGP4OK3sng
         CMHb0eixfCd0LaM62LMEll+iAEqIn9PA0TosA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fEFT7RaLl3MIWyBeJu8+YbW4+Kc4zGdBG2ByELA82FY=;
        b=D8gtGIQA3YVknJx9O7d2Bei/DbdPc7VBznJx5TiZUngfKQlmMjcs56+Shi0NruMVR/
         XGWnJjrrjFB1RoKLVIin2PLt5bsTJnEBi14tVYfwsCoeGSopBqVm19NxaCsbtUGXkaZv
         nZiMLojQe2ZNpNC7+xVHm8PjwZ/lywRGY3Reo+XztnKoV9vJmZNadE4xd9xdyOEG2+ty
         nEQNZQ78a/jqmH1wVRfdW3n960FnJ1PU6vkdLtJ9Rirfk52lzWUsj6atn2HfL/227N+p
         iSaXrEhxb6uJH69tbgdzsp5yQrUJ/WNq0HorTD+U0R8NVWEftAhibSsDpT10VJJZvw89
         ugBQ==
X-Gm-Message-State: AOAM5301iq4RPCNO5gJ2Fl1/Erc3UjzyjLeKz6azbzYht8LJ+evTWh6T
        DMytE6wsN3ggQRJrAtIki8kjLmZ8cDN8Mw==
X-Google-Smtp-Source: ABdhPJwadVtgHupBXYfEY4Bh9lTcVc2T1fYq6ymL+YzCfw4JZaBt+O2KULSz2DRwEILgsDakrL0ghg==
X-Received: by 2002:a05:600c:1f15:: with SMTP id bd21mr28339002wmb.145.1643663204166;
        Mon, 31 Jan 2022 13:06:44 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b11sm314961wmq.46.2022.01.31.13.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 13:06:43 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 10/21] fb: Delete fb_info->queue
Date:   Mon, 31 Jan 2022 22:05:41 +0100
Message-Id: <20220131210552.482606-11-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

It was only used by fbcon, and that now switched to its own,
private work.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
---
 include/linux/fb.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 02f362c661c8..a8a00d2ba1f3 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -449,7 +449,6 @@ struct fb_info {
 	struct fb_var_screeninfo var;	/* Current var */
 	struct fb_fix_screeninfo fix;	/* Current fix */
 	struct fb_monspecs monspecs;	/* Current Monitor specs */
-	struct work_struct queue;	/* Framebuffer event queue */
 	struct fb_pixmap pixmap;	/* Image hardware mapper */
 	struct fb_pixmap sprite;	/* Cursor hardware mapper */
 	struct fb_cmap cmap;		/* Current cmap */
-- 
2.33.0

