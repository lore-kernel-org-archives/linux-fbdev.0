Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D866C433FE
	for <linux-fbdev@archiver.kernel.org>; Tue,  8 Feb 2022 22:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387385AbiBHWX2 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386691AbiBHVIc (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 8 Feb 2022 16:08:32 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D78DC0612BC
        for <linux-fbdev@vger.kernel.org>; Tue,  8 Feb 2022 13:08:31 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id k3-20020a1ca103000000b0037bdea84f9cso176822wme.1
        for <linux-fbdev@vger.kernel.org>; Tue, 08 Feb 2022 13:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1IuiSyqatCt+l1wk5WgkOInkMrehuaZuz9Mxu04TsqY=;
        b=avHkOSu+x6pfmx4+fLtEewoBxnRMkJmK8t/rEpPIL34bWtfdlDa2+3sCJJZi5z4PuV
         ckFrSEhaJ0yEOaXqGl9xGK8CTEVT5ZIucUpSjA4gWTpu5UtAWEHI7DaOygEQd+miUzVZ
         fXH6kBN8oggwje5UwlVqhRF2IcoTAxLW3cqWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1IuiSyqatCt+l1wk5WgkOInkMrehuaZuz9Mxu04TsqY=;
        b=ia1YcMyNaPXhGlQIuDPK1QRFV0hsTQpdKSu8PWfJShuHSv63NM6IuzziRRtFrr5tMo
         +A3UnhDhUp7V4mgg26TMe1fRZoI7u6rvykBwFmZuZnwMl8sJ4A74cw8UXXaiB44SDq6O
         JxL/T+oZkd9CbEjUNQX7CWSb3q65YBpbrioMBFTsqoD4bTjiqsZZFdxNe3Xyypx+nHZX
         8KlqqssaSm7Zq99tfETEGudV+M8UM/ySB16jCUh62REylfEszrjUCW/+EzSo+u0WNbZK
         PoXFEgWm0k5pK99jF3ndshiZXHwlXjQ5JMcKwQx/omc9zStBm09wfSsXo4pBo0ifmrLb
         RSJA==
X-Gm-Message-State: AOAM533ylyFJPp+ek8nvrjfiTFKRQ0jMmAqFsrBz9MlUlyAd8KKgpDQm
        UiFqYd13EMbs3LzNu9gIxZZIEQ==
X-Google-Smtp-Source: ABdhPJyUoNAHSJRgncTABvPUK493XLqXy+tMNLIpUB+u6ODVBYoOWnDUowuWpfEK97CmfZnMhYogLg==
X-Received: by 2002:a1c:7915:: with SMTP id l21mr2580207wme.154.1644354510218;
        Tue, 08 Feb 2022 13:08:30 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o14sm3033561wmr.3.2022.02.08.13.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 13:08:29 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Helge Deller <deller@gmx.de>, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Du Cheng <ducheng2@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Claudio Suarez <cssk@net-c.es>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 01/19] fbcon: delete a few unneeded forward decl
Date:   Tue,  8 Feb 2022 22:08:06 +0100
Message-Id: <20220208210824.2238981-2-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
References: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

I didn't bother with any code movement to fix the others, these just
got a bit in the way.

v2: Rebase on top of Helge's reverts.

Acked-by: Sam Ravnborg <sam@ravnborg.org> (v1)
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org> (v1)
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Du Cheng <ducheng2@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Claudio Suarez <cssk@net-c.es>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/core/fbcon.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 2fc1b80a26ad..235eaab37d84 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -163,29 +163,14 @@ static int fbcon_cursor_noblink;
  *  Interface used by the world
  */
 
-static const char *fbcon_startup(void);
-static void fbcon_init(struct vc_data *vc, int init);
-static void fbcon_deinit(struct vc_data *vc);
-static void fbcon_clear(struct vc_data *vc, int sy, int sx, int height,
-			int width);
-static void fbcon_putc(struct vc_data *vc, int c, int ypos, int xpos);
-static void fbcon_putcs(struct vc_data *vc, const unsigned short *s,
-			int count, int ypos, int xpos);
 static void fbcon_clear_margins(struct vc_data *vc, int bottom_only);
-static void fbcon_cursor(struct vc_data *vc, int mode);
 static void fbcon_bmove(struct vc_data *vc, int sy, int sx, int dy, int dx,
 			int height, int width);
-static int fbcon_switch(struct vc_data *vc);
-static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch);
 static void fbcon_set_palette(struct vc_data *vc, const unsigned char *table);
 
 /*
  *  Internal routines
  */
-static __inline__ void ywrap_up(struct vc_data *vc, int count);
-static __inline__ void ywrap_down(struct vc_data *vc, int count);
-static __inline__ void ypan_up(struct vc_data *vc, int count);
-static __inline__ void ypan_down(struct vc_data *vc, int count);
 static void fbcon_bmove_rec(struct vc_data *vc, struct fbcon_display *p, int sy, int sx,
 			    int dy, int dx, int height, int width, u_int y_break);
 static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
@@ -194,8 +179,8 @@ static void fbcon_redraw_move(struct vc_data *vc, struct fbcon_display *p,
 			      int line, int count, int dy);
 static void fbcon_modechanged(struct fb_info *info);
 static void fbcon_set_all_vcs(struct fb_info *info);
-static void fbcon_start(void);
 static void fbcon_exit(void);
+
 static struct device *fbcon_device;
 
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
-- 
2.34.1

