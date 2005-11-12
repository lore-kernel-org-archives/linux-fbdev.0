From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: geodefb issues, possible patch
Date: Sat, 12 Nov 2005 08:37:29 +0100
Message-ID: <43759BB9.70409@t-online.de>
References: <eb77d7060511110405i13b8bc8aw335147185398cd22@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eapqs-0001Lq-Be
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 11 Nov 2005 23:31:06 -0800
Received: from mailout07.sul.t-online.com ([194.25.134.83])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Eapqs-0007tI-1e
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 11 Nov 2005 23:31:06 -0800
In-Reply-To: <eb77d7060511110405i13b8bc8aw335147185398cd22@mail.gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net


>i have a patch if someone is interested. the problem is that i dont
>know what else to do, as i cant debug (with printf's) the driver as i
>dont have a screen, how does a fb driver gets debugged?=20
>
First of all, it=B4s a good idea to allow the driver to be compiled eithe=
r=20
as a
module or as a permanent part of the kernel. If it=B4s a module, it is re=
ally
helpfull if it can be unloaded / reloaded.  Allow your driver to be loade=
d
with vesafb or vesafb-tng compiled into the kernel, normally that should
be possible if you do not fail if you cannot get exclusive access to some
resources vesafb reserves. That way you might start with vesafb, load=20
version
1 of your driver, map consoles to either one, do some testing, map all
consoles to vesafb, unload your module and load a new version. That helpe=
d
a lot in debugging cyblafb.

If you do loop for some conditions, always include a timeout.

Use printks, and have a look at the system log after a reboot.

Use a serial console or another computer connected via network.

Let the driver display some status information at a fixed location of
the screen.

First of all: write a userspace program that does a complete register dum=
p.
Boot with vesafb and all vga=3D??? parameters supported by the bios and s=
tore
those register dump.  Include a register dump function in the driver and=20
compare
the register values to those found for vesafb.

Don=B4t believe documentation that indexed registers end at index x if x =
is
less than the highest possible value. If bits of a value are stored in=20
several
places (e.g. vga screen start address), don=B4t assume that the documenta=
tion
documents all high bits.

Get it right unaccelerated first.

cu,
 knut



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Downl=
oad
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
