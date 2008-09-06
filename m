From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/4] cirrusfb: fix up debug printk
 types
Date: Sat, 6 Sep 2008 12:41:14 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0809061238360.4138@anakin>
References: <20080905235312.ae259d60.krzysztof.h1@poczta.fm>
	<Pine.LNX.4.64.0809061035360.4138@anakin>
	<20080906121353.d6ed31c8.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KbvEE-0003bK-Lq for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 06 Sep 2008 03:41:18 -0700
Received: from winston.telenet-ops.be ([195.130.137.75])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KbvED-0002G1-9i
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 06 Sep 2008 03:41:18 -0700
In-Reply-To: <20080906121353.d6ed31c8.krzysztof.h1@poczta.fm>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 6 Sep 2008, Krzysztof Helt wrote:
> On Sat, 6 Sep 2008 10:37:27 +0200 (CEST)
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, 5 Sep 2008, Krzysztof Helt wrote:
> > > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > > 
> > > Fix debug printk types mismatch after
> > > my earlier changes.
> > 
> > #define DPRINTK(fmt, args...)	pr_debug("%s: " fmt, __func__ , ## args)
> > 
> > unconditionally, so you always catch these?
> > 
> 
> I do not understand. Is it a suggestion to make DPRINTK unconditional?

Yes.

> Then, the amount of information printed should be trimmed down. It is excessive now.

Please not that pr_debug() gets optimized away if DEBUG is not defined
( i.e. it doesn't cause excessive output), while it still performs
printf()-style format checking.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
