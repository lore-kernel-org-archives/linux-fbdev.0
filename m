From: henryn@arcor.de
Subject: How create monochrome Palette with 8bpp
Date: Fri, 21 Feb 2003 12:31:02 +0100 (CET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1132297.1045827063117.JavaMail.ngmail@webmail02.arcor-online.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mx02.nexgo.de ([151.189.8.97])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18mBOV-0008NC-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 21 Feb 2003 03:31:07 -0800
Received: from webmail02.arcor-online.net (webmail02.arcor-online.net [151.189.8.80])
	by mx02.nexgo.de (Postfix) with ESMTP id 1E3459F6B7
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 21 Feb 2003 12:31:03 +0100 (CET)
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

Hello all!

We design new framebuffers for monochrome LCD 1bpp and 8bpp, based on skeletonfb.c and vfb.c All works in text-console.

If we start Xfbdev from Kdrive we have only a cleared black screen.

How we shold handled palette registers for a real black and white LC Display?

It's very ugly to understand functions ...encode_fix, ...decode_var, ...encode_var, ...get_par and  ...set_par. How can we find more detail info about this functions?

ftp://ssv-embedded.de/ssv/products/trm916/sample/x86/linux/fbdev/linux-2.4.20-fb916-20.patch.gz

Thanks Henry


----------------------------------------------------------------------------
Schlagen Sie sofort zu - mit Arcor und eBay
Viele Artikel zum Sofort Kaufen!
http://www.arcor.de/auk/ebay_sk.php
-----------------------------------------------------------------------



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
