Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6EEC433EF
	for <linux-fbdev@archiver.kernel.org>; Tue,  8 Feb 2022 22:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387441AbiBHWYE (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386720AbiBHVIq (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 8 Feb 2022 16:08:46 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA946C0612B8
        for <linux-fbdev@vger.kernel.org>; Tue,  8 Feb 2022 13:08:45 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l123-20020a1c2581000000b0037b9d960079so2043570wml.0
        for <linux-fbdev@vger.kernel.org>; Tue, 08 Feb 2022 13:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kxmmBkNFc2e7V4ERjxKal7nxxEacNSK1FsSHDJ/tyIc=;
        b=Z09sK1MIQXvHodEW69pcLwZPAC2Jyh1Yq9ldGqdLR7reUraZE7M6u7jdOOeYRDBf89
         UUxkLMzeLBfxd3O4D0f+4VPHvHICjubc4fPRQHDK7GB4hbBxyg8oSXZLVun1qG1/NbkT
         QOvr5w/LmHavg6G1SUwn1zrJxyAMEJXhXZfiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kxmmBkNFc2e7V4ERjxKal7nxxEacNSK1FsSHDJ/tyIc=;
        b=qIK7lws/9tNkbzxsyNIWgUaiYRTHO+wQxBjfHf4Z9glDVww8pszLZPdSAdlcEz02Va
         tbNxu8mV38urZtKT7MoIbXbkCFSXl03qnuh6+Nf1uTR7BWLTrhGmKV/e6xDNVdmvz3k8
         AXvheXBRd+gAJ//ziToOXOqv2dgv+s3+yvn6zap0r1p1IYA3YxTT8RX+9Bqj+VK4Clwy
         9qWrzhXpjo4dsLathy+x/95Jj2CXNAUqXo1OSE7wS8i8m3yv9PNWB7JHSIWXdMvvhTpv
         uXx+5DoFgeXLmw+nXoZBKXUiZPqkXN8htBh2eJNKvqUPibMYIWR4pBITagyKY87dsDkq
         LMkg==
X-Gm-Message-State: AOAM530cuwPNBCCPO5XX7A2i6erSAYki8eJgmt6IhLaqGIyACSBLw0RB
        XS4mkA1sdsnS4nP+AY3LNHZgyajb/5qDQA==
X-Google-Smtp-Source: ABdhPJx9Pmbs1AtHCBnIRUQUhg6MOdNihnyQs/peWemRHhguZJlE+pEmulNqns55/ByeHXTnphkZ2g==
X-Received: by 2002:a05:600c:3394:: with SMTP id o20mr2536218wmp.186.1644354524370;
        Tue, 08 Feb 2022 13:08:44 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o14sm3033561wmr.3.2022.02.08.13.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 13:08:44 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH v2 08/19] fb: Delete fb_info->queue
Date:   Tue,  8 Feb 2022 22:08:13 +0100
Message-Id: <20220208210824.2238981-9-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
References: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

It was only used by fbcon, and that now switched to its own,
private work.

Acked-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
---
 include/linux/fb.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 3d7306c9a706..23b19cf8bccd 100644
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
2.34.1

