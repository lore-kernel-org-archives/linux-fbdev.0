From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: [PATCH]: image.depth fix to accomodate
 monochrome cards
Date: Thu, 13 Feb 2003 10:27:13 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0302131023170.14689-100000@vervain.sonytel.be>
References: <1045092922.5830.136.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from panoramix.vasoftware.com ([198.186.202.147] ident=mail)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18jFkW-000562-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 13 Feb 2003 01:33:44 -0800
Received: from mail2.sonytel.be ([195.0.45.172]:44759 helo=mail.sonytel.be)
	by panoramix.vasoftware.com with esmtp (Exim 4.05-VA-mm1 #1 (Debian))
	id 18jFjb-0001Rx-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 13 Feb 2003 01:32:48 -0800
In-Reply-To: <1045092922.5830.136.camel@localhost.localdomain>
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
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On 13 Feb 2003, Antonino Daplas wrote:
> On Thu, 2003-02-13 at 04:50, James Simmons wrote:
> > > > 1.  Changed meaning of image.depth.  If image.depth == 0, it flags for
> > > > color expansion, otherwise, it flags for image drawing (without color
> > > > expansion).  This change is to accomodate monochrome cards so they can
> > > > differentiate character drawing from logo drawing.
> > > 
> > > What's the status of this issue? Monochrome is still broken due to this.
> 
> How about assigning fb_image.{bg_color,fg_color} to -1 if not color
> expanding?  Since the pseudo_palette will not exceed 255, this should be
> safe.

Unless we ever want to support colors > 256 (or real pixel values)?

Alternatively, we can split imageblit in two routines, one for image drawing,
and one for color expansion.

So we now have 3 options:
  1. image.depth = 0 means color expansion,
  2. fb_image.{bg_color,fg_color} = -1 means color expansion,
  3. separate functions for image drawing and color expansion.

I still favor solution 1, since image.depth = 0 is not possible for images,
while fb_image.{bg_color,fg_color} = -1 (= 0xffffffff) may become valid in the
future, and the last one is more work to adapt the current drivers.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
