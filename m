From: James Simmons <jsimmons@phoenix.infradead.org>
Subject: Re: vga16fb broken in 2.5.31+BK
Date: Wed, 14 Aug 2002 16:08:47 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0208141608190.17925-100000@phoenix.infradead.org>
References: <Pine.GSO.4.43.0208141212100.4799-100000@romulus.cs.ut.ee>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.infradead.org ([195.224.96.167])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17ezlr-0001kG-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 14 Aug 2002 08:09:17 -0700
In-Reply-To: <Pine.GSO.4.43.0208141212100.4799-100000@romulus.cs.ut.ee>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Meelis Roos <mroos@linux.ee>
Cc: linux-fbdev-devel@lists.sourceforge.net


This is normal. The api is changing no several drivers are going to be 
broken.

On Wed, 14 Aug 2002, Meelis Roos wrote:

> vga16fb.c: In function `vga16fb_set_disp':
> vga16fb.c:177: structure has no member named `visual'
> vga16fb.c:178: structure has no member named `type'
> vga16fb.c:179: structure has no member named `type_aux'
> vga16fb.c:180: structure has no member named `ypanstep'
> vga16fb.c:181: structure has no member named `ywrapstep'
> vga16fb.c:182: structure has no member named `line_length'
> vga16fb.c: In function `vga_vesa_blank':
> vga16fb.c:664: warning: implicit declaration of function `cli'
> vga16fb.c:671: warning: implicit declaration of function `sti'
> vga16fb.c: In function `vga16fb_blank':
> vga16fb.c:796: warning: implicit declaration of function `do_install_cmap_R982b4616'
> vga16fb.c: At top level:
> vga16fb.c:814: unknown field `fb_get_fix' specified in initializer
> vga16fb.c:814: warning: initialization from incompatible pointer type
> vga16fb.c:815: unknown field `fb_get_var' specified in initializer
> vga16fb.c:815: warning: initialization from incompatible pointer type
> 
> 



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
