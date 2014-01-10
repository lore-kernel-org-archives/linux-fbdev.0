From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 10 Jan 2014 12:37:40 +0000
Subject: Re: [PATCHv5][ 1/5] fbdev: Add the lacking FB_SYNC_* for matching the DISPLAY_FLAGS_*
Message-Id: <52CFE994.8070701@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="54oGju9Ce64a7esMqsIwnSFc4gAgWX6n7"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1383915693-9422-1-git-send-email-denis@eukrea.com>
In-Reply-To: <1383915693-9422-1-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org

--54oGju9Ce64a7esMqsIwnSFc4gAgWX6n7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2013-11-08 15:01, Denis Carikli wrote:
> Without that fix, drivers using the fb_videomode_from_videomode
>   function will not be able to get certain information because
>   some DISPLAY_FLAGS_* have no corresponding FB_SYNC_*.

> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index ffac70a..cf2ad5d 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -45,6 +45,9 @@ struct device_node;
>  #define FB_SIGNAL_SYNC_ON_GREEN	8
>  #define FB_SIGNAL_SERRATION_ON	16
> =20
> +#define FB_SYNC_DE_HIGH_ACT     64      /* data enable active high fla=
g */
> +#define FB_SYNC_PIXDAT_HIGH_ACT 128     /* drive data on positive edge=
 */
> +
>  #define FB_MISC_PRIM_COLOR	1
>  #define FB_MISC_1ST_DETAIL	2	/* First Detailed Timing is preferred */
>  struct fb_chroma {

I don't think this is better than the previous version where
FB_SYNC_DE_HIGH_ACT and FB_SYNC_PIXDAT_HIGH_ACT were in
include/uapi/linux/fb.h. Now those flag defines are not visible to the
userspace, but the actual flags are still visible from the var->sync fiel=
d.

It's true what Russell replied to the previous version, that the
userspace has no idea how to handle those new flags. But then again, for
LCDs, the userspace has no idea how to handle, say, hsync polarity either=
=2E

In any case, splitting the FB_SYNC_ defines into uapi and
kernel-internal header files, but still giving the kernel-internal
values to userspace is surely wrong.

 Tomi



--54oGju9Ce64a7esMqsIwnSFc4gAgWX6n7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSz+mUAAoJEPo9qoy8lh71M9AQAKpDgPFbRtA+/fDwoxJLE8hy
n3oH+yhCoBb70py93+YWidj6hnMBiFO6+feB9/Cstyo9Lq5t9MJR4FlRlGACZ1ux
0R5SSTivUJb4wbepc58LhyuJWSECEwsqnkA104ZTTRSnL4pkosd7q+hljid7qs7+
b2KCej0MRzL7rbt6QDu39sT32T108QL2mcqkgmW7lrG+X1968B998p+lt4VZ04vC
P2qzmXTot/5JTNDwUTDDHKzODym5+X8MgzdBl0pfdA+bN0O7O8rogWxwv27nyoNi
T0Ac2eWmdegt2wHvmby8rQAn0F3M8YwcjHAKtRu7+IylsVqLIRFlno2njbYs5Pf0
OSMWp8iU/3OBIT1gCvRu9lWILWT7vvV/PpIZS2okD+CxPDlIrxqc7XSQKqkCiDeS
2gn1vTJybJwe3aQsh38nQExuM1dYATyoA4O2dlfMRkaJSMVLN0zefqWj5pFgk8sQ
sPo2t5pfJolmFindON8aem3xRXQk+DGfkS4Ee9AVrDbGqI7KSNC6pxYNhNIzk2Oo
nnnV8dMaEG8Y6No3xh/jY/FqSvl/24xvnWM7T7u9yXMXWjjX7caORDcrMoOTQAT7
6yU1VberKhzrx9fkPxRCna9qyCJINI2abOc0iDJ7XqyaqnZFJ6upTnT+Oioe9OC1
X0vWpqlwVHlv2VpQrXoQ
=3Fm9
-----END PGP SIGNATURE-----

--54oGju9Ce64a7esMqsIwnSFc4gAgWX6n7--
