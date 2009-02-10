From: Risto Suominen <risto.suominen@gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH] fb: hide cursor in graphics mode
Date: Tue, 10 Feb 2009 23:37:01 +0200
Message-ID: <46e1c7760902101337qe239336n9ef2652a47f89aed@mail.gmail.com>
References: <46e1c7760901230433i3045f273oa109ce97e790bca3@mail.gmail.com>
	 <Pine.LNX.4.64.0901240951110.13803@anakin>
	 <46e1c7760901240109m5a0f3a85p788aa3ce35b49fa9@mail.gmail.com>
	 <Pine.LNX.4.64.0901241425310.13803@anakin>
	 <46e1c7760901240649v1e45bbb1v8c9997f236a3ec4c@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756732AbZBJVhW@vger.kernel.org>
In-Reply-To: <46e1c7760901240649v1e45bbb1v8c9997f236a3ec4c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>

Xserver Xfbdev (kdrive) uses linux framebuffer in graphics mode. It doesn't
need the text mode cursor, it's a bit annoying to have it there sitting in a
corner. This patch disables the cursor even when in graphics mode.

Signed-off-by: Risto Suominen <Risto.Suominen@gmail.com>
---
The testing is done on kernel version 2.6.18. This version should be
applyable on 2.6.28.4.

--- a/drivers/video/console/fbcon.c.org 2007-03-03 07:14:54.000000000 +0200
+++ b/drivers/video/console/fbcon.c     2009-01-23 12:42:14.000000000 +0200
@@ -1363,6 +1363,12 @@ static void fbcon_cursor(struct vc_data
        int y;
        int c = scr_readw((u16 *) vc->vc_pos);

+       if (mode == CM_ERASE && info->fbops->fb_cursor) {
+               /* Hide H/W-cursor unconditionally */
+               ops->cursor(vc, info, mode, 0, 0, 0);
+               return;
+       }
+
        if (fbcon_is_inactive(vc, info) || vc->vc_deccm != 1)
                return;
