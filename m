From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: [RFC] Video Mode Handling
Date: Mon, 9 Aug 2004 10:08:57 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0408091006580.14159@waterleaf.sonytel.be>
References: <200408090944.01414.adaplas@hotpop.com> <20040808230412.6dc16bf4.akpm@osdl.org>
 <200408091559.45202.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bu5DJ-0001bQ-JN
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 09 Aug 2004 01:09:01 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bu5DJ-0006g2-0N
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 09 Aug 2004 01:09:01 -0700
In-Reply-To: <200408091559.45202.adaplas@hotpop.com>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Andrew Morton <akpm@osdl.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 9 Aug 2004, Antonino A. Daplas wrote:
> On Monday 09 August 2004 14:04, Andrew Morton wrote:
> > "Antonino A. Daplas" <adaplas@hotpop.com> wrote:
> > > Most fbdev developers are proposing to bring back the per-display var
> > >  structures to ease the difficulty of video mode handling.  This proposal
> > >  is countered by a few (notably James) in that it severely increases the
> > >  memory footprint of the kernel.
> >
> > Surprised.
> >
> > By how much does this increase the kernel's memory footprint?
>
> Each var is approx 140 bytes multiplied by the number of consoles, which
> is 64. James is in the embedded systems market, so I can see his point.

IMHO embedded is much better off with configuring MAX_NR_CONSOLES to a smaller
value, or disabling virtual consoles completely.

Even on desktop systems, most people don't need more than 8 VCs.

> BTW:  The series of patches addresses all of the above.  It can save the
> settings per display, but with only half the memory requirement of a per-display

But it doesn't save the full var, which may cause subtle differences.

BTW, if size matters, you can save the full var without the reserved fields.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
