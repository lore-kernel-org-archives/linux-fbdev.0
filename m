From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] pvr2fb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 18:06:07 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915220607.GA2708@linux-sh.org>
References: <20030915215150.GA27662@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19z1UF-0007IK-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 15:06:23 -0700
Received: from newsmtp.golden.net ([199.166.210.106])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 19z1UE-0005Ys-Vx
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 15:06:23 -0700
Content-Disposition: inline
In-Reply-To: <20030915215150.GA27662@dreamland.darkstar.lan>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This looks fine. I'll merge the framebuffer_alloc() changes into my tree and
include it with the next batch of pvr2fb updates.

On Mon, Sep 15, 2003 at 11:51:50PM +0200, Kronos wrote:
> =3D=3D=3D=3D=3D=3D=3D=3D drivers/video/pvr2fb.c 1.17 =3D=3D=3D=3D=3D=3D=
=3D=3D
> D 1.17 03/09/12 22:26:04+02:00 kronos@kronoz.cjb.net 19 18 4/8/796
> P drivers/video/pvr2fb.c
> C - make it compile again. something went wrong in the merge from 1.14.1.=
1 to 1.6
> C - switch to framebuffer_alloc
> ------------------------------------------------
>=20
> =3D=3D=3D=3D=3D drivers/video/pvr2fb.c 1.16 vs 1.17 =3D=3D=3D=3D=3D
> --- 1.16/drivers/video/pvr2fb.c	Mon Jul 14 20:09:25 2003
> +++ 1.17/drivers/video/pvr2fb.c	Fri Sep 12 22:26:04 2003
> @@ -609,17 +610,14 @@
>  	if (!MACH_DREAMCAST)
>  		return -ENXIO;
> =20
> -	fb_info =3D kmalloc(sizeof(struct fb_info) + sizeof(struct pvr2fb_par) +
> -			  sizeof(u32) * 16, GFP_KERNEL);
> +	fb_info =3D framebuffer_alloc(sizeof(struct pvr2fb_par) + sizeof(u32) *=
 16, NULL);
>  =09
>  	if (!fb_info) {
>  		printk(KERN_ERR "Failed to allocate memory for fb_info\n");
>  		return -ENOMEM;
>  	}
> =20
> -	memset(fb_info, 0, sizeof(fb_info) + sizeof(struct pvr2fb_par) + sizeof=
(u32) * 16);
> -
> -	currentpar =3D (struct pvr2fb_par *)(fb_info + 1);
> +	currentpar =3D fb_info->par;
> =20
>  	/* Make a guess at the monitor based on the attached cable */
>  	if (pvr2_init_cable() =3D=3D CT_VGA) {
> @@ -665,7 +663,6 @@
> =20
>  	fb_info->fbops		=3D &pvr2fb_ops;
>  	fb_info->fix		=3D pvr2_fix;
> -	fb_info->par		=3D currentpar;
>  	fb_info->pseudo_palette	=3D (void *)(fb_info->par + 1);
>  	fb_info->flags		=3D FBINFO_FLAG_DEFAULT;
> =20
> @@ -723,7 +720,6 @@
>  	}
>  #endif
>  	unregister_framebuffer(fb_info);
> -	kfree(fb_info);
>  }
> =20
>  static int __init pvr2_get_param(const struct pvr2_params *p, const char=
 *s,
>=20

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/ZjfP1K+teJFxZ9wRAjKsAJ4otd817z+h44HOZVH7YvnrnML0qACbBQE6
On9t9Gdul4R0nC6O56R291Q=
=7dCC
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
