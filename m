Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304F5C433ED
	for <linux-fbdev@archiver.kernel.org>; Thu, 13 May 2021 00:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B6716100A
	for <linux-fbdev@archiver.kernel.org>; Thu, 13 May 2021 00:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbhEMAlQ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 12 May 2021 20:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241887AbhEMAiv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 12 May 2021 20:38:51 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08247C06134B;
        Wed, 12 May 2021 17:37:20 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id E2D6E92009E; Thu, 13 May 2021 02:37:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id DB98492009C;
        Thu, 13 May 2021 02:37:19 +0200 (CEST)
Date:   Thu, 13 May 2021 02:37:19 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Daniel Vetter <daniel@ffwll.ch>,
        Martin Hostettler <textshell@uchuujin.de>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] vgacon: Record video mode changes with VT_RESIZEX
In-Reply-To: <alpine.DEB.2.21.2105090548170.2587@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2105122255280.3032@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2105090548170.2587@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix an issue with VGA console font size changes made after the initial 
video text mode has been changed with a user tool like `svgatextmode' 
calling the VT_RESIZEX ioctl.  As it stands in that case the original 
screen geometry continues being used to validate further VT resizing.

Consequently when the video adapter is firstly reprogrammed from the 
original say 80x25 text mode using a 9x16 character cell (720x400 pixel 
resolution) to say 80x37 text mode and the same character cell (720x592 
pixel resolution), and secondly the CRTC character cell updated to 9x8 
(by loading a suitable font with the KD_FONT_OP_SET request of the 
KDFONTOP ioctl), the VT geometry does not get further updated from 80x37 
and only upper half of the screen is used for the VT, with the lower 
half showing rubbish corresponding to whatever happens to be there in 
the video memory that maps to that part of the screen.  Of course the 
proportions change according to text mode geometries and font sizes 
chosen.

Address the problem then, by updating the text mode geometry defaults 
rather than checking against them whenever the VT is resized via a user 
ioctl.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Fixes: e400b6ec4ede ("vt/vgacon: Check if screen resize request comes from userspace")
Cc: stable@vger.kernel.org # v2.6.24+
---
 drivers/video/console/vgacon.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

Index: linux-macro-ide/drivers/video/console/vgacon.c
===================================================================
--- linux-macro-ide.orig/drivers/video/console/vgacon.c
+++ linux-macro-ide/drivers/video/console/vgacon.c
@@ -1089,12 +1089,20 @@ static int vgacon_resize(struct vc_data
 	if ((width << 1) * height > vga_vram_size)
 		return -EINVAL;
 
+	if (user) {
+		/*
+		 * Ho ho!  Someone (svgatextmode, eh?) may have reprogrammed
+		 * the video mode!  Set the new defaults then and go away.
+		 */
+		screen_info.orig_video_cols = width;
+		screen_info.orig_video_lines = height;
+		vga_default_font_height = c->vc_font.height;
+		return 0;
+	}
 	if (width % 2 || width > screen_info.orig_video_cols ||
 	    height > (screen_info.orig_video_lines * vga_default_font_height)/
 	    c->vc_font.height)
-		/* let svgatextmode tinker with video timings and
-		   return success */
-		return (user) ? 0 : -EINVAL;
+		return -EINVAL;
 
 	if (con_is_visible(c) && !vga_is_gfx) /* who knows */
 		vgacon_doresize(c, width, height);
