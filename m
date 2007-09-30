From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 06/17] platinumfb: Fix resource
 management
Date: Sun, 30 Sep 2007 09:11:37 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0709300910570.10965@anakin>
References: <46FDAA91.4080205@gmail.com>
	<Pine.LNX.4.64.0709291115300.10965@anakin>
	<1191102785.28637.2.camel@pasglop>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ibsxx-0001wn-Mi for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 30 Sep 2007 00:11:49 -0700
Received: from asia.telenet-ops.be ([195.130.137.74])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ibsxu-0003eI-7z
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 30 Sep 2007 00:11:49 -0700
In-Reply-To: <1191102785.28637.2.camel@pasglop>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Andy Whitcroft <apw@uk.ibm.com>

On Sun, 30 Sep 2007, Benjamin Herrenschmidt wrote:
> > Probably scripts/checkpatch.pl should be taught to complain about
> > `#undef DEBUG'.
> 
> Why ? Whenever I have things that are #ifdef DEBUG in the file (such as
> dev_dbg statements), I always leave a #undef DEBUG statement at the top.

Because it overrides a -DDEBUG on the build command line.

> That way, I know I can enable debug in that file by flicking it.

Just add #define DEBUG at the top?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
