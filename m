From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Sane behavior of fbset
Date: Wed, 23 Jun 2004 21:17:09 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0406232116390.21847@waterleaf.sonytel.be>
References: <200406180945.12444.adaplas@hotpop.com>
 <Pine.GSO.4.58.0406181024180.11779@waterleaf.sonytel.be>
 <Pine.LNX.4.56.0406231945150.27210@pentafluge.infradead.org>
 <Pine.GSO.4.58.0406232057230.21847@waterleaf.sonytel.be>
 <Pine.LNX.4.56.0406232001200.27210@pentafluge.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdDFA-0007Bo-Fx
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 12:17:12 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BdDF9-0000QR-Q8
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 12:17:11 -0700
In-Reply-To: <Pine.LNX.4.56.0406232001200.27210@pentafluge.infradead.org>
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
To: jsimmons@pentafluge.infradead.org
Cc: Antonino Daplas <adaplas@pol.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 23 Jun 2004 jsimmons@pentafluge.infradead.org wrote:
> > > I have no problem adding in a notifier for fbset. I don't agree with
> > > adding in per VC vars. The reason is that every VC, all 64, will have a
> > > copy of struct fb_var_screeninfo. That is really heavy for embedded
> > > devices. Instead with a modedb we have one copy of different kinds of
> > > modes. What we need to do is add valid modes that are not present in
> > > modedb.
> >
> > If size matters, embedded devices can always disable virtual consoles
> > completely, so only one var is needed.
> >
> > Furthermore, what about making the maximum number of virtual consoles
> > configurable, and/or handling them dynamically (most systems have only a few of
> > them in active use)?
>
> That is a 2.7.X issue. Even still having 2 VCs meanings having two
> identical vars. That is heavy. Having that mode stored in modedb is one
> copy for both VCs.

And how much space does modedb (which used to be __initdata) need?

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
