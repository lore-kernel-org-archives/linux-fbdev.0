From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: [PATCH] 2.5.24 matroxfb off by one error
Date: Sun, 30 Jun 2002 02:34:10 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <aflesb$ebk$2@main.gmane.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from p015.as-l031.contactel.cz ([212.65.234.207] helo=ppc.vc.cvut.cz)
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17ORN4-0001Zb-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 29 Jun 2002 16:11:15 -0700
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Hi Linus,
   please apply patch below.

   It fixes off by one error in getcolreg/setcolreg in matroxfb's 
secondary head driver.
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz


diff -urdN linux/drivers/video/matrox/matroxfb_crtc2.c linux/drivers/video/matrox/matroxfb_crtc2.c
--- linux/drivers/video/matrox/matroxfb_crtc2.c	Fri Jun 21 00:53:48 2002
+++ linux/drivers/video/matrox/matroxfb_crtc2.c	Sat Jun 29 00:09:09 2002
@@ -29,7 +29,7 @@
 static int matroxfb_dh_getcolreg(unsigned regno, unsigned *red, unsigned *green,
 		unsigned *blue, unsigned *transp, struct fb_info* info) {
 #define m2info ((struct matroxfb_dh_fb_info*)info)
-	if (regno > 16)
+	if (regno >= 16)
 		return 1;
 	*red = m2info->palette[regno].red;
 	*blue = m2info->palette[regno].blue;
@@ -44,7 +44,7 @@
 #define m2info ((struct matroxfb_dh_fb_info*)info)
 	struct display* p;
 
-	if (regno > 16)
+	if (regno >= 16)
 		return 1;
 	m2info->palette[regno].red = red;
 	m2info->palette[regno].blue = blue;


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
No, I will not fix your computer.
http://thinkgeek.com/sf
