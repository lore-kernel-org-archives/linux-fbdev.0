From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC] Does fbdev need a cursor API for
 userland?
Date: Mon, 18 Oct 2004 23:00:46 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.61.0410182257220.2414@waterleaf.sonytel.be>
References: <200410172347.15516.adaplas@hotpop.com> <200410181905.56602.adaplas@hotpop.com>
 <Pine.GSO.4.61.0410181359040.23486@waterleaf.sonytel.be>
 <200410190456.32643.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJecd-0008Oe-RW
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 18 Oct 2004 14:00:51 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CJecd-0001hD-3g
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 18 Oct 2004 14:00:51 -0700
In-Reply-To: <200410190456.32643.adaplas@hotpop.com>
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

On Tue, 19 Oct 2004, Antonino A. Daplas wrote:
> On Monday 18 October 2004 20:01, Geert Uytterhoeven wrote:
> > On Mon, 18 Oct 2004, Antonino A. Daplas wrote:
> > > On Monday 18 October 2004 17:35, Geert Uytterhoeven wrote:
> > > > On Mon, 18 Oct 2004, Antonino A. Daplas wrote:
> > > > > The restore_fb_contents/save_fb_contents cannot be done generically. 
> > > > > Not all framebuffers have a linear format, there are some that are
> > > > > planar such as amifb and vga16fb.  This means that we need to add
> > > > > per-driver hooks just to save and restore the framebuffer contents.
> > > >
> > > > Can't we use fb_imageblit() for restore?
> > >
> > > fb_imageblit() is limited because it uses the pseudo_palette.  Even if
> > > we expand the palette to 256 entries, it won't be able to handle formats
> > > > 8bpp. More than 256 is not practical. Plus, fb_imageblit is limited to
> > > 1->bpp, and 8->bpp expansion.
> >
> > What about expanding fb_imageblit() to handle 32-bit ARGB as well? Then it
> > can handle most canonical formats (1 bpp monochrome, 8-bit CLUT, 32-bit
> 
> Meaning, fb_imageblit needs to do 32-bit ARGB to native fb format conversion
> on the fly.  How can we do that generically without fb_imageblit knowing the
> format of the framebuffer? For example, how do we convert 32-bit ARGB to

Remember, fb_imageblit() is just a function pointer set up by the fbdev. In
most cases it's just cfb, though.

> 8-bit Pseudocolor?

I didn't intend it to do conversions. 32-bit ARGB would be used for truecolor
visuals only.

> Isn't it much simpler to just have a set_image() where the source block is
> in the same format as the framebuffer so it doesn't have to do format
> conversions?

Yes it is.

The fb_imageblit() approach is just more generic, and could (in theory) be used
from user space as well, allowing applications to not have to care about the
actual frame buffer format anymore. All they have to handle is 1-bit
monochrome, 8-bit pseudocolor and 32-bit ARGB truecolor.

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
