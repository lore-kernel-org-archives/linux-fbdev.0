From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Sane behavior of fbset
Date: Wed, 23 Jun 2004 20:59:51 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0406232057230.21847@waterleaf.sonytel.be>
References: <200406180945.12444.adaplas@hotpop.com>
 <Pine.GSO.4.58.0406181024180.11779@waterleaf.sonytel.be>
 <Pine.LNX.4.56.0406231945150.27210@pentafluge.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdCyQ-0005Gn-Mf
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 11:59:54 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BdCyQ-0005On-22
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 11:59:54 -0700
In-Reply-To: <Pine.LNX.4.56.0406231945150.27210@pentafluge.infradead.org>
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
> > > 1.  Revert to 2.4 behavior.  This is easy to add since fbdev already has a notifier
> > > support. (I already have working code for this). Of course, stty will still work.

> > > Note: As mentioned by many people before, it's almost impossible to completely
> > > preserve per-console mode info because of the lack of a per-display var.  So even
> > > if we agree to implement #1,  it cannot completely match 2.4 behavior. Also, the lack
> > > of per-display var means that drivers must be able to handle mode changes without
> > > any help.  James' fb_find_mode support in fbcon_resize does partly alleviate this
> > > limitation.
> >
> > I vote for 1, and re-adding per-display vars.
>
> I have no problem adding in a notifier for fbset. I don't agree with
> adding in per VC vars. The reason is that every VC, all 64, will have a
> copy of struct fb_var_screeninfo. That is really heavy for embedded
> devices. Instead with a modedb we have one copy of different kinds of
> modes. What we need to do is add valid modes that are not present in
> modedb.

If size matters, embedded devices can always disable virtual consoles
completely, so only one var is needed.

Furthermore, what about making the maximum number of virtual consoles
configurable, and/or handling them dynamically (most systems have only a few of
them in active use)?

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
