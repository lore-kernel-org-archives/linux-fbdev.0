From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH 1/5]: logo fix
Date: Sun, 16 Feb 2003 16:39:34 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302161638110.10755-100000@phoenix.infradead.org>
References: <1045375680.1823.71.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18kRpq-0005tY-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 16 Feb 2003 08:40:11 -0800
In-Reply-To: <1045375680.1823.71.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Applied.

> The attached patch (linux-2.5.61 + James' fbdev.diff) fixes the following:
> 
> 1. compile error because of missing scripts/pmntologo.  

Hm. I thought there was only a c file that generated a binary to. That 
shouldn't be missing. It might be a BK sync issue on my part. 

> 2. Break up of fb_show_logo() to fb_prepare_logo()/fb_show_logo() to fix
> weird "double drawing" or the "single draw, erase in a flash" of the
> logo.
> 
> 3. Fixed all drivers affected by the (image.depth == 0) is color
> expansion.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
