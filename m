Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C251C2D0A3
	for <linux-fbdev@archiver.kernel.org>; Thu, 12 Nov 2020 12:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A32D22228
	for <linux-fbdev@archiver.kernel.org>; Thu, 12 Nov 2020 12:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIARY+rF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbgKLMQO (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 12 Nov 2020 07:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbgKLMQN (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 12 Nov 2020 07:16:13 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC7BC0613D1;
        Thu, 12 Nov 2020 04:16:13 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id a18so4371010pfl.3;
        Thu, 12 Nov 2020 04:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MPQ4TOsr/Zn4JKDK9zKQyfsUBs8Lur4NckSKEQ2T9Us=;
        b=AIARY+rFNzoLDqv93OqHzkS3m5skWiZGsLcPDoeOhAIrk2Kl22iYeHrl/Oa09tIDtR
         24/iQTLmYLUIPorErg3lQSWvU+rC4SzoT+eXsE8ojD5iYm+T7JL7qArjgOdv5GHv4Q/K
         bCLMuo2dZWtlzwqWSMh57mRq0Ducxtws73JzRsmBqJr8lASHkbe4TQy5XEXxk6yyNGpL
         asqBmp18Z4VhKwOSK6N+p2fHn/EirjPMLV8yhtQajS/ehA584kkbFNVPdfOC8DJumzUV
         VectLo7bvWuaNMxNCyKv7sG0VunXSsNTiL7BoK13xjtz7Z9n+qq+IhJyRhF9lzplom1y
         Qczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MPQ4TOsr/Zn4JKDK9zKQyfsUBs8Lur4NckSKEQ2T9Us=;
        b=LrfsBKK7myBdtYLfiWTEf7K/vWl4iSI0QeMW6LG+K+TYnEd4SWNMHu34utrJAri4UT
         YK1vmSEs1PojmyZPvI5Hnkh4JEwcGHQmA93C1SPHfogLSOicJY7bUJ1IsdFbjWIDbOkv
         RpjVD4LsbrzkoFDsEQU0iyVzPoRWuGnQdSYVhYENznvBkLaS5s3BWtCeYkrtYyLKjvYi
         Bmh160QMl5LHc0f7d2IW16eKn5YhfL7+lpJLA9vfMKgNSC+7UZn1IIHpBFFxkV81nClZ
         fKuV4Bsqh7avInvnQE4UPH5iW7UfW+s1HaNPyYcisf95h4KiOy5P4GtZgEK/J/K9cbQr
         rRvg==
X-Gm-Message-State: AOAM533xMYEGHtKI5bdT4RzvZ4tk3P8VIl5Xxg+1btU0RcJF34O+ZiUJ
        KVhBWvOH9lKBbQQkReqwOQ==
X-Google-Smtp-Source: ABdhPJxCOvSZJjgV8dmpjz1absHf9rtM/YAUdxiPjEAYsj3UD951nAJSsafqEKqv/yrVgqyHrCCCDg==
X-Received: by 2002:a17:90a:8b0e:: with SMTP id y14mr3967234pjn.57.1605183373347;
        Thu, 12 Nov 2020 04:16:13 -0800 (PST)
Received: from localhost.localdomain ([221.124.243.27])
        by smtp.gmail.com with ESMTPSA id d11sm6907485pjm.18.2020.11.12.04.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 04:16:12 -0800 (PST)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peilin Ye <yepeilin.cs@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 RFC 5/5] fbcon: Avoid using FNTCHARCNT() and hard-coded built-in font charcount
Date:   Thu, 12 Nov 2020 07:15:22 -0500
Message-Id: <e460a5780e54e3022661d5f09555144583b4cc59.1605169912.git.yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1605169912.git.yepeilin.cs@gmail.com>
References: <cover.1605169912.git.yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

For user-provided fonts, the framebuffer layer is using a magic
negative-indexing macro, FNTCHARCNT(), to keep track of their number of
characters:

	#define FNTCHARCNT(fd)	(((int *)(fd))[-3])

For built-in fonts, it is using hard-coded values (256). This results in
something like the following:

		map.length = (ops->p->userfont) ?
			FNTCHARCNT(ops->p->fontdata) : 256;

This is unsatisfactory. In fact, there is already a `charcount` field in
our virtual console descriptor (see `struct console_font` inside `struct
vc_data`), let us use it:

		map.length = vc->vc_font.charcount;

Recently we added a `charcount` field to `struct font_desc`. Use it to set
`vc->vc_font.charcount` properly. The idea is:

  - We only use FNTCHARCNT() on `vc->vc_font.data` and `p->fontdata`.
    Assume FNTCHARCNT() is working as intended;
  - Whenever `vc->vc_font.data` is set, also set `vc->vc_font.charcount`
    properly;
  - We can now replace `FNTCHARCNT(vc->vc_font.data)` with
    `vc->vc_font.charcount`;
  - Since `p->fontdata` always point to the same font data buffer with
    `vc->vc_font.data`, we can also replace `FNTCHARCNT(p->fontdata)` with
    `vc->vc_font.charcount`.

In conclusion, set `vc->vc_font.charcount` properly in fbcon_startup(),
fbcon_init(), fbcon_set_disp() and fbcon_do_set_font(), then replace
FNTCHARCNT() with `vc->vc_font.charcount`. No more if-else between
negative-indexing macros and hard-coded values.

Do not include <linux/font.h> in fbcon_rotate.c and tileblit.c, since they
no longer need it.

Depends on patch "Fonts: Add charcount field to font_desc".

Suggested-by: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
v2: https://lore.kernel.org/lkml/20201028155139.1220549-1-yepeilin.cs@gmail.com/

Boot-tested only, thus the "RFC". Looking forward to suggestions about how
to test this properly. Thank you!

I am not very sure about the statement "`p->fontdata` always point to the
same font data buffer with `vc->vc_font.data`". It is concluded from code
reading.

Change in v3:
  - Do not touch fbcon_copy_font() since we removed it in patch "console:
    Delete unused con_font_copy() callback implementations"

Changes in v2:
  - Try avoid using FNTCHARCNT() altogether, instead of only changing a
    little bit (Daniel)
  - Set `vc->vc_font.charcount` properly, in fbcon_startup(),
    fbcon_init(), fbcon_set_disp() and fbcon_do_set_font()
  - Replace hard-coded 256 whenever possible

 drivers/video/fbdev/core/fbcon.c        | 57 +++++++++----------------
 drivers/video/fbdev/core/fbcon_rotate.c |  3 +-
 drivers/video/fbdev/core/tileblit.c     |  4 +-
 3 files changed, 23 insertions(+), 41 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 26d1b0916692..06520667fc07 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1004,7 +1004,7 @@ static const char *fbcon_startup(void)
 		vc->vc_font.width = font->width;
 		vc->vc_font.height = font->height;
 		vc->vc_font.data = (void *)(p->fontdata = font->data);
-		vc->vc_font.charcount = 256; /* FIXME  Need to support more fonts */
+		vc->vc_font.charcount = font->charcount;
 	} else {
 		p->fontdata = vc->vc_font.data;
 	}
@@ -1032,7 +1032,7 @@ static void fbcon_init(struct vc_data *vc, int init)
 	struct vc_data **default_mode = vc->vc_display_fg;
 	struct vc_data *svc = *default_mode;
 	struct fbcon_display *t, *p = &fb_display[vc->vc_num];
-	int logo = 1, new_rows, new_cols, rows, cols, charcnt = 256;
+	int logo = 1, new_rows, new_cols, rows, cols;
 	int cap, ret;
 
 	if (WARN_ON(info_idx == -1))
@@ -1068,6 +1068,7 @@ static void fbcon_init(struct vc_data *vc, int init)
 						    fvc->vc_font.data);
 			vc->vc_font.width = fvc->vc_font.width;
 			vc->vc_font.height = fvc->vc_font.height;
+			vc->vc_font.charcount = fvc->vc_font.charcount;
 			p->userfont = t->userfont;
 
 			if (p->userfont)
@@ -1083,17 +1084,13 @@ static void fbcon_init(struct vc_data *vc, int init)
 			vc->vc_font.width = font->width;
 			vc->vc_font.height = font->height;
 			vc->vc_font.data = (void *)(p->fontdata = font->data);
-			vc->vc_font.charcount = 256; /* FIXME  Need to
-							support more fonts */
+			vc->vc_font.charcount = font->charcount;
 		}
 	}
 
-	if (p->userfont)
-		charcnt = FNTCHARCNT(p->fontdata);
-
 	vc->vc_can_do_color = (fb_get_color_depth(&info->var, &info->fix)!=1);
 	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
-	if (charcnt == 256) {
+	if (vc->vc_font.charcount == 256) {
 		vc->vc_hi_font_mask = 0;
 	} else {
 		vc->vc_hi_font_mask = 0x100;
@@ -1358,7 +1355,7 @@ static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
 	struct vc_data **default_mode, *vc;
 	struct vc_data *svc;
 	struct fbcon_ops *ops = info->fbcon_par;
-	int rows, cols, charcnt = 256;
+	int rows, cols;
 
 	p = &fb_display[unit];
 
@@ -1378,12 +1375,11 @@ static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
 		vc->vc_font.data = (void *)(p->fontdata = t->fontdata);
 		vc->vc_font.width = (*default_mode)->vc_font.width;
 		vc->vc_font.height = (*default_mode)->vc_font.height;
+		vc->vc_font.charcount = (*default_mode)->vc_font.charcount;
 		p->userfont = t->userfont;
 		if (p->userfont)
 			REFCOUNT(p->fontdata)++;
 	}
-	if (p->userfont)
-		charcnt = FNTCHARCNT(p->fontdata);
 
 	var->activate = FB_ACTIVATE_NOW;
 	info->var.activate = var->activate;
@@ -1393,7 +1389,7 @@ static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
 	ops->var = info->var;
 	vc->vc_can_do_color = (fb_get_color_depth(&info->var, &info->fix)!=1);
 	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
-	if (charcnt == 256) {
+	if (vc->vc_font.charcount == 256) {
 		vc->vc_hi_font_mask = 0;
 	} else {
 		vc->vc_hi_font_mask = 0x100;
@@ -2027,7 +2023,7 @@ static int fbcon_resize(struct vc_data *vc, unsigned int width,
 		 */
 		if (pitch <= 0)
 			return -EINVAL;
-		size = CALC_FONTSZ(vc->vc_font.height, pitch, FNTCHARCNT(vc->vc_font.data));
+		size = CALC_FONTSZ(vc->vc_font.height, pitch, vc->vc_font.charcount);
 		if (size > FNTSIZE(vc->vc_font.data))
 			return -EINVAL;
 	}
@@ -2075,7 +2071,7 @@ static int fbcon_switch(struct vc_data *vc)
 	struct fbcon_ops *ops;
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	struct fb_var_screeninfo var;
-	int i, ret, prev_console, charcnt = 256;
+	int i, ret, prev_console;
 
 	info = registered_fb[con2fb_map[vc->vc_num]];
 	ops = info->fbcon_par;
@@ -2152,10 +2148,7 @@ static int fbcon_switch(struct vc_data *vc)
 	vc->vc_can_do_color = (fb_get_color_depth(&info->var, &info->fix)!=1);
 	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
 
-	if (p->userfont)
-		charcnt = FNTCHARCNT(vc->vc_font.data);
-
-	if (charcnt > 256)
+	if (vc->vc_font.charcount > 256)
 		vc->vc_complement_mask <<= 1;
 
 	updatescrollmode(p, info, vc);
@@ -2405,31 +2398,27 @@ static void set_vc_hi_font(struct vc_data *vc, bool set)
 	}
 }
 
-static int fbcon_do_set_font(struct vc_data *vc, int w, int h,
+static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 			     const u8 * data, int userfont)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct fbcon_ops *ops = info->fbcon_par;
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	int resize;
-	int cnt;
 	char *old_data = NULL;
 
 	resize = (w != vc->vc_font.width) || (h != vc->vc_font.height);
 	if (p->userfont)
 		old_data = vc->vc_font.data;
-	if (userfont)
-		cnt = FNTCHARCNT(data);
-	else
-		cnt = 256;
 	vc->vc_font.data = (void *)(p->fontdata = data);
 	if ((p->userfont = userfont))
 		REFCOUNT(data)++;
 	vc->vc_font.width = w;
 	vc->vc_font.height = h;
-	if (vc->vc_hi_font_mask && cnt == 256)
+	vc->vc_font.charcount = charcount;
+	if (vc->vc_hi_font_mask && charcount == 256)
 		set_vc_hi_font(vc, false);
-	else if (!vc->vc_hi_font_mask && cnt == 512)
+	else if (!vc->vc_hi_font_mask && charcount == 512)
 		set_vc_hi_font(vc, true);
 
 	if (resize) {
@@ -2496,9 +2485,10 @@ static int fbcon_set_font(struct vc_data *vc, struct console_font *font,
 	if (!new_data)
 		return -ENOMEM;
 
+	memset(new_data, 0, FONT_EXTRA_WORDS * sizeof(int));
+
 	new_data += FONT_EXTRA_WORDS * sizeof(int);
 	FNTSIZE(new_data) = size;
-	FNTCHARCNT(new_data) = charcount;
 	REFCOUNT(new_data) = 0;	/* usage counter */
 	for (i=0; i< charcount; i++) {
 		memcpy(new_data + i*h*pitch, data +  i*32*pitch, h*pitch);
@@ -2524,7 +2514,7 @@ static int fbcon_set_font(struct vc_data *vc, struct console_font *font,
 			break;
 		}
 	}
-	return fbcon_do_set_font(vc, font->width, font->height, new_data, 1);
+	return fbcon_do_set_font(vc, font->width, font->height, charcount, new_data, 1);
 }
 
 static int fbcon_set_def_font(struct vc_data *vc, struct console_font *font, char *name)
@@ -2540,7 +2530,7 @@ static int fbcon_set_def_font(struct vc_data *vc, struct console_font *font, cha
 
 	font->width = f->width;
 	font->height = f->height;
-	return fbcon_do_set_font(vc, f->width, f->height, f->data, 0);
+	return fbcon_do_set_font(vc, f->width, f->height, f->charcount, f->data, 0);
 }
 
 static u16 palette_red[16];
@@ -3009,7 +2999,6 @@ void fbcon_get_requirement(struct fb_info *info,
 			   struct fb_blit_caps *caps)
 {
 	struct vc_data *vc;
-	struct fbcon_display *p;
 
 	if (caps->flags) {
 		int i, charcnt;
@@ -3018,11 +3007,9 @@ void fbcon_get_requirement(struct fb_info *info,
 			vc = vc_cons[i].d;
 			if (vc && vc->vc_mode == KD_TEXT &&
 			    info->node == con2fb_map[i]) {
-				p = &fb_display[i];
 				caps->x |= 1 << (vc->vc_font.width - 1);
 				caps->y |= 1 << (vc->vc_font.height - 1);
-				charcnt = (p->userfont) ?
-					FNTCHARCNT(p->fontdata) : 256;
+				charcnt = vc->vc_font.charcount;
 				if (caps->len < charcnt)
 					caps->len = charcnt;
 			}
@@ -3032,11 +3019,9 @@ void fbcon_get_requirement(struct fb_info *info,
 
 		if (vc && vc->vc_mode == KD_TEXT &&
 		    info->node == con2fb_map[fg_console]) {
-			p = &fb_display[fg_console];
 			caps->x = 1 << (vc->vc_font.width - 1);
 			caps->y = 1 << (vc->vc_font.height - 1);
-			caps->len = (p->userfont) ?
-				FNTCHARCNT(p->fontdata) : 256;
+			caps->len = vc->vc_font.charcount;
 		}
 	}
 }
diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
index ac72d4f85f7d..ef1d421c261a 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.c
+++ b/drivers/video/fbdev/core/fbcon_rotate.c
@@ -14,7 +14,6 @@
 #include <linux/fb.h>
 #include <linux/vt_kern.h>
 #include <linux/console.h>
-#include <linux/font.h>
 #include <asm/types.h>
 #include "fbcon.h"
 #include "fbcon_rotate.h"
@@ -33,7 +32,7 @@ static int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 
 	src = ops->fontdata = vc->vc_font.data;
 	ops->cur_rotate = ops->p->con_rotate;
-	len = (!ops->p->userfont) ? 256 : FNTCHARCNT(src);
+	len = vc->vc_font.charcount;
 	s_cellsize = ((vc->vc_font.width + 7)/8) *
 		vc->vc_font.height;
 	d_cellsize = s_cellsize;
diff --git a/drivers/video/fbdev/core/tileblit.c b/drivers/video/fbdev/core/tileblit.c
index 628fe5e010c0..e2cc0cb6d50e 100644
--- a/drivers/video/fbdev/core/tileblit.c
+++ b/drivers/video/fbdev/core/tileblit.c
@@ -13,7 +13,6 @@
 #include <linux/fb.h>
 #include <linux/vt_kern.h>
 #include <linux/console.h>
-#include <linux/font.h>
 #include <asm/types.h>
 #include "fbcon.h"
 
@@ -145,8 +144,7 @@ void fbcon_set_tileops(struct vc_data *vc, struct fb_info *info)
 		map.width = vc->vc_font.width;
 		map.height = vc->vc_font.height;
 		map.depth = 1;
-		map.length = (ops->p->userfont) ?
-			FNTCHARCNT(ops->p->fontdata) : 256;
+		map.length = vc->vc_font.charcount;
 		map.data = ops->p->fontdata;
 		info->tileops->fb_settile(info, &map);
 	}
-- 
2.25.1

