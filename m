From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: [PATCH 1/1 2.6.15-rc4-git1] Fix switching to KD_TEXT
Date: Thu, 08 Dec 2005 23:49:44 +0100
Message-ID: <4398B888.50005@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EkVMc-0001Jt-Cx
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Dec 2005 15:39:50 -0800
Received: from mailout02.sul.t-online.com ([194.25.134.17])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EkVMa-0007OG-VO
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Dec 2005 15:39:50 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, "Antonino A. Daplas" <adaplas@gmail.com>

  Every framebuffer driver relies on the assumption that the set_par() 
function
of the driver is called before drawing functions and other functions 
dependent
on the hardware state are executed.

This assumption is false in two cases, and one is a genuine linux
bug:

    1: Whenever you switch from X to a framebuffer console for the very
        first time, there is a chance that a broken X system has _not_ set
        the mode to KD_GRAPHICS, thus the vt and framebuffer code
        executes a screen redraw and several other functions before a
        set_par() is executed. This is believed to be not a bug of linux
        but a bug of X/xdm.

    2: Whenever a switch from X to a framebuffer console occures,
         the pan_display() function of the driver is called once before
         the set_par() function of the driver is called. Code path:
         complete_change_console -> redraw_screen -> fbcon_switch ->
         bit_update_start-> fb_pan_display -> xyz_pan_display.
         This is clearly a bug of linux.

Although our primary goal must be to fix linux bugs and not to work
around bugs of X, the patch fixes both of the cases.

The advantage and correctness of this patch should be obvious. Yes, it
does add a possibly slow call to the fb_set_par() function, but at this
point it is necessary.

Signed-off-by: Knut Petersen <Knut_Petersen@t-online.de>


diff -uprN -X linux/Documentation/dontdiff -x '*.bak' -x '*.ctx' linuxorig/drivers/video/console/fbcon.c linux/drivers/video/console/fbcon.c
--- linuxorig/drivers/video/console/fbcon.c	2005-12-02 12:18:04.000000000 +0100
+++ linux/drivers/video/console/fbcon.c	2005-12-06 09:06:56.000000000 +0100
@@ -2103,10 +2103,11 @@ static int fbcon_switch(struct vc_data *
 	fb_set_var(info, &var);
 	ops->var = info->var;
 
-	if (old_info != NULL && old_info != info) {
-		if (info->fbops->fb_set_par)
-			info->fbops->fb_set_par(info);
+	if (old_info != NULL && old_info != info)
 		fbcon_del_cursor_timer(old_info);
+
+	if (info->fbops->fb_set_par) {
+		info->fbops->fb_set_par(info);
 		fbcon_add_cursor_timer(info);
 	}




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
