From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] Redesign of kernel graphics interface
Date: Fri, 7 May 2004 10:30:33 +0200 (MEST)
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0405071021380.28787@waterleaf.sonytel.be>
References: <20040506231953.B23760@armor.freesurf.fr>
 <20040506214214.95811.qmail@web14928.mail.yahoo.com> <20040507003029.D23760@armor.freesurf.fr>
Mime-Version: 1.0
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
In-Reply-To: <20040507003029.D23760@armor.freesurf.fr>
Errors-To: mesa3d-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:mesa3d-dev@lists.sourceforge.net>
List-Help: <mailto:mesa3d-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=mesa3d-dev>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Souchu <nsouch@free.fr>
Cc: Jon Smirl <jonsmirl@yahoo.com>, dri-devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 7 May 2004, Nicolas Souchu wrote:
> On Thu, May 06, 2004 at 02:42:14PM -0700, Jon Smirl wrote:
> > BenH and others have made proposals for pushing the mode setting code into a
> > user space library in order to reduce kernel footprint and ease debugging. Most
> > of the code needed for this library already exists in the current Linux FB
> > drivers. I'm not sure if this could be relicensed BSD when it is moved to user
> > space.
>
> One advantage of true graphic drivers (opposed to VESA or more generally bios modes)
> is that they can boot some archs in graphic mode (no text mode) without bios.
> Exactly what linuxfb was originaly designed to. How do you perform this from userspace?

Note that this is `early userspace', in initramfs. Graphics would be
initialized a bit later than today, but (hopefully) still sufficiently early.

Even right now fbcon is initialized later than vgacon, because we need bus
probing before we can detect graphics cards.

If you really need kernel messages earlier, you have to fallback to vgacon
(ugh), a serial console, or an early boot console (like PPC BTEXT).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
