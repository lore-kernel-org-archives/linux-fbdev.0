From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Framebuffer vt's second monitor ATI 9000
Date: Fri, 19 Dec 2003 12:14:06 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0312191213210.29115@waterleaf.sonytel.be>
References: <003e01c3c61f$9b116480$1b2625d5@capricho>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXIaA-0004hE-1d
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Dec 2003 03:14:10 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXIa9-0006uk-Eu
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Dec 2003 03:14:09 -0800
In-Reply-To: <003e01c3c61f$9b116480$1b2625d5@capricho>
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
To: Javier Vizcaino <javizca@mi.madritel.es>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 19 Dec 2003, Javier Vizcaino wrote:
> I have an ISA/PCI/AGP PC. In the past the graphic cards it had were:
> -AGP 3dfx Voodoo3 as primary.
> -PCI Matrox Mystique as secondary.
> It also had (and has now) an ISA Hercules monochrome.
> With them I could have Xinerama on X with 3dfx and Matrox, and framebuffer
> based vt's on Matrox (module matroxfb_base) and Hercules (module hgafb).
> So the PC has three connected monitors. It multiboots in Windows 98SE,
> Windows 2000 and Linux.
>
> I changed the Matrox to install a board with USB2 and 1394 (I have no free
> slots; even I use at the time the ISA and PCI slots which are close, having
> modified a 3Com net card to permit using both close connectors).
>
> For doing multihead I installed an AGP board with an ATI 9000 chip having an VGA
> and a DVI connector, so using an adaptor I can attach two monitors. I keep the
> ISA Hercules monochrome, with its monochrome monitor.
>
> All works as before (see P.D.) with the Matrox except the vt's on the ATI second
> connector. I suppose that the module to use is 'radeonfb.o', but I'm not sure at
> all. With "modprobe radeonfb":
> /lib/modules/2.4.21-0.13mdkcustom/kernel/drivers/video/radeonfb.o: init_module: No such device
> modprobe: insmod /lib/modules/2.4.21-0.13mdkcustom/kernel/drivers/video/radeonfb.o failed
> modprobe: insmod radeonfb failed

This looks like your Radeon is too new for radeonfb.

> and an indication of invalid IO or IRQ.
>
> "modinfo -p radeonfb" gives nothing.
>
> Questions:
> -Is it possible to have framebuffer based vt's on the second connector of the ATI board?
> -How should I proceed (modules, options, etc)?

I don't think radeonfb does real multi-head yet.

> I use Mandrake 9.1 with kernel 2.4.21-0.13. I have also a laptop with a similar ATI chip,
> in which multihead also works similarily, but "modprobe radeonfb" gives the same error.
>
> TIA, Javier Vizcaino, Madrid, Spain.
>
> P.D. What works as before is:
> -Windows 98SE: the two monitors on the AGP board and the ISA Hercules.
> -Windows 2000: the two monitors on the AGP board.
> -Linux: xinerama X, but no vt's on second AGP connector.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
