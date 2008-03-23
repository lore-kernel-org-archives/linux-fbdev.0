From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: vga16fb: blank screen with Intel
 GM965/GL960 on HP 2510p notebook
Date: Sun, 23 Mar 2008 10:05:19 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803231005101.25605@anakin>
References: <20080321163944.GA22068@deprecation.cyrius.com>
	<200803222035.08897.elendil@planet.nl>
	<20080322232708.GA32209@deprecation.cyrius.com>
	<200803230226.38587.elendil@planet.nl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JdM8v-0006sL-Ss for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 23 Mar 2008 02:05:30 -0700
Received: from monty.telenet-ops.be ([195.130.132.56])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JdM8s-0002sw-O9
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 23 Mar 2008 02:05:29 -0700
In-Reply-To: <200803230226.38587.elendil@planet.nl>
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
To: Frans Pop <elendil@planet.nl>
Cc: linux-fbdev-devel@lists.sourceforge.net, Martin Michlmayr <tbm@cyrius.com>, Keith Packard <keith.packard@intel.com>

On Sun, 23 Mar 2008, Frans Pop wrote:
> The problem here is that /proc/fb doesn't show VESA when the regular 
> installer is booted, AFAICT because we boot with vga=normal. vesafb seems 
> to only be actually activated by the kernel during boot if you boot with a 
> vga mode that requires it.

That's true. Vesafb uses the linear graphics mode as programmed by the
BIOS _before_ starting the kernel, and doesn't contain code to switch graphics
mode itselfs.

> The installer then runs its init scripts, specifically
> /lib/debian-installer-startup.d/S40framebuffer-module-linux-x86, and that 
> ends up loading vga16fb because loading vesafb fails (as it's compiled in).
> And thus you end up with vga16fb, basically because it's the only 
> framebuffer available _despite_ the fact that vesafb is compiled in...
> 
> Is there is a way to activate vesafb post-boot even when the system was 
> booted with vga=normal? If there is this could probably be avoided.

No, as it relies on the BIOS.

Uvesafb can, but it relies on a userspace helper daemon.

> Also, does anyone know a way to test whether fbcon is compiled in or not?
> We can of course test if fbcon is available as a module and assume it's 
> compiled in if not, but that's not a proper test that it _is_ present.

If /sys/class/graphics/fbcon exists but lsmod doesn't show fbcon?

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
