From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: Problem with radeon new ROM probe code
Date: Wed, 24 Sep 2003 17:18:03 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1064416682.10673.52.camel@thor.holligenstrasse29.lan>
References: <1064405197.15996.44.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A2BP5-0000G8-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 24 Sep 2003 08:18:07 -0700
Received: from netline-mail1.netline.ch ([195.141.226.27])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A2BP4-0008V5-7N
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Sep 2003 08:18:06 -0700
In-Reply-To: <1064405197.15996.44.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-09-24 at 14:06, Benjamin Herrenschmidt wrote:
>=20
> Your new code for looking at the card's ROM is causing a problem for
> me. On some cards, typically the "Mac" cards, the ROM doesn't contain
> an x86 BIOS, but rather an OF driver. The current code will blindly
> tap that, though it contains none of the expected tables, and will
> use completely wrong values.
>=20
> Do you have ideas how to make some sanity checking on the ROM content ?

The X radeon driver has this in RADEONGetBIOSParameters():

if (info->VBIOS[0] !=3D 0x55 || info->VBIOS[1] !=3D 0xaa) {
	xfree(info->VBIOS);
	info->FPBIOSstart =3D 0;
	info->VBIOS =3D NULL;
	info->BIOSAddr =3D 0x00000000;
	xf86DrvMsg(pScrn->scrnIndex, X_WARNING,
		   "Video BIOS not found!\n");
    }


--=20
Earthling Michel D=C3=A4nzer   \  Debian (powerpc), XFree86 and DRI devel=
oper
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=3Ddaenze=
r



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
