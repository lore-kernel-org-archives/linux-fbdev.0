From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Sane behavior of fbset
Date: Wed, 23 Jun 2004 18:08:27 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0406231808080.13111@waterleaf.sonytel.be>
References: <200406180945.12444.adaplas@hotpop.com> <200406190240.26228.adaplas@hotpop.com>
 <20040619031650.GC14319@havoc.gtf.org> <200406191413.28339.adaplas@hotpop.com>
 <1088006149.1832.145.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdAIr-0004uN-6O
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 09:08:49 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdAIq-0004bJ-LB
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 09:08:48 -0700
In-Reply-To: <1088006149.1832.145.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Antonino Daplas <adaplas@pol.net>, David Eger <eger@havoc.gtf.org>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 23 Jun 2004, Benjamin Herrenschmidt wrote:
> > The flow of fbset is upstream:  fbset->fbdev->fbcon->vc (2.4 code)
> > The flow of stty is downstream: stty->vc->fbcon->fbdev (2.6 code)
> >
> > I don't know how radeonfb does it though.
>
> I still think (didn't I repeat it often enough) that the whole idea
> of stty "inventing" modes based on console size is broken. We simply
> can't rely on good enough monitor detection & mode list building to
> be able to pick proper modes. Not only our code is far from ready for
> that, but it will also call all sort of problems to users (remember
> you monitors that need different subtle geometry settings for each
> different mode you use ?)
>
> It may have looked like a nice idea, but I think it's just wrong.
>
> fbset sends an ioctl straight to the fbdev, and doesn't update fbcon
> at the moment. The callback mecanism I added for power management
> should allow to restore 2.4 functionality there, but this has not
> been implemented yet afaik.

Oh yes, patches for that are starting to flow around!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
