From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: New radeonfb, mostly untested
Date: Thu, 11 Sep 2003 09:05:05 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1063263904.2023.27.camel@gaston>
References: <Pine.GSO.4.21.0309110854490.1879-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xLWe-0000wo-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 11 Sep 2003 00:05:56 -0700
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 19xLWd-0003AO-5Q
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 Sep 2003 00:05:56 -0700
In-Reply-To: <Pine.GSO.4.21.0309110854490.1879-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kronos <kronos@kronoz.cjb.net>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Because the modedb itself is __init. Once you have modules, you have userspace
> and fbset, too.

But the modedb I'm building from EDID isn't __init ;)

Ben.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
