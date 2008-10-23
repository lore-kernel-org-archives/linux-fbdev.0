From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 1/4] cirrusfb: fix up debug printk
 types
Date: Thu, 23 Oct 2008 20:24:45 +0200
Message-ID: <20081023202445.a1fd7ff3.krzysztof.h1@poczta.fm>
References: <20080905235312.ae259d60.krzysztof.h1@poczta.fm>
	<Pine.LNX.4.64.0809061035360.4138@anakin>
	<20080906121353.d6ed31c8.krzysztof.h1@poczta.fm>
	<Pine.LNX.4.64.0809061238360.4138@anakin>
	<20081015160520.9ac1917a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1Kt4p3-0001Go-Tj
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 23 Oct 2008 18:22:13 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Kt4ou-0004sW-Fj for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 23 Oct 2008 18:22:13 +0000
In-Reply-To: <20081015160520.9ac1917a.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>

On Wed, 15 Oct 2008 16:05:20 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Sat, 6 Sep 2008 12:41:14 +0200 (CEST)
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> 
> > On Sat, 6 Sep 2008, Krzysztof Helt wrote:
> > > On Sat, 6 Sep 2008 10:37:27 +0200 (CEST)
> > > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Fri, 5 Sep 2008, Krzysztof Helt wrote:
> > > > > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > > > > 
> > > > > Fix debug printk types mismatch after
> > > > > my earlier changes.
> > > > 
> > > > #define DPRINTK(fmt, args...)	pr_debug("%s: " fmt, __func__ , ## args)
> > > > 
> > > > unconditionally, so you always catch these?
> > > > 
> > > 
> > > I do not understand. Is it a suggestion to make DPRINTK unconditional?
> > 
> > Yes.
> > 
> > > Then, the amount of information printed should be trimmed down. It is excessive now.
> > 
> > Please not that pr_debug() gets optimized away if DEBUG is not defined
> > ( i.e. it doesn't cause excessive output), while it still performs
> > printf()-style format checking.
> > 
> 
> hm.  No change occurred as a result of this discussion.
> 
> I guess none was really needed - I'll go ahead with the patch.
> 

I have made the change of the driver to use the dev_dbg/dev_err() functions some time ago.
However, the real life  sucked me into I have not tested this. I'll return to this when 
I sort out non-Linux stuff. I am slowly recovering and trying to go through pile of unanswered 
emails/bugs reported to my patches.

Take care,
Krzysztof

----------------------------------------------------------------------
Konkurs! Wygraj m.in. telewizor LCD!
Sprawdz >> http://link.interia.pl/f1f52 


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
