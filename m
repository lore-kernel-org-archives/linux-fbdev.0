From: James Simmons <jsimmons@infradead.org>
Subject: Re: Mirrored and shiftet fonts and logos
Date: Sat, 14 Dec 2002 21:12:45 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0212142111430.9829-100000@phoenix.infradead.org>
References: <004501c2a3ab$015a5eb0$ee3c078b@nb1>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18NJb8-0007qV-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 14 Dec 2002 13:13:23 -0800
In-Reply-To: <004501c2a3ab$015a5eb0$ee3c078b@nb1>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
To: =?iso-8859-1?Q?Andr=E9_Stierenberg?= <stierenberg@gmx.de>
Cc: linux-fbdev-devel@lists.sourceforge.net


Sounds like a endian issue. =3DMaybe the frmaebuffer and the processor are =

different endianess.


On Sat, 14 Dec 2002, Andr=E9 Stierenberg wrote:

> Hello,
>=20
> i=B4m using the framebuffer driver pxafb for my board using the pxa proce=
ssor
> (Accelent IDP). I have a 4 bit monocrom display. when I run the framebuff=
er
> I have some problems. The text in the console it in some way shifted. The
> two parts of the font are switched. The first 4 pixels are at dest+2 and =
the
> last 4 pixels at dest+0. And both parts are mirrored. Now I have done the
> following in fbcon_cfb4.c in function fbcon_cfb4_putcs:
>=20
>   for (rows =3D fontheight(p), dest =3D dest0; rows-- ; dest +=3D bytes) {
>       fb_writew((nibbletab_cfb4[rv(*cdat) >> 4] & eorx) ^ bgx, dest+2);
>       fb_writew((nibbletab_cfb4[rv(*cdat++) & 0xf] & eorx) ^ bgx, dest+0);
>   }
>=20
>=20
> The function rv will reverse the bit order (bit 1 is bit 8, bit 2 is bit =
7..
> etc.).
> And i have swaped the destination offset.
> Now the characters are printed correctly. And in the linux logo, the
> pinguin, something is also wrong. It seems the some pixels are mirrored t=
oo
> whereas other pixels are correct.
>=20
> What could this be and in what way can i fix the problem?
>=20
> Andre
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This sf.net email is sponsored by:
> With Great Power, Comes Great Responsibility=20
> Learn to use your power at OSDN's High Performance Computing Channel
> http://hpc.devchannel.org/
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>=20



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility=20
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
