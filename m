From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] fbdev: workaround for broken X servers
Date: Wed, 3 Nov 2004 05:26:13 +0200
Message-ID: <20041103032613.GA3677@sci.fi>
References: <1099448020.900.25.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPBms-0005Ng-UR
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 19:26:18 -0800
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CPBmq-0003EX-9t
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 19:26:18 -0800
Content-Disposition: inline
In-Reply-To: <1099448020.900.25.camel@gaston>
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>

On Wed, Nov 03, 2004 at 01:13:39PM +1100, Benjamin Herrenschmidt wrote:
> Hi !
>=20
> XFree (and X.org) has both always been broken in their conversion of th=
e DPMS
> blanking mode when passing to the kernel ioctl FBIOBLANK (in fbdev mode=
).
>=20
> This patch makes sure that at least the value passed by userland stays =
in the
> legal range, which has the side effect that an X DPMS POWERDOWN request=
 will
> result as an fbdev VESA_POWERDOWN request at the fbdev level now, inste=
ad of
> an out-of-range value.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> Index: linux-work/drivers/video/fbmem.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-work.orig/drivers/video/fbmem.c	2004-10-26 13:15:55.000000000=
 +1000
> +++ linux-work/drivers/video/fbmem.c	2004-11-03 13:10:41.324932256 +110=
0
> @@ -748,6 +748,10 @@
>  	u16 *black =3D NULL;
>  	int err =3D 0;
>  =09
> +	/* Workaround for broken X servers */
> +	if (blank > VESA_POWERDOWN)
> +		blank =3D VESA_POWERDOWN;
> +
>  	if (info->fbops->fb_blank && !info->fbops->fb_blank(blank, info))
>  		return 0;
> =20

This goes against documented behaviour (see fb.h). Also drivers/char/vt.c=
=20
seems to agree with fb.h, as do at least atyfb and matroxfb. I also used=20
the vesa level+1 convention in DirectFB. So AFAICS this patch would=20
confuse console power management, XFree86/X.Org, DirectFB and some fb=20
drivers.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
