From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC] Does fbdev need a cursor API for
 userland?
Date: Mon, 18 Oct 2004 14:01:55 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.61.0410181359040.23486@waterleaf.sonytel.be>
References: <200410172347.15516.adaplas@hotpop.com> <200410181447.44492.adaplas@hotpop.com>
 <Pine.GSO.4.61.0410181133300.23486@waterleaf.sonytel.be>
 <200410181905.56602.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJWDH-0007Kp-Ka
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 18 Oct 2004 05:02:07 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CJWDF-0007ER-T0
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 18 Oct 2004 05:02:07 -0700
In-Reply-To: <200410181905.56602.adaplas@hotpop.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Jon Smirl <jonsmirl@gmail.com>

On Mon, 18 Oct 2004, Antonino A. Daplas wrote:
> On Monday 18 October 2004 17:35, Geert Uytterhoeven wrote:
> > On Mon, 18 Oct 2004, Antonino A. Daplas wrote:
> > > The restore_fb_contents/save_fb_contents cannot be done generically.  Not
> > > all framebuffers have a linear format, there are some that are planar
> > > such as amifb and vga16fb.  This means that we need to add per-driver
> > > hooks just to save and restore the framebuffer contents.
> >
> > Can't we use fb_imageblit() for restore? 
> 
> fb_imageblit() is limited because it uses the pseudo_palette.  Even if
> we expand the palette to 256 entries, it won't be able to handle formats >
> 8bpp. More than 256 is not practical. Plus, fb_imageblit is limited to
> 1->bpp, and 8->bpp expansion.

What about expanding fb_imageblit() to handle 32-bit ARGB as well? Then it can
handle most canonical formats (1 bpp monochrome, 8-bit CLUT, 32-bit
ARGB). We still would have problems with e.g. 10-bit CLUT.

> > Then al we need to add is a get_image() routine.
> 
> I guess if we can add get_image(), it's simple enough to write a
> corresponding set_image().  Your amifb is one driver that's going to
> be affected, so if you say 'yes' to the above, then let's go for a 
> universal cursor implementation.

For me having to add a planar get_image() to amifb is OK.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
