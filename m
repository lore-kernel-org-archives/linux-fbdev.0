From: Jakub Bogusz <qboosh@pld-linux.org>
Subject: 2.6.7 fbcon: set_con2fb on current console = crash
Date: Fri, 18 Jun 2004 23:50:47 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040618215047.GA4723@satan.blackhosts>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbRFP-0002KT-8q
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 14:50:07 -0700
Received: from cnh51.neoplus.adsl.tpnet.pl ([83.31.161.51] helo=satan.blackhosts)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BbRFO-0001mP-HZ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 14:50:06 -0700
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Cc: pld-kernel@pld-linux.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

After upgrade from 2.6.4 to 2.6.7 I noticed that calling set_con2fb
(through FBIOPUT_CON2FBMAP ioctl) on current console (already attached
to fb using this ioctl) causes crash (oops and then recursive oops when
trying to printk on console) and makes console unusable.

That's because take_over_console() calls fbcon_deinit(vc_num)
(which calls fbcon_free_font() on that console display) and then
fbcon_init(vc_num, ...), which copies font data from current fb console.
If current console was just deinit()ed, its fontdata is NULL - and this
pointer is "copied" to the same place, leaving current console with
fontdata==NULL (which leads to oops on nearest putc/putcs).

Attached patch restores 2.6.4 behaviour on set_con2fb (to set font if
it's not set already) - but it's not perfect solution as user font is
still lost (unline on 2.4.x kernels).
Any idea how to preserve user font on set_con2fb() called on current
console?


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-fbcon-con2fb-crash-workaround.patch"

--- linux-2.6.7/drivers/video/console/fbcon.c.orig	2004-06-16 18:24:04.000000000 +0200
+++ linux-2.6.7/drivers/video/console/fbcon.c	2004-06-18 23:12:35.000000000 +0200
@@ -617,6 +617,15 @@
 	if (p->userfont) {
 		REFCOUNT(p->fontdata)++;
 		charcnt = FNTCHARCNT(p->fontdata);
+	} else if(!p->fontdata) {
+		struct font_desc *font = NULL;
+		if (!fontname[0] || !(font = find_font(fontname)))
+			font = get_default_font(info->var.xres,
+						   info->var.yres);
+		vc->vc_font.width = font->width;
+		vc->vc_font.height = font->height;
+		vc->vc_font.data = p->fontdata = font->data;
+		vc->vc_font.charcount = 256; /* FIXME  Need to support more fonts */
 	}
 	con_copy_unimap(vc->vc_num, display_fg);
 

--PNTmBPCT7hxwcZjr--


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
