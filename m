From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [Question] Colour management
Date: Sat, 31 Jul 2004 16:31:29 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040731133129.GA12797@sci.fi>
References: <20040722184937.GA11361@sci.fi> <200407260647.03489.adaplas@hotpop.com> <200407302012.36325.alex.kern@gmx.de> <200407311826.27332.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BqtxX-00059K-2R
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 31 Jul 2004 06:31:35 -0700
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BqtxV-0002W9-VM
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 31 Jul 2004 06:31:34 -0700
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id 33CAF4614F
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 31 Jul 2004 16:31:30 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <200407311826.27332.adaplas@hotpop.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net

On Sat, Jul 31, 2004 at 06:26:27PM +0800, Antonino A. Daplas wrote:
> 	In directcolor mode where the channel size !=3D CLUT register size, se=
tting
> the CLUT is a bit tricky.=20
>=20
> Take for example, RGB555. Assuming an 8-bit CLUT size, each channel can=
 only
> accept a total of 32 entries (2 power of 5).  Since an 8-bit CLUT has 2=
56 entries,
> then the driver needs to step by 8 (256/32).  The code is like this the=
n:
>=20
> red_reg[index * 8] =3D red
> green_reg[index * 8] =3D green
> blue_reg[index * 8] =3D blue
>=20
> Some hardware require that all 8 entries needs to be filled up.

I noticed you do this in i810fb. What happens if you don't do this?

AFAIK mach64 doesn't need this.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
