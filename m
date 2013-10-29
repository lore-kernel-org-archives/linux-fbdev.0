From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 29 Oct 2013 10:35:11 +0000
Subject: Re: [PATCHv3][ 1/5] fbdev: Add the lacking FB_SYNC_* for matching the DISPLAY_FLAGS_*
Message-Id: <526F8F5F.6050905@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="M3RuJJDxIdkQLEu14hjOVaGFbiHXvFtdf"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382532229-32755-1-git-send-email-denis@eukrea.com>
In-Reply-To: <1382532229-32755-1-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org

--M3RuJJDxIdkQLEu14hjOVaGFbiHXvFtdf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 23/10/13 15:43, Denis Carikli wrote:
> Without that fix, drivers using the fb_videomode_from_videomode
>   function will not be able to get certain information because
>   some DISPLAY_FLAGS_* have no corresponding FB_SYNC_*.
>=20
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: devicetree@vger.kernel.org
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Eric B=C3=A9nard <eric@eukrea.com>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> ---
> ChangeLog v2->v3:
> - Added Jean-Christophe PLAGNIOL-VILLARD's ACK.
> ---
>  drivers/video/fbmon.c   |    4 ++++
>  include/uapi/linux/fb.h |    2 ++
>  2 files changed, 6 insertions(+)
>=20
> diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
> index 6103fa6..29a9ed0 100644
> --- a/drivers/video/fbmon.c
> +++ b/drivers/video/fbmon.c
> @@ -1402,6 +1402,10 @@ int fb_videomode_from_videomode(const struct vid=
eomode *vm,
>  		fbmode->sync |=3D FB_SYNC_HOR_HIGH_ACT;
>  	if (vm->flags & DISPLAY_FLAGS_VSYNC_HIGH)
>  		fbmode->sync |=3D FB_SYNC_VERT_HIGH_ACT;
> +	if (vm->flags & DISPLAY_FLAGS_DE_HIGH)
> +		fbmode->sync |=3D FB_SYNC_DE_HIGH_ACT;
> +	if (vm->flags & DISPLAY_FLAGS_PIXDATA_POSEDGE)
> +		fbmode->sync |=3D FB_SYNC_PIXDAT_HIGH_ACT;
>  	if (vm->flags & DISPLAY_FLAGS_INTERLACED)
>  		fbmode->vmode |=3D FB_VMODE_INTERLACED;
>  	if (vm->flags & DISPLAY_FLAGS_DOUBLESCAN)
> diff --git a/include/uapi/linux/fb.h b/include/uapi/linux/fb.h
> index fb795c3..30487df 100644
> --- a/include/uapi/linux/fb.h
> +++ b/include/uapi/linux/fb.h
> @@ -215,6 +215,8 @@ struct fb_bitfield {
>  					/* vtotal =3D 144d/288n/576i =3D> PAL  */
>  					/* vtotal =3D 121d/242n/484i =3D> NTSC */
>  #define FB_SYNC_ON_GREEN	32	/* sync on green */
> +#define FB_SYNC_DE_HIGH_ACT	64	/* data enable high active */
> +#define FB_SYNC_PIXDAT_HIGH_ACT	64	/* data enable high active */

This can't be right. You map both flags to value 64. And the comment is
the same for both.

 Tomi



--M3RuJJDxIdkQLEu14hjOVaGFbiHXvFtdf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSb49fAAoJEPo9qoy8lh71VC4P/0ETdY/WE415nLejHuDs1uaO
za4wJvKfmlVdHr4k6ySvM6/WDROGoHs9D2WYUjrYPSJ15LHJMwv3whwti50voNoK
g/MSz4npsI6XhisWtwl201L1thAEW8S0i8lCaKulcDRMLvPkCRFIvJhtB+ImFv+V
1uVJARnkfo8I4VE9dGMHvuPl5bJFykZox0ZgJthNlL32Hsf8OHvIGrT3I6oCKXaS
26p75ZYgGWiDWWCeirJzGAEp/NPZ+xfdeKdamdoXw4lwAIPQinb5uASv1DMBrO23
45Zr2Zchv8AC18pIucYKRj4kaZvOyCvduFzJRUNdKtD6+rio2VJpnqt0XHIeHsLb
CBtuwtr3M8ujVHkmyWQYqDJKRRxZ86gVFIAhbynFlGUaIgi4Mp7aNfuzeBMRimJF
7K5ZIFPLDTuG9DA0uaxoTic7CUJz5E7TPokeAJNRI/pvxTJQ1DiPlXqzl5ey35Uy
6bNd/2flo3kFHI3jZvLTHo66fjW130HgHK0RD3ztMs1tDXv3IPUnktnFzzsq9LNq
Va+hfCy7K7QRDZzXwJGk8ErKfnjn3ywMS/FEkgtsEZog1foJGcgQRd4fKs8sGnfr
0BDcEz9Dcc3AODjRoUgFSZyTRM9aVT0AGnP37zcapZhkFGcFtNxsOnCPIbSEeP4t
IYw4j2YFwFLH1wsmqF/A
=gBk9
-----END PGP SIGNATURE-----

--M3RuJJDxIdkQLEu14hjOVaGFbiHXvFtdf--
