From: henne.ii@arcor.de
Subject: SED1335 embedded LCD
Date: Fri, 14 Feb 2003 20:57:07 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <2904013.1045252627630.JavaMail.ngmail@mx10.arcor-online.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mx03.nexgo.de ([151.189.8.98])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18jlxO-0004S3-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 14 Feb 2003 11:57:11 -0800
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>

Hello!

Virtual Framebuffer for monochrome embedded LCD with Epson controller SED1335 (S1D13305) are available.

ftp://ssv-embedded.de/ssv/products/trm916/sample/x86/linux/fbdev/

Routines using monochrome RAM of CPU or Pseudocolor RAM and update this to LCD hardware in timer interval.
This is a special embedded application. But all other users can use this skelet for other LC displays without memory mapped video ram. Such a graphic LCD on LPT port.

In this case, I hope you will not delete the monochrome LOGO in your new logo code!

Henry

Gruss
Henne.II@BigFoot.com----------------------------------------------------------------------------
Schlagen Sie sofort zu - mit Arcor und eBay
Viele Artikel zum Sofort Kaufen!
http://www.arcor.de/auk/ebay_sk.php
-----------------------------------------------------------------------



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
