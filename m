From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: Re: FBDEV 2.6.0-test7 updates.
Date: Thu, 16 Oct 2003 02:24:56 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1066263895.6065.143.camel@thor.asgaard.local>
References: <Pine.LNX.4.44.0310152345210.13660-100000@phoenix.infradead.org>
	 <20031015162056.018737f1.akpm@osdl.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A9vxg-0004JK-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 15 Oct 2003 17:25:52 -0700
Received: from netline-mail1.netline.ch ([195.141.226.27])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A9vxg-0007dA-4c
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 15 Oct 2003 17:25:52 -0700
In-Reply-To: <20031015162056.018737f1.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: James Simmons <jsimmons@infradead.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Thu, 2003-10-16 at 01:20, Andrew Morton wrote:
>=20
> This one comes up again and again.  What should we do with it?
>=20
>=20
> --- 25/drivers/video/radeonfb.c~radeonfb-line_length-fix	2003-10-05 09:17=
:58.000000000 -0700
> +++ 25-akpm/drivers/video/radeonfb.c	2003-10-05 09:17:58.000000000 -0700
> @@ -2090,7 +2090,7 @@ static int radeonfb_set_par (struct fb_i
>  =09
>  	}
>  	/* Update fix */
> -        info->fix.line_length =3D rinfo->pitch*64;
> +        info->fix.line_length =3D mode->xres_virtual*(mode->bits_per_pix=
el/8);
>          info->fix.visual =3D rinfo->depth =3D=3D 8 ? FB_VISUAL_PSEUDOCOL=
OR : FB_VISUAL_DIRECTCOLOR;
> =20
>  #ifdef CONFIG_BOOTX_TEXT

I'd say drop it, as it's wrong. :) It's like this in Ben's tree:

	/* Update fix */
	if (accel)
        	info->fix.line_length =3D rinfo->pitch*64;
        else
		info->fix.line_length =3D mode->xres_virtual * ((mode->bits_per_pixel +
1) / 8);


--=20
Earthling Michel D=C3=A4nzer   \  Debian (powerpc), XFree86 and DRI develop=
er
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=3Ddaenzer



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
