From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: matroxfb dualhead instabilities
Date: Wed, 16 Oct 2002 09:18:43 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4BF1AF7004E@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mailgw.cvut.cz ([147.32.3.235])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 181iSF-0001Vq-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 16 Oct 2002 00:18:56 -0700
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

On 16 Oct 02 at 2:08, Javier Marcet wrote:
> 
> I patched my kernel with fbset-through-vt-2.4.19-rc5.gz,
> mga-2.4.19-rc5-tvout.gz was already merged by Alan Cox on his tree.
> However I get oopses often when using a console on my TV if I am playing
> with matroxset & fbset, which I am right now as I am polishing some
> scripts and default config files to include in the package for Gentoo.
> I have just removed it from my kernel and I'll see if the oopses show up
> again.

Make sure that you boot with 'video=scrollback:0' if you have more
than one head... It is also very dangerous to use 'fbset -fb /dev/fbX'
in multihead environment, because of PROC_CONSOLE() returns vt
number from the VT for the process, happilly passing VT initialized
by vga16 or primary head of matroxfb to secondary head. And secondary
head is certainly surprised if it is invoked on console saying
8bpp, while it supports only 16/32...

If you'll use 'fbset -fb /dev/ttyX', no oops should occur.
 
> I tried matroxfb-vsync-irq-patch-2.4.19 too, but with it I cannot use at
> all any board on my first PCI slot since the Matrox is using the IRQ.
> What is the patch good for? I just have a crowded PC and no free slots.

I did not wrote that patch... Make sure that request_irq() is done
for shared irq, Matrox hardware has no problem with sharing irq, and
if irq handler in matroxfb-vsync-irq-patch is written correctly, it
should just work.
 
> I send attached two of the scripts I've written. There is something
> which I could not yet understand.
> If you run 'mgafb.sh pal fb1 4' to set fb1 in pal mode and control
> virtual console 4, in principle works just fine. If I run it from
> tvgetty.sh from inittab there aren't any kind of problems, but if I
> launch it from another console, the first time works as expected, but
> after the first one, not only console 4 changes of mode, but the console
> I am calling it from also changes to pal mode.
> I couldn't understand why. DO you see any reason?

Yes. Second time it will call secondary's head set_var with console
argument 0, because of PROC_CONSOLE() will return that... 
Use 'fbset -fb /dev/tty4', and all problems will magically disappear.
I'm using

#! /bin/bash

set -e
con2fb /dev/fb1 /dev/tty8
fbset -fb /dev/tty8 1280x1024-60 -depth 16
fbset -fb /dev/tty8 -vyres 3276
matroxset -f /dev/fb0 -m 2
matroxset -f /dev/fb1 -m 5
chvt 8

and it works as one expect...

> Besides, if you read tvgetty.sh, you'll see a line with 'setfont'.
> That's because without it I do not get 8bit mode on that console, and
> thus can't see extended characters. Is it normal that I have to
> re-run that kind of init scripts, which are system-wide (for all the
> consoles) on my system, for the second head?

Probably. Console subsystem tends to load default font to the tty
on mode sets: look at fbcon_setup: it will find whether
some other VT on specified fb uses some font, then it releases
current font, and now, if it found some font in previous step
(i.e. at least two VTs use this fbdev...), it will copy this font
to the VT in question, otherwise it will try fbdev default font
(as specified by video=matrox:font:...), or system global default
font (fbcon_get_default_font()).

                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    


-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
