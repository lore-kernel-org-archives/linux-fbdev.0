From: Javier Marcet <jmarcet@pobox.com>
Subject: matroxfb dualhead instabilities
Date: Wed, 16 Oct 2002 02:08:09 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021016000809.GA19682@jerry.marcet.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from 137-123-adsl.red.retevision.es ([80.224.123.137] helo=jerry.marcet.dyndns.org)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 181bjP-0006wT-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 15 Oct 2002 17:08:11 -0700
Content-Disposition: inline
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


--f2QGlHpHGjS2mn6Y
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Petr,
I am doing a package for Gentoo with some tools for matrox dual-head
cards, mainly developed by you and available on your ftp.

I am using linux 2.4.20-pre8-ac3 at the moment. I hadn't used the second
head too much until now.

I patched my kernel with fbset-through-vt-2.4.19-rc5.gz,
mga-2.4.19-rc5-tvout.gz was already merged by Alan Cox on his tree.
However I get oopses often when using a console on my TV if I am playing
with matroxset & fbset, which I am right now as I am polishing some
scripts and default config files to include in the package for Gentoo.
I have just removed it from my kernel and I'll see if the oopses show up
again.

I tried matroxfb-vsync-irq-patch-2.4.19 too, but with it I cannot use at
all any board on my first PCI slot since the Matrox is using the IRQ.
What is the patch good for? I just have a crowded PC and no free slots.

I send attached two of the scripts I've written. There is something
which I could not yet understand.
If you run 'mgafb.sh pal fb1 4' to set fb1 in pal mode and control
virtual console 4, in principle works just fine. If I run it from
tvgetty.sh from inittab there aren't any kind of problems, but if I
launch it from another console, the first time works as expected, but
after the first one, not only console 4 changes of mode, but the console
I am calling it from also changes to pal mode.
I couldn't understand why. DO you see any reason?

Besides, if you read tvgetty.sh, you'll see a line with 'setfont'.
That's because without it I do not get 8bit mode on that console, and
thus can't see extended characters. Is it normal that I have to
re-run that kind of init scripts, which are system-wide (for all the
consoles) on my system, for the second head?

I hope I made me clear enough. Otherwise, tell me what needs to be
clarified.


--=20
Javier Marcet <jmarcet@pobox.com>
Saint Louis University, Madrid Campus

--pWyiEgJYm5f9v55/
Content-Type: application/x-sh
Content-Disposition: attachment; filename="tvgetty.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0A# agetty on 2nd head=0A# $ Rev 0.1 tvgetty.sh 2002-10-15 00:10 =
jmarcet $=0A=0A[[ $# -ne 3 ]] && printf "Usage: tvgetty.sh mode fb tty\n\n"=
 \=0A	&& printf "\tmode : pal, ntsc or any other mode defined in /etc/fb.mo=
des\n" \=0A	&& printf "\tfb   : frame buffer to use\n" \=0A	&& printf "\ttt=
y  : console to control on that fb\n" \=0A	&& printf "\n\n" \=0A	&& printf =
"This tool lets you change between PAL, NTSC and MONITOR modes\n"	\=0A	&& p=
rintf "of the Matrox card, and assign certain framebuffer to certain\n"	\=
=0A	&& printf "console with a getty logon.\n" \=0A	&& exit=0A=0A=0AMODE=3D$=
1=0AFB=3D${2/\/dev\/} =0AFB=3D/dev/fb/${FB/fb} =0ATTY=3D${3/tty} =0ATTY=3D$=
{TTY/vc\/} =0ATTY=3Dvc/${TTY/\/dev\/} =0A=0Aclear >/dev/$TTY=0A/usr/bin/set=
font=0A/usr/bin/mgafb.sh $MODE $FB $TTY=0A/sbin/agetty 9600 $TTY linux=0Acl=
ear >/dev/$TTY=0A/usr/bin/mgafb.sh default fb0 $TTY=0A
--pWyiEgJYm5f9v55/
Content-Type: application/x-sh
Content-Disposition: attachment; filename="mgafb.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0A# small script with ideas of scripts from both mplayer and free=
vo's TVOut=0A# tools=0A=0A[[ $# -ne 3 ]] && printf "Usage: mgafb.sh mode fb=
 tty\n\n" \=0A	&& printf "\tmode : pal, ntsc or any other mode defined in /=
etc/fb.modes\n" \=0A	&& printf "\tfb   : frame buffer to use\n" \=0A	&& pri=
ntf "\ttty  : console to control on that fb\n" \=0A	&& printf "\n\n" \=0A	&=
& printf "This tool lets you change between PAL, NTSC and MONITOR modes\n"	=
\=0A	&& printf "of the Matrox card, and assign certain framebuffer to certa=
in\n"	\=0A	&& printf "console.\n" \=0A	&& exit=0A=0AMODE=3D$1=0AFB=3D${2/\/=
dev\/} =0AFB=3D/dev/fb/${FB/fb} =0ATTY=3D${3/tty} =0ATTY=3D${TTY/vc\/} =0AT=
TY=3D/dev/vc/${TTY/\/dev\/} =0A=0A# make sure second head drives fb1 and pr=
imary head drives fb0 - this is the=0A# default, but it's best to be safe -=
=0A# you might want a different layout, with 3 you would get clone-mode=0Am=
atroxset -f /dev/fb1 -m 2=0Amatroxset -f /dev/fb0 -m 1=0A=0A# set the 768x5=
76 'pal' output - this mode is defined in /etc/fb.modes=0Afbset -fb $FB $MO=
DE > /dev/null=0A=0Acon2fb $FB $TTY=0A=0A# switch mode to PAL (1), NTSC (2)=
 or MINITOR (128)=0A# depending upon MODE selected=0Aif [ $MODE =3D=3D pal =
] || [ $MODE =3D=3D PAL ]; \=0A	then matroxset 1; \=0A	elif [ $MODE =3D=3D =
ntsc ] || [ $MODE =3D=3D NTSC ]; \=0A		then matroxset 2; \=0A	else matroxse=
t 128; \=0Afi=0A=0A# set contrast, saturation, hue and brightness to better=
 (more readable)=0A# values=0Amatrox 0x1e 0xd0 >/dev/null=0Amatrox 0x20 0xf=
f >/dev/null=0Amatrox 0x22 0xff >/dev/null=0A=0Asetterm -blank 0=0A
--pWyiEgJYm5f9v55/--

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iEYEARECAAYFAj2srekACgkQx/ptJkB7frxnawCeNiPCH/Af+9QUAIVt/5uS1sES
ovYAn145l7oR4IzlqmZ6HZjQ1RNoPuzB
=h4ND
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--


-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
