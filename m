From: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] update control video driver
Date: Mon, 24 Mar 2003 23:02:26 +1100 (EST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <15998.62418.678276.238530@nanango.paulus.ozlabs.org>
Reply-To: paulus@samba.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from dp.samba.org ([66.70.73.150] helo=lists.samba.org)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18xQm9-0004oB-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 24 Mar 2003 04:10:01 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

The patch below fixes the controlfb driver to access the
pseudo_palette as 32-bit quantities and takes out the font option
handling.

Paul.

diff -urN linux-2.5/drivers/video/controlfb.c linuxppc-2.5/drivers/video/controlfb.c
--- linux-2.5/drivers/video/controlfb.c	2003-03-23 16:29:31.000000000 +1100
+++ linuxppc-2.5/drivers/video/controlfb.c	2003-03-23 21:42:33.000000000 +1100
@@ -376,13 +376,12 @@
 		int i;
 		switch (p->par.cmode) {
 		case CMODE_16:
-			((u16 *) (info->pseudo_palette))[regno] =
+			p->pseudo_palette[regno] =
 			    (regno << 10) | (regno << 5) | regno;
 			break;
 		case CMODE_32:
 			i = (regno << 8) | regno;
-			((u32 *) (info->pseudo_palette))[regno] =
-			    (i << 16) | i;
+			p->pseudo_palette[regno] = (i << 16) | i;
 			break;
 		}
 	}
@@ -475,7 +474,6 @@
 		var.yres_virtual = vyres;
 
 	/* Apply default var */
-	p->info.var = var;
 	var.activate = FB_ACTIVATE_NOW;
 	rc = fb_set_var(&var, &p->info);
 	if (rc && (vmode != VMODE_640_480_60 || cmode != CMODE_8))
@@ -1068,17 +1066,7 @@
 		return;
 
 	while ((this_opt = strsep(&options, ",")) != NULL) {
-		if (!strncmp(this_opt, "font:", 5)) {
-			char *p;
-			int i;
-
-			p = this_opt +5;
-			for (i = 0; i < sizeof(fontname) - 1; i++)
-				if (!*p || *p == ' ' || *p == ',')
-					break;
-			memcpy(fontname, this_opt + 5, i);
-			fontname[i] = 0;
-		} else if (!strncmp(this_opt, "vmode:", 6)) {
+		if (!strncmp(this_opt, "vmode:", 6)) {
 			int vmode = simple_strtoul(this_opt+6, NULL, 0);
 			if (vmode > 0 && vmode <= VMODE_MAX &&
 			    control_mac_modes[vmode - 1].m[1] >= 0)


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
