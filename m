From: Miles Lane <miles.lane@gmail.com>
Subject: Re: Re: 2.6.12-rc1-mm2 -- nvidiafb driver gives black screen
Date: Mon, 25 Apr 2005 16:31:36 -0400
Message-ID: <a44ae5cd0504251331232ff004@mail.gmail.com>
References: <a44ae5cd0503242023233dc23f@mail.gmail.com>
	 <a44ae5cd05042217122613bac4@mail.gmail.com>
	 <a44ae5cd05042410092055e3c4@mail.gmail.com>
	 <200504251121.24725.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DQAFA-0005Fz-Qn
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 25 Apr 2005 13:31:48 -0700
Received: from wproxy.gmail.com ([64.233.184.207])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DQAFA-0006Py-Bn
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 25 Apr 2005 13:31:48 -0700
Received: by wproxy.gmail.com with SMTP id 69so1365567wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 25 Apr 2005 13:31:39 -0700 (PDT)
In-Reply-To: <200504251121.24725.adaplas@hotpop.com>
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

Yep, that seems to have fixed it. =20

Thanks!
          Miles

On 4/24/05, Antonino A. Daplas <adaplas@hotpop.com> wrote:
>
> Can you try this patch?  This limits the amount of RAM that nvidiafb
> will remap to 64 MiB.  This is on top of another patch I sent to Andrew:
> "[Linux-fbdev-devel] [PATCH 1/6] nvidiafb: ioremap and i2c fixes"
>=20
> Tony
>=20
> diff -Nru a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
> --- a/drivers/video/nvidia/nvidia.c     2005-04-16 11:54:44 +08:00
> +++ b/drivers/video/nvidia/nvidia.c     2005-04-25 10:39:45 +08:00
> @@ -1511,9 +1511,9 @@
>         if (vram && vram * 1024 * 1024 < par->FbMapSize)
>                 par->FbMapSize =3D vram * 1024 * 1024;
>=20
> -       /* Limit amount of vram to 128 MB */
> -       if (par->FbMapSize > 128 * 1024 * 1024)
> -               par->FbMapSize =3D 128 * 1024 * 1024;
> +       /* Limit amount of vram to 64 MB */
> +       if (par->FbMapSize > 64 * 1024 * 1024)
> +               par->FbMapSize =3D 64 * 1024 * 1024;
>=20
>         par->FbUsableSize =3D par->FbMapSize - (128 * 1024);
>         par->ScratchBufferSize =3D (par->Architecture < NV_ARCH_10) ? 8 *=
 1024 :
>=20
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
