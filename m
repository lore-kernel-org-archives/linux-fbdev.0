From: James Simmons <jsimmons@infradead.org>
Subject: Re: Framebuffer fixes.
Date: Fri, 28 Mar 2003 04:48:51 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303280443170.11648-100000@phoenix.infradead.org>
References: <1048798158.1035.13.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18ylo3-0007tU-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Mar 2003 20:49:31 -0800
In-Reply-To: <1048798158.1035.13.camel@localhost.localdomain>
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > > > Shouldn't these be info->var.bits_per_pixel instead of fb_logo.depth?
> > > 
> > > Yes, fb_logo.depth == info->var.bits_per_pixel.
> > 
> > Euh, now I get confused... Do you mean
> > `Yes, it should be replaced by info->var.bits_per_pixel' or
> > `No, logo.depth is always equal to info->var.bits_per_pixel'?
> 
> :)  Sorry about that. I meant:
> 
> 
> `No, fb_logo.depth is always equal to info->var.bits_per_pixel'

No this is no longer true. For example last night I displayed the 16 color 
logo perfectly fine on a 16 bpp display!!!! The mono display still has 
bugs tho. The new logo tries to pick the best image to display. Say for 
example we have two video cards. One running VESA fbdev at 16 bpp and a 
another at vga 4 planar via vga16fb. This way we can have the both the 16 
color and 224 color logo compiled in.  The correct logo will be displayed 
then on the correct display. Now say we only have a mono display but all 
the cards support 8 bpp or better. That logo still gets displayed.



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
