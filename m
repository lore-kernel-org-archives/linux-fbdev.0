From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] 2.5.69 drm/radeon_cp.c
Date: 06 May 2003 23:11:33 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1052255493.15269.159.camel@thor>
References: <20030504204901.20761942.randy.dunlap@verizon.net>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from netline-be1.netline.ch ([195.141.226.32])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19D9ir-0003g2-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 06 May 2003 14:11:37 -0700
In-Reply-To: <20030504204901.20761942.randy.dunlap@verizon.net>
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
To: "Randy.Dunlap" <randy.dunlap@verizon.net>
Cc: dri-devel@lists.sourceforge.net, linux-fbdev-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>

On Mon, 2003-05-05 at 05:49, Randy.Dunlap wrote:
>=20
> This patch to 2.5.69 fixes this warning (gcc 3.2):
> drivers/char/drm/radeon_cp.c: In function `radeon_cp_init_ring_buffer':
> drivers/char/drm/radeon_cp.c:908: warning: unsigned int format, different=
 type arg (arg 3)
> drivers/char/drm/radeon_cp.c:908: warning: unsigned int format, different=
 type arg (arg 3)
>=20
>=20
> Is this obvious enough?  Want it to go thru someone?

[...]

> maintainer:	dunno: Ani Joshi (ajoshi@shell.unixbox.com),
> 		James Simmons (jsimmons@infradead.org),
> 		Gareth Hughes (gareth.hughes@acm.org),
> 		Rik Faith (faith@redhat.com)

Make that dri-devel@lists.sf.net .

> diff -Naur ./drivers/char/drm/radeon_cp.c%VID ./drivers/char/drm/radeon_c=
p.c
> --- ./drivers/char/drm/radeon_cp.c%VID	2003-05-04 16:53:06.000000000 -0700
> +++ ./drivers/char/drm/radeon_cp.c	2003-05-04 20:30:30.000000000 -0700
> @@ -903,8 +903,8 @@
> =20
>  		RADEON_WRITE( RADEON_CP_RB_RPTR_ADDR,
>  			     entry->busaddr[page_ofs]);
> -		DRM_DEBUG( "ring rptr: offset=3D0x%08x handle=3D0x%08lx\n",
> -			   entry->busaddr[page_ofs],
> +		DRM_DEBUG( "ring rptr: offset=3D0x%08lx handle=3D0x%08lx\n",
> +			   (unsigned long) entry->busaddr[page_ofs],
>  			   entry->handle + tmp_ofs );
>  	}

Looks good to me, just committed it to the DRI CVS trunk. Thanks.


--=20
Earthling Michel D=E4nzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=3Ddaenzer



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
