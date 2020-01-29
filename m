From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Wed, 29 Jan 2020 07:20:38 +0000
Subject: Re: [PATCH] matroxfb: add Matrox MGA-G200eW board support
Message-Id: <b667c38a-381e-3b32-3050-f35fcfe2dfcb@suse.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="3gezrqnn607yPBbay9tsQHGpVxxVVhmKm"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200125195506.GA16638@brightrain.aerifal.cx>
 <1466259e-efe7-df52-c05b-80042628d577@suse.de>
 <20200128185819.GG30412@brightrain.aerifal.cx>
In-Reply-To: <20200128185819.GG30412@brightrain.aerifal.cx>
To: Rich Felker <dalias@libc.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3gezrqnn607yPBbay9tsQHGpVxxVVhmKm
Content-Type: multipart/mixed; boundary="jiHI8bmAKGzPRvPZHeFhvF89VkNz8nEUl";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Rich Felker <dalias@libc.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>
Message-ID: <b667c38a-381e-3b32-3050-f35fcfe2dfcb@suse.de>
Subject: Re: [PATCH] matroxfb: add Matrox MGA-G200eW board support
References: <20200125195506.GA16638@brightrain.aerifal.cx>
 <1466259e-efe7-df52-c05b-80042628d577@suse.de>
 <20200128185819.GG30412@brightrain.aerifal.cx>
In-Reply-To: <20200128185819.GG30412@brightrain.aerifal.cx>

--jiHI8bmAKGzPRvPZHeFhvF89VkNz8nEUl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 28.01.20 um 19:58 schrieb Rich Felker:
> On Mon, Jan 27, 2020 at 08:36:07AM +0100, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 25.01.20 um 20:55 schrieb Rich Felker:
>>> Signed-off-by: Rich Felker <dalias@libc.org>
>>> --
>>> I've had this lying around a while and figure I should send it
>>> upsteam; it's needed to support the onboard video on my Spectre-free
>>> Atom S1260 server board.
>>
>> This HW is supported by mgag200, which is maintained. Can't you use th=
at?
>=20
> Perhaps; I wasn't aware it existed. I'll give it a try. It still might
> be nice to apply my patch though since the matroxfb driver works with
> it and only fails to support it because of not knowing the device id.

Well, I have no say about applying your patch. You can ping me however,
if mgag200 doesn't work for you.

Best regards
Thomas

>=20
> Rich
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--jiHI8bmAKGzPRvPZHeFhvF89VkNz8nEUl--

--3gezrqnn607yPBbay9tsQHGpVxxVVhmKm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl4xMkoACgkQaA3BHVML
eiO5kggAvRGcA7e/xtccGdTsgQhlq4Wf9Ms0D/DgpOjK0at6Q4iK+nwAeui3fb4A
Jo8iqTqzm6LOoH+kTknTIXMlFnkf06t7canfBOv0jqkM82L1AEdp28NlXMM9AuTk
/TngvH4q7N/XRhjNhbav1maqKVaQR5/UhwbQGbJsaX1MCOLmyfvjIRMXsczdoxBh
UAPLVgjdhvXZPj/lYTqPRTJSaOTK0EY44Qv3Ywr0oaUdOaRiqK3PLbwU9tXuQ4PS
Uhfcu3DQQ1cmGuZPUG9ben0HMeHZU1oqYMvA/tPMjP4SX6nulSsyYNkyrXf8e3xT
g55Uij0uK8FVRlq3x12ftXLXDsnRNA==
=vbNs
-----END PGP SIGNATURE-----

--3gezrqnn607yPBbay9tsQHGpVxxVVhmKm--
