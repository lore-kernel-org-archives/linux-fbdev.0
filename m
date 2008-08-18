From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: intelfb crashes during modprobe
Date: Mon, 18 Aug 2008 17:09:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0808181708030.3969@anakin>
References: <376ea3380808140821k4e2ec102n452bcc7bb9cc3676@mail.gmail.com>
	<20080817200928.15da18c6.krzysztof.h1@poczta.fm>
	<376ea3380808180800h308a5d89v5cd213acfa6b2c0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KV6MF-0005f6-Dk for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 Aug 2008 08:09:23 -0700
Received: from gerard.telenet-ops.be ([195.130.132.48])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KV6MD-00068A-KS
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 Aug 2008 08:09:23 -0700
In-Reply-To: <376ea3380808180800h308a5d89v5cd213acfa6b2c0c@mail.gmail.com>
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
To: Jon Dufresne <jon.dufresne@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Mon, 18 Aug 2008, Jon Dufresne wrote:
> > Could you provide more details? Especially, if you have connected a CRT
> > (either real CRT or external LCD panel) or the LVDS (LCD directly to
> > the chip - like in laptops).
> 
> I have the graphics chip connected to an external LCD using the vga port.
> 
> Btw, I made a mistake in my first post. The chip is an intel 945GM, not 965G.
> 
> I've done a bit of experimenting and this crash only occurs when the
> "accel" option is turned on. If accel is turned on (the default), then
> when I modprobe the driver the system restarts. Otherwise the system
> comes on.

Thanks, that may be a clue for the intelfb experts...

> Is accel something crucial that I should be concerned about?

It enables acceleration (rectangle fill and copy, monochrome color
expansion) for the frame buffer console.

If you disable it, your text console will become slower.

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
