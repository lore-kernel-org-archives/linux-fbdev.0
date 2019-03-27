From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Wed, 27 Mar 2019 07:55:03 +0000
Subject: Re: [PATCH 02/11] drm/fbdevdrm: Add fbdevdrm device
Message-Id: <a0697626-dc39-702e-3850-def8cbc71508@suse.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="paFeVHtrLByUiSRJfKXBdh74Y8epDVWwU"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190326091744.11542-1-tzimmermann@suse.de>
 <20190326091744.11542-3-tzimmermann@suse.de>
 <0d2e7dccd35523dd652a3d4af4b031f8d9ab8efd.camel@redhat.com>
In-Reply-To: <0d2e7dccd35523dd652a3d4af4b031f8d9ab8efd.camel@redhat.com>
To: Adam Jackson <ajax@redhat.com>, airlied@linux.ie, daniel@ffwll.ch, b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--paFeVHtrLByUiSRJfKXBdh74Y8epDVWwU
Content-Type: multipart/mixed; boundary="yfQL7CzY2iRGtaAgarb0YdADOo7kOnUmL";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Adam Jackson <ajax@redhat.com>, airlied@linux.ie, daniel@ffwll.ch,
 b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Message-ID: <a0697626-dc39-702e-3850-def8cbc71508@suse.de>
Subject: Re: [PATCH 02/11] drm/fbdevdrm: Add fbdevdrm device
References: <20190326091744.11542-1-tzimmermann@suse.de>
 <20190326091744.11542-3-tzimmermann@suse.de>
 <0d2e7dccd35523dd652a3d4af4b031f8d9ab8efd.camel@redhat.com>
In-Reply-To: <0d2e7dccd35523dd652a3d4af4b031f8d9ab8efd.camel@redhat.com>

--yfQL7CzY2iRGtaAgarb0YdADOo7kOnUmL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 26.03.19 um 17:03 schrieb Adam Jackson:
> On Tue, 2019-03-26 at 10:17 +0100, Thomas Zimmermann wrote:
>=20
>> +static bool is_generic_driver(const struct fb_info *fb_info)
>> +{
>> +	/* DRM porting note: We don't want to bind to vga16fb, vesafb, or an=
y
>> +	 * other generic fbdev driver. Usually, these drivers have limited
>> +	 * capabilitis. We only continue if the fix structure indicates a
>> +	 * hardware-specific drivers . This test will also sort out drivers
>> +	 * registered via DRM's fbdev emulation. If you're porting an fbdev
>> +	 * driver to DRM, you can remove this test. The module's PCI device
>> +	 * ids will contain this information.
>> +	 */
>> +	return !fb_info->fix.accel &&
>> +	       !!strcmp(fb_info->fix.id, "S3 Virge/DX");
>> +}
>=20
> This seems odd. s3fb sets fix.accel to NULL unconditionally AFAICT, not=

> sure why you're testing for that explicitly.

If accel is 0, it might be a generic driver. Hence, fbdevdrm ignored
s3fb, so I added the exception.


> I do have a question though: why _not_ support generic fbdev drivers?
> If I had that, and the ability to disable creation of /dev/fb*, I could=

> expose a consistent video device enumeration to userspace. As it stands=

> I have no reasonable way of knowing which fbdev and drm devices are
> pointed at the same hardware. If there were only drm devices...

Ignoring generic drivers seemed like the safe bet for now. I found that
vga16fb, vesafb, etc bind to hardware and later get replaced by
HW-specific drivers; DRM drivers with FB emulation should not be handled
by fbdevdrm. So for now, fbdevdrm ignores all this.

This all comes from using the event-reporting mechanism to hook into the
fbdev module. Daniel suggested to copy over some of the fbdev drivers
for porting, which would solve the problem.

Best regards
Thomas

>=20
> - ajax
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=C3=BCrnberg)


--yfQL7CzY2iRGtaAgarb0YdADOo7kOnUmL--

--paFeVHtrLByUiSRJfKXBdh74Y8epDVWwU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAlybLFsACgkQaA3BHVML
eiNPCAf9F15O/ld+3a1/23fhU7rJuVQeWsY+7MXgcwz7+pTgSVqB0WE4iqVS62et
udxhkttZIFOVRB5kKa9wR7lSF2nz2SXsHTtUq8Q/oipfJUTYhD8nCbdMCiTSPPDF
oGqgnkooESrQ+wnvPi1WIgHXCrY091DEB7BvvvVoxKVDOFqtisFCVcVHb6z7UoCV
Rh4sJBDUiBiTNnRWURdtgV2tvHrUW2hvVwKFKNoXh7Y9d1nx3u6JvZWkF8SZGrEa
DSRdbGqsbrokemDNIW2/t/xIK/eL1eani6bO4yZ6GJVhE2wFE5VgBwiKsFJoH82x
bqovp9eQkdTecKujXDmhcuGassbh5w==
=Crue
-----END PGP SIGNATURE-----

--paFeVHtrLByUiSRJfKXBdh74Y8epDVWwU--
