From: Hanno =?ISO-8859-15?Q?B=F6ck?= <hanno@gmx.de>
Subject: Situation on radeonfb
Date: Wed, 19 Feb 2003 13:00:26 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030219130026.4770b401.hanno@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from imap.gmx.net ([213.165.65.60] helo=mail.gmx.net)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18lStm-0004qw-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 19 Feb 2003 04:00:26 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net

Hi,

I own a Sony Vaio with a Radeon Mobility M6 LY.

The Situation with radeonfb at the moment is not very good for me.
1. I need a fix that has been around for ages, but not added to the main
kernel (see patch below).
2. There seem to be two updates for the radeonfb in kernel 2.4 floating
arount. One from Ani Joshi which was part of the ac-kernel, but has
recently been dropped. So it's not likely that it will become part of
the main kernel. This Update works for me.
Another one from the mplayer-team, which doesn't work for me at all,
even if I add the fix below.

By the way, the 2.5-version of the radeonfb also doesn't work at all for
me, even if I add the fix below and change the constant-names to the
ones used in 2.5.

I would really like to have a working radeonfb. Is there currently any
work done on this? Can we at least send the fix below to marcello and
ask him to integrate this soon?



--- radeonfb.c.orig	Thu May  9 16:51:26 2002
+++ radeonfb.c	Thu May  9 16:48:46 2002
@@ -877,6 +877,14 @@
 	/* mem size is bits [28:0], mask off the rest */
 	rinfo->video_ram = tmp & CONFIG_MEMSIZE_MASK;
 
+	/* According to XFree86 4.2.0, some production M6's return 0
+	   for 8MB. */
+	if (rinfo->video_ram == 0 && 
+	    (pdev->device == PCI_DEVICE_ID_RADEON_LY || 
+	     pdev->device == PCI_DEVICE_ID_RADEON_LZ)) {
+	    rinfo->video_ram = 8192 * 1024;
+	  }
+
 	/* ram type */
 	tmp = INREG(MEM_SDRAM_MODE_REG);
 	switch ((MEM_CFG_TYPE & tmp) >> 30) {


-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
