From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: [PATCH 1/1: 2.6.15] fbcon: =?ISO-8859-1?Q?don=B4t_call_set=5F?=
 =?ISO-8859-1?Q?par=28=29_in_fbcon=5Finit=28=29_if_vc=5Fmode_=3D?=
 =?ISO-8859-1?Q?=3D_KD=5FGRAPHICS?=
Date: Sat, 07 Jan 2006 10:22:04 +0100
Message-ID: <43BF883C.5030708@t-online.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030376AbWAGJVL@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, "Antonino A. Daplas" <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Nothing prevents a user to modprobe a framebuffer driver from
e.g. the xterm prompt. As a result, the set_par() function of the driver
will be called from fbcon_init().

This is fatal as a lot of X / framebuffer combinations are unable
to recover from set_par() reprogramming the graphics controller in
KD_GRAPHICS mode.

It is also unnecessary as the set_par() function will be called during
a switch to KD_TEXT anyway. Because of this no side effects are
possible.

Signed-off-by: Knut Petersen <Knut_Petersen@t-online.de>

diff -uprN -X linux/Documentation/dontdiff -x '*.bak' -x '*.ctx' 
linuxorig/drivers/video/console/fbcon.c linux/drivers/video/console/fbcon.c

--- linuxorig/drivers/video/console/fbcon.c	2006-01-07 09:18:25.000000000 +0100
+++ linux/drivers/video/console/fbcon.c	2006-01-07 07:31:08.000000000 +0100
@@ -1110,7 +1110,7 @@ static void fbcon_init(struct vc_data *v
 	 *
 	 * We need to do it in fbcon_init() to prevent screen corruption.
 	 */
-	if (CON_IS_VISIBLE(vc)) {
+	if (CON_IS_VISIBLE(vc) && vc->vc_mode == KD_TEXT) {
 		if (info->fbops->fb_set_par &&
 		    !(ops->flags & FBCON_FLAGS_INIT))
 			info->fbops->fb_set_par(info);
