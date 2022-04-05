Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F5CC433F5
	for <linux-fbdev@archiver.kernel.org>; Wed,  6 Apr 2022 01:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358194AbiDFA7g (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 5 Apr 2022 20:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352257AbiDEVYV (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 5 Apr 2022 17:24:21 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0371DF60
        for <linux-fbdev@vger.kernel.org>; Tue,  5 Apr 2022 14:03:50 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso390537wml.5
        for <linux-fbdev@vger.kernel.org>; Tue, 05 Apr 2022 14:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UCMwHF3uk919Wx1ZFBokmmNohbFfAzQpLpge8K0yLz0=;
        b=gmXHelE4Rj7vy22zgP55hLEh9RsElk3Dlkapg2DeMXKxO1Riu+3loZKo4vDEr15wdT
         PgjSUvzqWgTy1QVi8KUPYQuV0In4ANqCne62OMaxvORk6lNQZvFmkQjZhN4T38K0Kstt
         pKOf7h9QJI7cs46T4dRgLCCDRRYJBVBgLq/yQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UCMwHF3uk919Wx1ZFBokmmNohbFfAzQpLpge8K0yLz0=;
        b=POhhzOlCJtAsfJPHFChqiU5Tg14y1BS6SUc1LWwxH83tFKUcv+kTlFyg9IuBO6ZSZo
         RJOUHo/CbdyPNKcrgpT+5C2pcEVgvIBk+w1oAl52LWzU8aIWAQQNWzosFPE9Af4tW/t7
         ZwgXZwRabBUMe4ve9sT6i2duzmUAgs2p6KFWn0RQRKwPa8EMPXFjZox0R/yG1cjOaJzk
         UFfRPJcm5ly4WXEEI+mj3YHvtitQeEAcLEjiCKe0hy7hclVXnVepv3PmDK65gYvOeUqb
         eYzSfGzwQTlyyexas5n61Ejo+8DFFVYXy8ApbJiHTB+Yi02FGCFuyjFuqDqp5HB25Dk2
         wR8A==
X-Gm-Message-State: AOAM531N4jVYHYhDaRKryR/pNNrpTOtMwuwZ/YcVkQp9gMZ0bpQxzv1G
        076TEvHeqApwXrwe5VoJpjo/Rw==
X-Google-Smtp-Source: ABdhPJzGuI7sDox55NXIDF1CsyAOGKpFf1LM70EWTffJxN0QpYSrQtWR+/bEYbhl3D+OAoPEvh/X6w==
X-Received: by 2002:a05:600c:354d:b0:38c:e71a:c230 with SMTP id i13-20020a05600c354d00b0038ce71ac230mr4579966wmq.86.1649192629155;
        Tue, 05 Apr 2022 14:03:49 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id az19-20020a05600c601300b0038cadf3aa69sm4858569wmb.36.2022.04.05.14.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 14:03:48 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org
Subject: [PATCH v3 08/17] fb: Delete fb_info->queue
Date:   Tue,  5 Apr 2022 23:03:26 +0200
Message-Id: <20220405210335.3434130-9-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220405210335.3434130-1-daniel.vetter@ffwll.ch>
References: <20220405210335.3434130-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

It was only used by fbcon, and that now switched to its own,
private work.

Acked-by: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
---
 include/linux/fb.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 9a77ab615c36..f95da1af9ff6 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -450,7 +450,6 @@ struct fb_info {
 	struct fb_var_screeninfo var;	/* Current var */
 	struct fb_fix_screeninfo fix;	/* Current fix */
 	struct fb_monspecs monspecs;	/* Current Monitor specs */
-	struct work_struct queue;	/* Framebuffer event queue */
 	struct fb_pixmap pixmap;	/* Image hardware mapper */
 	struct fb_pixmap sprite;	/* Cursor hardware mapper */
 	struct fb_cmap cmap;		/* Current cmap */
-- 
2.34.1

