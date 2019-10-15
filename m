From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Tue, 15 Oct 2019 12:46:39 +0000
Subject: Re: [PATCH v2 14/15] staging/mgakms: Import matroxfb driver source code
Message-Id: <a1e6a1a8-c6b3-26fb-7d96-480a5a7caf65@suse.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="DxI2wuFLtAZwXF1Npl9I8uthO5WLEGxjr"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191014140416.28517-1-tzimmermann@suse.de>
 <20191014140416.28517-15-tzimmermann@suse.de> <20191015114843.GB4104@sci.fi>
In-Reply-To: <20191015114843.GB4104@sci.fi>
To: airlied@linux.ie, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, sean@poorly.run, b.zolnierkie@samsung.com, ajax@redhat.com, ville.syrjala@linux.intel.com, malat@debian.org, michel@daenzer.net, corbet@lwn.net, gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DxI2wuFLtAZwXF1Npl9I8uthO5WLEGxjr
Content-Type: multipart/mixed; boundary="or6SuiZEUMjCLZSYl83jywjClSUgfMvcX";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: airlied@linux.ie, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, sean@poorly.run, b.zolnierkie@samsung.com,
 ajax@redhat.com, ville.syrjala@linux.intel.com, malat@debian.org,
 michel@daenzer.net, corbet@lwn.net, gregkh@linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Message-ID: <a1e6a1a8-c6b3-26fb-7d96-480a5a7caf65@suse.de>
Subject: Re: [PATCH v2 14/15] staging/mgakms: Import matroxfb driver source
 code
References: <20191014140416.28517-1-tzimmermann@suse.de>
 <20191014140416.28517-15-tzimmermann@suse.de> <20191015114843.GB4104@sci.fi>
In-Reply-To: <20191015114843.GB4104@sci.fi>

--or6SuiZEUMjCLZSYl83jywjClSUgfMvcX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 15.10.19 um 13:48 schrieb Ville Syrj=C3=A4l=C3=A4:
> On Mon, Oct 14, 2019 at 04:04:15PM +0200, Thomas Zimmermann wrote:
>> Only code is being copied, no functional changes are made.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>  drivers/staging/mgakms/g450_pll.c         |  539 +++++a
>=20
> ...
>=20
> Personally I would start from scratch. In fact some years (*cough*
> decade) ago I did just that and started writing a new driver for
> matrox stuff. Unfortunately I ran out of steam after figuring out
> most of the interesting hardware quirks and whatnot, so I never
> finished it. The end result is that it still runs in userspace
> but kinda looks like a kernel driver if you squint a bit.
>=20
> Anyways, I just slapped a MIT license on it  dumped the whole
> thing here:
> https://gitlab.com/syrjala/mga
> The development history was, shall we say, not really useful
> so I just squashed it.
>=20
> You, or someone else, might find it interesting. I think in
> terms of hardware support it's a superset of any other driver,
> apart from the blob.
>=20

Just to make this clear: I do not intend to port every single fbdev
driver to DRM. :)

I did, however, began to convert that Matrox driver. First, to see if
the approach does work in general; and because matroxfb is one of the
more complex drivers. If it can be converted, any other driver should be
convertible as well. I split up the driver code by HW generation and can
now refactor each generation on its own. I expect to end up with several
duplicated functions, which can be re-merged.

Maybe our repo can be helpful. Thanks for the link.

Best regards
Thomas

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--or6SuiZEUMjCLZSYl83jywjClSUgfMvcX--

--DxI2wuFLtAZwXF1Npl9I8uthO5WLEGxjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl2lv7AACgkQaA3BHVML
eiPwZwf+IMs4lQgb5EFMtlul00cQVEgRs/BG6p8f07qlJYu3E2SZsdIGQhXVPd9O
9x93JT+l1oh00VhSlRy50+7NJnGVLz7D+H1iO33I+N/qW/4tZaJxe9MpTR0EGTl/
mEJUmOg8HAeOa1DEMAgHzVB342Wi/A06kBdHmfFORhCvTA2/fkXmGrJDik7oieb9
Ck7q0nDpF65NkPedVLasvT/uM9hrV3wvEPSAy9Cvyr8zLpUFA7iOcZ4sI73Hyomk
4pLY/6s5cEwii81xuFLYm7Z06ZohPpEoFkxVcYR8ViegOpbVFWFw6MlnIpjM1Hft
/vmm4OpfYO/r/7H3XyJULqIlpA5iAw==
=UdgA
-----END PGP SIGNATURE-----

--DxI2wuFLtAZwXF1Npl9I8uthO5WLEGxjr--
