From: "Stephen M. Kenton" <skenton@ou.edu>
Subject: imsttfb warnings in 2.6.0-test4
Date: Fri, 05 Sep 2003 23:15:00 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3F595F44.2A52A246@ou.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19vUU5-0006dl-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 05 Sep 2003 21:15:37 -0700
Received: from [129.15.0.75] (helo=c3p0.ou.edu)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19vUU4-0002yY-L7
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Sep 2003 21:15:36 -0700
Received: from e500-5.ou.edu (ip-129-15-0-76.zero.ou.edu [129.15.0.76])
 by c3p0.ou.edu (iPlanet Messaging Server 5.2 HotFix 1.16 (built May 14 2003))
 with SMTP id <0HKR00LZFYH5PQ@c3p0.ou.edu> for
 linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Sep 2003 23:15:05 -0500 (CDT)
Received: from ou.edu (ppp-ip-129-15-167-114.ACCESS.ou.edu [129.15.167.114])
 by c3p0.ou.edu (iPlanet Messaging Server 5.2 HotFix 1.16 (built May 14 2003))
 with ESMTP id <0HKR00LZ5YH3PQ@c3p0.ou.edu> for
 linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Sep 2003 23:15:05 -0500 (CDT)
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
To: lethal@chaoticdreams.org, linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org, geert@linux-m68k.org

Any reason that imsttfb_load_cursor_image and imstt_set_cursor
can not be under the same #if 0 as imsttfb_cursor which used to call them?
It gets rid of a couple of defined but not used warnings in 2.6.0-test4
For that matter, is the #if 0  being kept for a particular reason?

Untested patch below

smk

--- drivers/video/imsttfb.c.ori	2003-09-05 22:34:18.000000000 -0500
+++ drivers/video/imsttfb.c	2003-09-05 22:35:36.000000000 -0500
@@ -1084,6 +1084,7 @@
 	while(read_reg_le32(par->dc_regs, SSTATUS) & 0x40);
 }
 
+#if 0
 static int
 imsttfb_load_cursor_image(struct imstt_par *par, int width, int height, __u8 fgc)
 {
@@ -1191,7 +1192,6 @@
 	}
 }
 
-#if 0
 static int 
 imsttfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
