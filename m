From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 13 Sep 2012 10:54:07 +0000
Subject: Re: [PATCH v2] of: Add videomode helper
Message-Id: <1347533647.3014.10.camel@deskari>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-LCiAFC0F/sJEdrIFKl22"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1341388595-30672-1-git-send-email-s.hauer@pengutronix.de>
In-Reply-To: <1341388595-30672-1-git-send-email-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org


--=-LCiAFC0F/sJEdrIFKl22
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-07-04 at 09:56 +0200, Sascha Hauer wrote:
> This patch adds a helper function for parsing videomodes from the devicet=
ree.
> The videomode can be either converted to a struct drm_display_mode or a
> struct fb_videomode.

I have more or less the same generic comment for this as for the power
sequences series discussed: this would add panel specific information
into DT data, instead of the driver handling it. But, as also discussed
in the thread, there are differing opinions on which way is better.

> +int of_get_video_mode(struct device_node *np, struct drm_display_mode *d=
mode,
> +		struct fb_videomode *fbmode);

=46rom caller's point of view I think it'd make more sense to have
separate functions to get drm mode or fb mode. I don't think there's a
case where the caller would want both.

Then again, even better would be to have a common video mode struct used
by both fb and drm... But I think that's been on the todo list of
Laurent for a long time already =3D).

 Tomi


--=-LCiAFC0F/sJEdrIFKl22
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQUbtPAAoJEPo9qoy8lh71OSUP/R8z1o0SEDVMiVqlGS25yE09
V1SkOmMlJDYQmDunTVeQwdcSh8RTGFsGvJcjpAtd+8jkAPXB46OMOJdbN39vWJYb
DF/b/Up8a0ppAXtU4QOQHNSAb0U8VFtyDDRj+8bMZXKkQb25s3nfrVQnAVJyBeLR
z6Ngo7NXmgaeQuo6Qlo0F8P5mf2PwtWZvfCU59zcjMPq9A2kw/mGVA1dILRIAqDL
r7Xpk11HxLhE41vfrTFQ5e+uEbGo3q+u0Fs+ICue5YlCDRMUsBVj5ia7WpyXmyW4
oC9cF96jYk/g27VfHZkaxGGXLqmtljGVE5QmcQKqf832cU+VHlxhOvplZ30cZHq1
g+m8LdDwemovaUtlMaKwpGB8ftJk3wxEbQdbuDUqS4lB9dnUGCWJDPk7iLBhVzXe
QolYH/FCpbQjY3mCnhTBsxspJvWEIFEoSgXVzaMn84EZ698lFKVqLEH3C322q7is
0cBqdU5VBjujaaMFN4cuUqSXWECURKlmPi+umBmx8a1uGuTKtN1t7mT4jQHoK6If
jC9byNo8qYqAx+SEN9AlhBXyretnctCGAylhCbgDCS4p4uQHPcrUAuufiqUX+fN5
KNPYf7bFhslSBrL9/ilCw3hfo0dDGbiz0pk842HUjsVDhwTfCJSyYTDdpgMTzE+q
0su3GSMUsfbOAVViNcV+
=CmDx
-----END PGP SIGNATURE-----

--=-LCiAFC0F/sJEdrIFKl22--

