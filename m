From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Patch 2] Console Rotation
Date: Sun, 6 Oct 2002 22:41:57 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0210062238180.923-100000@vervain.sonytel.be>
References: <1031583916.736.30.camel@daplas>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17yIEJ-00005c-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 06 Oct 2002 13:42:23 -0700
In-Reply-To: <1031583916.736.30.camel@daplas>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On 9 Sep 2002, Antonino Daplas wrote:
> On Mon, 2002-09-09 at 22:35, Geert Uytterhoeven wrote:
> > On 9 Sep 2002, Antonino Daplas wrote:
> > > cfbcopyarea.c is just a 'copy 'n paste' of Geert's version I leached
> > > from fbutils (I hope this is okay with you, Geert :)  The only changes
> > > are using FB_WRITEL and FB_READL where appropriate. 
> > 
> > Of course (actually that was my intention ;-)
> Thanks.
> 
> > 
> > Did you measure any noticeable differences (performance-wise) with the old
> > routines?
> > 
> Yes, but not by much, something like less than a second.  But I haven't
> really done a test where the primary operation is copyarea...  Will this
> be affected by the the setting of display->scrollmode?  I use
> SCROLL_YREDRAW.
> 
> > BTW, expect a fillrect() for arbitrary bitdepths soon...
> This is good :)  The one I included should do that too, but it is
> terribly inefficient.  

The fillrect() for arbitrary bitdepths is in fbtest now. I also added fast
support for planar screens. Well, now I can start porting amifb to the accel
framework.

So far I tested fbtest on
  - PPC (atyfb on 3D RAGE II+, cfb)
  - m68k (amifb on Amiga AGA, planar)
  - Alpha (tgafb on DEC UDB with 8-bit TGA, cfb)

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
