From: Magnus Damm <damm@opensource.se>
Subject: [PATCH] aty128fb: fix module parameter descriptions
Date: Sat,  8 Jan 2005 18:34:01 +0100 (CET)
Message-ID: <20050108173242.14332.32460.26428@kubu>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CnKTb-0000vm-OQ
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 08 Jan 2005 09:34:11 -0800
Received: from ns3.dataphone.se ([212.37.0.170] helo=mail-slave.dataphone.se)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CnKTa-0002b8-1Y
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 08 Jan 2005 09:34:11 -0800
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Magnus Damm <damm@opensource.se>

This patch syncs up the module parameter descriptions in aty128fb for module 
parameters "mode_option" and "nomtrr". Without the patch bad parameter names 
are used with MODULE_PARM_DESC().

Signed-off-by: Magnus Damm <damm@opensource.se>

--- linux-2.6.10/drivers/video/aty/aty128fb.c	2004-12-24 22:34:45.000000000 +0100
+++ linux-2.6.10-aty128fb_module_parm_desc/drivers/video/aty/aty128fb.c	2005-01-08 18:11:50.000000000 +0100
@@ -2462,10 +2462,10 @@
 MODULE_DESCRIPTION("FBDev driver for ATI Rage128 / Pro cards");
 MODULE_LICENSE("GPL");
 module_param(mode_option, charp, 0);
-MODULE_PARM_DESC(mode, "Specify resolution as \"<xres>x<yres>[-<bpp>][@<refresh>]\" ");
+MODULE_PARM_DESC(mode_option, "Specify resolution as \"<xres>x<yres>[-<bpp>][@<refresh>]\" ");
 #ifdef CONFIG_MTRR
 module_param_named(nomtrr, mtrr, invbool, 0);
-MODULE_PARM_DESC(mtrr, "bool: Disable MTRR support (0 or 1=disabled) (default=0)");
+MODULE_PARM_DESC(nomtrr, "bool: Disable MTRR support (0 or 1=disabled) (default=0)");
 #endif
 #endif
 


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
