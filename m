From: Javier Marcet <jmarcet@pobox.com>
Subject: Re: matroxfb dualhead instabilities
Date: Wed, 16 Oct 2002 17:33:25 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021016153325.GA28142@jerry.marcet.dyndns.org>
References: <4BF1AF7004E@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from 137-123-adsl.red.retevision.es ([80.224.123.137] helo=jerry.marcet.dyndns.org)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 181qAj-0007KF-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 16 Oct 2002 08:33:22 -0700
Content-Disposition: inline
In-Reply-To: <4BF1AF7004E@vcnet.vc.cvut.cz>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Petr Vandrovec <VANDROVE@vc.cvut.cz> [021016 09:19]:

>> I patched my kernel with fbset-through-vt-2.4.19-rc5.gz,
>> mga-2.4.19-rc5-tvout.gz was already merged by Alan Cox on his tree.
>> However I get oopses often when using a console on my TV if I am playing
>> with matroxset & fbset, which I am right now as I am polishing some
>> scripts and default config files to include in the package for Gentoo.
>> I have just removed it from my kernel and I'll see if the oopses show up
>> again.

>Make sure that you boot with 'video=3Dscrollback:0' if you have more
>than one head... It is also very dangerous to use 'fbset -fb /dev/fbX'

By more than one head you mean more than one physical card? Ot does my
G400MAX with its two heads count as more than one?

>in multihead environment, because of PROC_CONSOLE() returns vt
>number from the VT for the process, happilly passing VT initialized
>by vga16 or primary head of matroxfb to secondary head. And secondary
>head is certainly surprised if it is invoked on console saying
>8bpp, while it supports only 16/32...

One strange thing I've seen though, is that I cannot use 'fbset -depth
xx' with xx other than 32 or I'll get:
	'ioctl FBIOPUT_VSCREENINFO: Invalid argument'
=09
>If you'll use 'fbset -fb /dev/ttyX', no oops should occur.

Whenever I try to pass a tty as argument to the -fb option I get the
same error I wrote above.

>> I tried matroxfb-vsync-irq-patch-2.4.19 too, but with it I cannot use at
>> all any board on my first PCI slot since the Matrox is using the IRQ.
>> What is the patch good for? I just have a crowded PC and no free slots.

>I did not wrote that patch... Make sure that request_irq() is done
>for shared irq, Matrox hardware has no problem with sharing irq, and
>if irq handler in matroxfb-vsync-irq-patch is written correctly, it
>should just work.

I know it is not a problem of the card itself, since without that patch
I don't have problems, but with it whenever a card on the 1st PCI tries
to use an IRQ, say a NIC card which is enabled by a 'if eth0 up', the
system blocks. No output, no sysrq, nothing, just a solid freeze.

BTW, of the other two patches available, what is the one quoted at the
top of this message for? I have removed it and since then I get no more
locks when heavily using my second head, which was specially sensitive
when doing lots of 'fbset', 'matroxset' et all.

>> tvgetty.sh from inittab there aren't any kind of problems, but if I
>> launch it from another console, the first time works as expected, but
>> after the first one, not only console 4 changes of mode, but the console
>> I am calling it from also changes to pal mode.
>> I couldn't understand why. DO you see any reason?

>Yes. Second time it will call secondary's head set_var with console
>argument 0, because of PROC_CONSOLE() will return that...=20
>Use 'fbset -fb /dev/tty4', and all problems will magically disappear.
>I'm using

>set -e

What is this for? emacs mode?
I use 'set -vi' :)

>con2fb /dev/fb1 /dev/tty8

This is the command less problems has given to me ;-) Simple code and
apparently bug-free :)

>fbset -fb /dev/tty8 1280x1024-60 -depth 16
>fbset -fb /dev/tty8 -vyres 3276

I cannot do that, or else I'll get the 'ioctl FBIOPUT_VSCREENINFO:
Invalid argument'. The only way I've found is to switch to the desired
vt, and run fbset there.

>> Besides, if you read tvgetty.sh, you'll see a line with 'setfont'.
>> That's because without it I do not get 8bit mode on that console, and
>> thus can't see extended characters. Is it normal that I have to
>> re-run that kind of init scripts, which are system-wide (for all the
>> consoles) on my system, for the second head?

>Probably. Console subsystem tends to load default font to the tty
>on mode sets: look at fbcon_setup: it will find whether
>some other VT on specified fb uses some font, then it releases
>current font, and now, if it found some font in previous step
>(i.e. at least two VTs use this fbdev...), it will copy this font
>to the VT in question, otherwise it will try fbdev default font
>(as specified by video=3Dmatrox:font:...), or system global default
>font (fbcon_get_default_font()).

That was it, I have to change the font on fb1 at least once and it'll be
in effect from there on on any vt open on fb1.

Another question. To get a fast vertical scroll I have to run with a
bigger virtual yres than real's. Is this normal? Also, with fastfonts
enabled, it's terribly slow, while in the kernel documentation it's
stated than fastfonts is faster on Gx00 cards.
Has that anything to do with the scrollback you told me before? I have
not tried it yet.

Anyway, thanks, and I mean a BIG thanks for your detailed quick and
prompt response. I wish I got such a nice help with a bttv/DVB cards
problem I cannot solve.


--=20
Javier Marcet <jmarcet@pobox.com>
Saint Louis University, Madrid Campus

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iEYEARECAAYFAj2thsUACgkQx/ptJkB7fryozQCeO+rDjDGTyxsRKPt/MvAXPwhA
77cAn3Yb6NeVSeEVjyZuocBvRA0jZeZ7
=1xNr
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--


-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
