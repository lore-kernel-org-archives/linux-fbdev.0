From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: "problem" with mdacon
Date: Sun, 20 Jan 2008 12:08:11 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801201205050.28200@anakin>
References: <112492815@web.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JGY2F-0005eG-K7 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 20 Jan 2008 03:08:19 -0800
Received: from ananke.telenet-ops.be ([195.130.137.78])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JGY2E-0000Ot-4i
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 20 Jan 2008 03:08:19 -0800
In-Reply-To: <112492815@web.de>
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
To: devzero@web.de
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>, mj@ucw.cz

	Hi Roland,

On Fri, 18 Jan 2008, devzero@web.de wrote:
> sorry for contacting directly, but i was unsure about what list is best to ask questions for console specific stuff.
> maybe  linux-fbdev or linuxconsole-dev ? the latter looks dead - there is nothing but spam in the recent archive...

I'd use linux-fbdev-devel and cc to lkml (already added).

> ok - my "problem" (not being a real one, but not sure if this is a bug)
> 
> if i do "modprobe mdacon" (without any options) the system console output freezes and takes no more keyboard input (no vt switching, too)
> this happens on any real hardware and also in vmware.
> 
> looks weird to me - is this expected behaviour ?
> 
> i would have expected some "no such device or adress".
> 
> found this by chance by some module load/unload stresstesting and there are not many modules which break my system when loading/unloading - mdacon is one of the very few...
> 
> would be nice to get a comment about this.

I think it should just complain with `mdacon: MDA card not detected.',
if no MDA card is present.

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
