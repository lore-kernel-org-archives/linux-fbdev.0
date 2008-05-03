From: devzero@web.de
Subject: =?iso-8859-15?Q?[PATCH]_mdacon_messing_up_default_vc's,_set_default_to?=
 =?iso-8859-15?Q?_vc13-16_again?=
Date: Sat, 03 May 2008 22:09:25 +0200
Message-ID: <263875520@web.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754750AbYECUJh@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: Linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: adaplas@gmail.com, alan@lxorguk.ukuu.org.uk, edward@debian.org, jsimmons@infradead.org, Soeren Sonnenburg <kernel@nn7.de>, matan@svgalib.org

mdacon incorrectly detects MDA hardware on systems without such graphic=
s card.

one may load this module by chance, for example when doing some systema=
tical=20
module-testing, and if there is no Monochrome Display Adapter attached =
, module init=20
renders vc1-16 completely unusable.=20

me and others have run into this more than once. see [Bug 224522 - modp=
robe mdacon=20
freezes machine -> https://bugzilla.novell.com/show_bug.cgi?id=3D224522=
 ] for example

apparently, proper MDA detection seems to be broken for a long time - s=
eems to be=20
related to those #ifdef TEST_MDA_B statements added by Edward Betts.

this commit back in 2002 made things even worse :
http://git.kernel.org/?p=3Dlinux/kernel/git/tglx/history.git;a=3Dcommit=
;h=3Dc72757b49c88914433244757fb4967fc63546685
=20
it changed default vc allocation from 13-16 to 1-16  for no apparent re=
ason (!?) , and=20
with that (and without X), mdacon grabs the vc you`re currently sitting=
 on and locks you out.

this is from Kconfig :
>config MDA_CONSOLE
>        depends on !M68K && !PARISC && ISA
>        tristate "MDA text console (dual-headed) (EXPERIMENTAL)"
>        ---help---
>          Say Y here if you have an old MDA or monochrome Hercules gra=
phics
>          adapter in your system acting as a second head ( =3D video c=
ard). You
>          will then be able to use two monitors with your Linux system=
=2E Do not
>          say Y here if your MDA card is the primary card in your syst=
em; the
>          normal VGA driver will handle it.

As we can see mdacon is just meant as an additional driver for dual-hea=
d setup,=20
and since kernel 2.4.36 still defaults to vc13-16 ,  setting the defaul=
t back to that value=20
again shouldn`t  do any harm.=20

hereby i`m reverting that change, setting default back to to vc13-16 ag=
ain.

Besides the fact that mdacon may be rarely or never be used these days =
and could=20
perhaps put to trash anyway (pre-dinosaur hardware!), indeed this is no=
t a real solution, =20
but at least it removes the unfortunate side-effect of messing up the v=
c you`re working on.


Signed-off-by: Roland Kletzing <devzero@web.de>

--- drivers/video/console/mdacon.c.orig 2008-05-03 15:47:20.000000000 +=
0200
+++ drivers/video/console/mdacon.c      2008-05-03 15:55:27.000000000 +=
0200
@@ -71,13 +71,15 @@

 /* console information */

-static int     mda_first_vc =3D 1;
+static int     mda_first_vc =3D 13;
 static int     mda_last_vc  =3D 16;

 static struct vc_data  *mda_display_fg =3D NULL;

 module_param(mda_first_vc, int, 0);
+MODULE_PARM_DESC(mda_first_vc, "First virtual console. Default: 13");
 module_param(mda_last_vc, int, 0);
+MODULE_PARM_DESC(mda_last_vc, "Last virtual console. Default: 16");

 /* MDA register values
  */

_______________________________________________________________________
EINE F=DCR ALLE: die kostenlose WEB.DE-Plattform f=FCr Freunde und Dein=
e
Homepage mit eigenem Namen. Jetzt starten! http://unddu.de/?kid=3Dkid@m=
f2
