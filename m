From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Feature Freeze?
Date: Wed, 5 Mar 2003 15:04:57 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0303051502350.23176-100000@vervain.sonytel.be>
References: <20030305134355.GA3105@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qZWc-0003Hd-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 06:05:38 -0800
In-Reply-To: <20030305134355.GA3105@iliana>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 5 Mar 2003, Sven Luther wrote:
> On Wed, Mar 05, 2003 at 08:46:52PM +0800, Antonino Daplas wrote:
> > On Wed, 2003-03-05 at 19:05, Sven Luther wrote:
> > > On Wed, Mar 05, 2003 at 04:26:04PM +0800, Antonino Daplas wrote:
> > > > I believe it's time to finalize what is needed/not needed for the
> > > > framebuffer framework:
> > > > 
> > > > 1. Text mode support?
> > > 
> > > Would this work also on arches which don't traditionnaly do text mode ?
> > > Like ppc for example. 
> > 
> > Yes, pixel-based drawing is still the default.  It's only for drivers
> > (matrox and sbus) where it might be needed.
> 
> And do you think there is a chance of standard vgacon working on a ppc
> board ? I have a pegasos powerpc/pop based board, and its OF use a x86
> emulator to boot the card into vga textmode. matroxfb is broken on it
> last i tried, and radeonfb was not uptodate in the kernel that was
> provided, and i there is problems with other fbdevs also, so it
> would be nice if it was possible to use vgacon on such hardware, until
> the fbdevs are fixed, but it is a bit hard to fix things without a
> working console.

If your BIOS initializes your graphics card to VGA text mode, vgacon should
work. The same is true for vga16fb.

Vga16fb works on the S3 in my LongTrail, iff I first run a BIOS emulator to
initialize the card to textmode. Never tried vgacon, since the BIOS emulator is
a userspace program and vga16fb can be modular.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
