From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Error in fbcon_switch ?
Date: Thu, 22 May 2008 22:57:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0805222246130.8919@anakin>
References: <20080520231121.a8fbecc1.krzysztof.h1@poczta.fm>
	<Pine.LNX.4.64.0805210915510.14927@anakin>
	<20080522184750.a3513914.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JzHrH-00010U-9S for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 May 2008 13:57:55 -0700
Received: from harold.telenet-ops.be ([195.130.133.65])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JzHrF-0005UB-Mr
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 May 2008 13:57:55 -0700
In-Reply-To: <20080522184750.a3513914.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 22 May 2008, Krzysztof Helt wrote:
> On Wed, 21 May 2008 09:17:45 +0200 (CEST)
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, 20 May 2008, Krzysztof Helt wrote:
> 
> > > I found that root of the problem is that fbcon_switch copies the var.vmode 
> > > field from the previous console. If this copy is removed everything is alright, ie.
> > > 
> > > tty1 (lace) -> tty2 (non-lace) -> tty1 (lace) -> tty2 (non-lace)

I could easily reproduce it on my Amiga. Haven't tried on the PS3 yet.

Seems to be introduced by

commit e4fc27618b75234b721c4a13d0e0d9d07e75e641
Author: Antonino A. Daplas <adaplas@gmail.com>
Date:   Tue Nov 8 21:39:09 2005 -0800

    [PATCH] fbcon: Console Rotation - Prepare fbcon for console rotation

Strange I never noticed it before... Oh well, interlace doesn't seem to
be popular anymore.

> > > Is this a correct solution to the problem? What is a purpose of copying vmode field?
> > > 
> (...)
> > > IMO, at least the first three should not be copied. I am not sure about YWRAP and 
> > > CONUPDATE/SMOOTH_XPAN.
> > 
> > As it copies [xy]offset, it probably needs YWRAP/SMOOTH_XPAN/CONUPDATE.
> 
> As I thought more about it, the copy of [xy]offset is also wrong. What if I have
> one console with 4096 vyres and another with only 1024 vyres. Copying offsets
> between them does not make any sense. Setting offsets to zero makes more sense
> (there is no scrollback buffer available anyway).
> 
> > So I guess it should keep the bits under FB_VMODE_MASK.
> 
> Actually, the opposite. Bits under FB_VMODE_MASK should be cleared
> for old console, the remaining ones (YWRAP/SMOOTH_XPAN/CONUPDATE)
> can be copied (or-ed with new ones).

Sorry, that's what I meant (`keep' means do not copy).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
