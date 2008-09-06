From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 1/4] cirrusfb: fix up debug printk
 types
Date: Sat, 6 Sep 2008 12:13:53 +0200
Message-ID: <20080906121353.d6ed31c8.krzysztof.h1@poczta.fm>
References: <20080905235312.ae259d60.krzysztof.h1@poczta.fm>
	<Pine.LNX.4.64.0809061035360.4138@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Kbv90-00033F-Jt for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 06 Sep 2008 03:35:54 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Kbv8z-0000Q0-20
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 06 Sep 2008 03:35:54 -0700
In-Reply-To: <Pine.LNX.4.64.0809061035360.4138@anakin>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 6 Sep 2008 10:37:27 +0200 (CEST)
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Fri, 5 Sep 2008, Krzysztof Helt wrote:
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > Fix debug printk types mismatch after
> > my earlier changes.
> 
> #define DPRINTK(fmt, args...)	pr_debug("%s: " fmt, __func__ , ## args)
> 
> unconditionally, so you always catch these?
> 

I do not understand. Is it a suggestion to make DPRINTK unconditional?
Then, the amount of information printed should be trimmed down. It is excessive now.

I haven't used the DPRINTK because it prints too much information. I used my printk 
added at few points then remove them before creating the patch. After a second thought,
it means that it should be trimmed down as it is hardly usable (maybe convert to 
dev_dbg/dev_err etc.).

I assume the changing the patch before sending accounted for extremely poor quality 
of my patches lately. All group of cirrusfb patches had a follow up patch with some 
corrections. Even the last group requires a one-line correction to work as advertised
albeit even without the fix it works better than previously and do not make any
regression.

Regards,
Krzysztof

----------------------------------------------------------------------
Nie zwlekaj! Tapetuj z nami!
Sprawdz >>  http://link.interia.pl/f1f01


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
