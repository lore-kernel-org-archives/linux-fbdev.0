From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] fbset.c - fixes mode info (fwd)
Date: Mon, 20 Jan 2003 10:28:30 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301201028200.19033-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18aYF2-0003eb-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 20 Jan 2003 01:29:17 -0800
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id KAA07237
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 20 Jan 2003 10:28:30 +0100 (MET)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

---------- Forwarded message ----------
Date: 18 Jan 2003 16:10:12 +0100
From: Fredrik Noring <noring@nocrew.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: [PATCH] fbset.c - fixes mode info

Hi,

Please apply this fix to report proper negative sync polarity.

Thanks,

	Fredrik

--- fbset-2.1.old/fbset.c	1999-06-23 16:11:46.000000000 +0200
+++ fbset-2.1.new/fbset.c	2003-01-18 15:55:02.000000000 +0100
@@ -629,8 +629,12 @@
 	       vmode->hslen, vmode->vslen);
 	if (vmode->hsync)
 	    puts("    hsync high");
+	else
+	    puts("    hsync low");
 	if (vmode->vsync)
 	    puts("    vsync high");
+	else
+	    puts("    vsync low");
 	if (vmode->csync)
 	    puts("    csync high");
 	if (vmode->gsync)





-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
