From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] neo_free_fb_info shouldn't be __devinit
Date: Sat, 6 Sep 2003 23:27:51 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030906212751.GA15693@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19vkbU-0000D5-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 06 Sep 2003 14:28:20 -0700
Received: from mail-1.tiscali.it ([195.130.225.147])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19vkbT-0008LA-Et
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 06 Sep 2003 14:28:19 -0700
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: Denis Oliver Kropp <dok@directfb.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi,
in  drivers/video/neofb.c the  function  neo_free_fb_info  is marked  as
__devinit. However it is used  also by neofb_remove (during unload). The
following patch removes __devinit:

--- linux-2.6.a/drivers/video/neofb.c	Tue Aug 12 17:02:31 2003
+++ linux-2.6.b/drivers/video/neofb.c	Sat Sep  6 23:23:09 2003
@@ -1949,7 +1949,7 @@
 	return info;
 }
 
-static void __devinit neo_free_fb_info(struct fb_info *info)
+static void neo_free_fb_info(struct fb_info *info)
 {
 	if (info) {
 		/*


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"Chi parla in tono cortese, ma continua a prepararsi, potra` andare avanti;
 chi parla in tono bellicoso e avanza rapidamente dovra` ritirarsi" 
Sun Tzu -- L'arte della guerra


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
