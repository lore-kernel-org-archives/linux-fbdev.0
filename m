From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: fbdev broken in current bk for PPC
Date: Sat, 11 Sep 2004 09:19:54 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0409110918001.17924@waterleaf.sonytel.be>
References: <1094783022.2667.106.camel@gaston> <200409101328.57431.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C62BA-0007c1-7o
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 11 Sep 2004 00:20:12 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C62B7-0000FV-7N
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 11 Sep 2004 00:20:12 -0700
In-Reply-To: <200409101328.57431.adaplas@hotpop.com>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

On Fri, 10 Sep 2004, Antonino A. Daplas wrote:
> On Friday 10 September 2004 10:23, Benjamin Herrenschmidt wrote:
> > Recent changes upstream are breaking fbdev on pmacs.
> >
> > I haven't had time to go deep into that (but I suspect Linus sees it
> > too on his own g5 unless he removed offb from his .config).
> >
> > From what I see, it seems that offb is kicking in by default, reserves
> > the mmio regions, and then whatever chip driver loads can't access them.
> >
> > offb is supposed to be a "fallback" driver in case no fbdev is taking
> > over, it should also be "forced" in with video=ofonly kernel command
> > line. This logic has been broken.
>
> Actually, I was thinking about this problem with offb.  I was planning on
> adding video=offb:off support for offb, and then place offb at the very top
> drivers Makefile (the reason why I placed it there, but forgot to add the
> setup support for offb).  So, without the 'off' option, offb becomes the
> first driver that gets initialized by reason that it's at the top, and with
> the 'off' option, it just exits initialization immediately, giving the other
> drivers a chance to get through.

This is not suitable, since for dual-headed machines, you may want to have one
card driven by its native driver, and the other by offb (as fallback, because
no driver exists yet).

> The second method is not harder but will involve, again, changes to all
> drivers.  The only sane method I can think of is to change fb_get_options so
> it returns an error if:
>
> a. "off" option is enabled
> b. "ofonly" is enabled but only if name != "offb"
>
> If fb_get_options returns an error, drivers will not proceed with their
> initialization. The second method is more compatible with the
> previous setup semantics.

Yes, looks better (except that it's less clean, but I'm afraid we can't fix
that easily).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
