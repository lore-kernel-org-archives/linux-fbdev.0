From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC] Does fbdev need a cursor API for
 userland?
Date: Tue, 19 Oct 2004 10:01:51 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.61.0410190958340.13789@waterleaf.sonytel.be>
References: <200410172347.15516.adaplas@hotpop.com> <200410190456.32643.adaplas@hotpop.com>
 <Pine.GSO.4.61.0410182257220.2414@waterleaf.sonytel.be>
 <200410190534.26894.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJowO-0006uR-Rh
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 19 Oct 2004 01:01:56 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CJowN-0002eN-6r
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 19 Oct 2004 01:01:56 -0700
In-Reply-To: <200410190534.26894.adaplas@hotpop.com>
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
> On Tuesday 19 October 2004 05:00, Geert Uytterhoeven wrote:
> > On Tue, 19 Oct 2004, Antonino A. Daplas wrote:
> > > On Monday 18 October 2004 20:01, Geert Uytterhoeven wrote:
> > > > On Mon, 18 Oct 2004, Antonino A. Daplas wrote:
> > > > > On Monday 18 October 2004 17:35, Geert Uytterhoeven wrote:
> > > > > > On Mon, 18 Oct 2004, Antonino A. Daplas wrote:
> >
> > I didn't intend it to do conversions. 32-bit ARGB would be used for
> > truecolor visuals only.
> >
> > > Isn't it much simpler to just have a set_image() where the source block
> > > is in the same format as the framebuffer so it doesn't have to do format
> > > conversions?
> >
> > Yes it is.
> >
> > The fb_imageblit() approach is just more generic, and could (in theory) be
> > used from user space as well, allowing applications to not have to care
> > about the actual frame buffer format anymore. All they have to handle is
> > 1-bit monochrome, 8-bit pseudocolor and 32-bit ARGB truecolor.
> >
> 
> We still have to do conversions, say from 32-bit ARGB to RGB565.  And this
> is just for truecolor.

Indeed.

> How about directcolor?

You're right. And currently directcolor is treated like pseudocolor w.r.t. the
console and the penguin logo.

Hmm, bad idea, at least for saving/restore for the cursor.

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
