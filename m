From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: matroxfb dualhead instabilities
Date: Wed, 16 Oct 2002 18:01:16 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4C7D0093FFE@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mailgw.cvut.cz ([147.32.3.235])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 181qcA-0001ra-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 16 Oct 2002 09:01:42 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Javier Marcet <jmarcet@pobox.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On 16 Oct 02 at 17:33, Javier Marcet wrote:
> * Petr Vandrovec <VANDROVE@vc.cvut.cz> [021016 09:19]:
> 
> >> I patched my kernel with fbset-through-vt-2.4.19-rc5.gz,
> >> mga-2.4.19-rc5-tvout.gz was already merged by Alan Cox on his tree.
> >> However I get oopses often when using a console on my TV if I am playing
> >> with matroxset & fbset, which I am right now as I am polishing some
> >> scripts and default config files to include in the package for Gentoo.
> >> I have just removed it from my kernel and I'll see if the oopses show up
> >> again.
> 
> >Make sure that you boot with 'video=scrollback:0' if you have more
> >than one head... It is also very dangerous to use 'fbset -fb /dev/fbX'
> 
> By more than one head you mean more than one physical card? Ot does my
> G400MAX with its two heads count as more than one?

It counts as two if you are using /dev/fb1...
 
> >in multihead environment, because of PROC_CONSOLE() returns vt
> >number from the VT for the process, happilly passing VT initialized
> >by vga16 or primary head of matroxfb to secondary head. And secondary
> >head is certainly surprised if it is invoked on console saying
> >8bpp, while it supports only 16/32...
> 
> One strange thing I've seen though, is that I cannot use 'fbset -depth
> xx' with xx other than 32 or I'll get:
>     'ioctl FBIOPUT_VSCREENINFO: Invalid argument'

16bpp should work too on second head.
     
> >If you'll use 'fbset -fb /dev/ttyX', no oops should occur.
> 
> Whenever I try to pass a tty as argument to the -fb option I get the
> same error I wrote above.

16bpp and 32bpp should work. Because of values in default /etc/fb.modes
are with 8bpp, you must use 'fbset 1024x768-60 -depth 32'. And if
you are using Debian (maybe it is problem with stock fbset, I did not
verified it), make sure that videomode 1024x768-72 in /etc/fb.modes
does not use 10224 as xres/vxres... Most of monitors and videocards does 
not handle xres=10224 properly. You need dozen of megabytes vram to
use this mode...

> >> I tried matroxfb-vsync-irq-patch-2.4.19 too, but with it I cannot use at
> >> all any board on my first PCI slot since the Matrox is using the IRQ.
> >> What is the patch good for? I just have a crowded PC and no free slots.
> 
> >I did not wrote that patch... Make sure that request_irq() is done
> >for shared irq, Matrox hardware has no problem with sharing irq, and
> >if irq handler in matroxfb-vsync-irq-patch is written correctly, it
> >should just work.
> 
> I know it is not a problem of the card itself, since without that patch
> I don't have problems, but with it whenever a card on the 1st PCI tries
> to use an IRQ, say a NIC card which is enabled by a 'if eth0 up', the
> system blocks. No output, no sysrq, nothing, just a solid freeze.

Maybe that it enables IRQ on card before installing IRQ handler.
In such case nobody is going to clear IRQ in mga IRQ status register,
and your system is processing endless stream of interrupts. Buying
another CPU may give you chance to debug it. Or if you'll send
me pointer to the patch, I can review it...

> BTW, of the other two patches available, what is the one quoted at the
> top of this message for? I have removed it and since then I get no more
> locks when heavily using my second head, which was specially sensitive
> when doing lots of 'fbset', 'matroxset' et all.

Which one? fbset-through-vt? It should not change behavior of
fbset when using 'fbset -fb /dev/fb*', it just adds possibility
to use 'fbset -fb /dev/tty*' to set videomode on specific virtual
terminal. And it should not cause any behavior changes to matroxset.

If mga-*-tvout, it adds support for DVI-D and TV outputs available
on G450/G550.

> >> tvgetty.sh from inittab there aren't any kind of problems, but if I
> >> launch it from another console, the first time works as expected, but
> >> after the first one, not only console 4 changes of mode, but the console
> >> I am calling it from also changes to pal mode.
> >> I couldn't understand why. DO you see any reason?
> 
> >Yes. Second time it will call secondary's head set_var with console
> >argument 0, because of PROC_CONSOLE() will return that... 
> >Use 'fbset -fb /dev/tty4', and all problems will magically disappear.
> >I'm using
> 
> >set -e
> 
> What is this for? emacs mode?
> I use 'set -vi' :)

Stop on error... so in your case it will stop just immediately
after fbset will fail, instead of performing (now useless and
dangerous) second fbset, matroxset, and chvt.
 
> >con2fb /dev/fb1 /dev/tty8
> 
> This is the command less problems has given to me ;-) Simple code and
> apparently bug-free :)
> 
> >fbset -fb /dev/tty8 1280x1024-60 -depth 16
> >fbset -fb /dev/tty8 -vyres 3276
> 
> I cannot do that, or else I'll get the 'ioctl FBIOPUT_VSCREENINFO:
> Invalid argument'. The only way I've found is to switch to the desired
> vt, and run fbset there.

Do you have 16MB or 32MB device? -vyres 3276 will work only if
you have 8MB available for second head. With 16MB device maybe
only 7.9MB is available for second head. And of course, you must have
fbset-through-vt patch in your kernel, otherwise you'll get -EINVAL
too.
 
> >> Besides, if you read tvgetty.sh, you'll see a line with 'setfont'.
> >> That's because without it I do not get 8bit mode on that console, and
> >> thus can't see extended characters. Is it normal that I have to
> >> re-run that kind of init scripts, which are system-wide (for all the
> >> consoles) on my system, for the second head?
> 
> >Probably. Console subsystem tends to load default font to the tty
> >on mode sets: look at fbcon_setup: it will find whether
> >some other VT on specified fb uses some font, then it releases
> >current font, and now, if it found some font in previous step
> >(i.e. at least two VTs use this fbdev...), it will copy this font
> >to the VT in question, otherwise it will try fbdev default font
> >(as specified by video=matrox:font:...), or system global default
> >font (fbcon_get_default_font()).
> 
> That was it, I have to change the font on fb1 at least once and it'll be
> in effect from there on on any vt open on fb1.

OK.
 
> Another question. To get a fast vertical scroll I have to run with a
> bigger virtual yres than real's. Is this normal? 

Yes. With yres=vyres you cannot use hardware panning, hardware must
always move full screen 16 graphics lines up. Even if MGA core
can transfer 1GBps, it takes some time to scroll 3MB (for 1024x768/32bpp)
up - to scroll out all 48 lines it is 144MB read + 144MB written...

> Also, with fastfonts
> enabled, it's terribly slow, while in the kernel documentation it's
> stated than fastfonts is faster on Gx00 cards.
> Has that anything to do with the scrollback you told me before? I have
> not tried it yet.

No. fastfont should be used only on G200 (if anywhere...). On G200
you'll get about 10% speed gain, on older chips about 10% slowdown.
But (for unknown reason...) on G400 you'll get about 1000% slowdown.
Maybe I should rerun benchmarks listed in Documentation/fb/matroxfb.txt
also on newer hardware.

> Anyway, thanks, and I mean a BIG thanks for your detailed quick and
> prompt response. I wish I got such a nice help with a bttv/DVB cards
> problem I cannot solve.

Buy me one... if it is terrestric digital broadcast, maybe I could
even receive some digital signal here.
                                                Petr
                                                


-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
