From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: cirrusfb status report
Date: Tue, 15 Jun 2004 22:06:08 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0406152205130.20765@waterleaf.sonytel.be>
References: <20040615185355.GA12307@havoc.gtf.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BaKCO-00038v-F3
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Jun 2004 13:06:24 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BaKCN-0001lk-S5
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Jun 2004 13:06:24 -0700
In-Reply-To: <20040615185355.GA12307@havoc.gtf.org>
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
To: David Eger <eger@havoc.gtf.org>
Cc: Jeff Garzik <garzik@havoc.gtf.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux/m68k <linux-m68k@lists.linux-m68k.org>

On Tue, 15 Jun 2004, David Eger wrote:
> + ZORRO is busted (don't have the hardware... once i get things nice
>   on x86, I'll look about fixing ZORRO.  Hey geert - do you still have
>   hardware to test this>?)

I never had a Cirrus Logic board for Amiga. Still have the Amiga, and I can do
cross-compile testing ;-)

> + the only mode it likes is 640x480 (but then, that's the only one
>   i got working with the 2.4 driver, so, maybe that's not a regression...)
> + inserting it as a module just leaves crap all over the screen
>
> I ended up doing a lot of things like 's/fb_info/cinfo/g' so the diff
> is gonna look like the whole file, though I haven't (yet) changed any
> of the actual register-writing logic.
>
> Is there anyone else with cirrus logic video boards lying around who will
> be interested in testing the new driver in a couple of days?

Perhaps some PPC/PReP guys?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
