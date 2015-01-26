From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 26 Jan 2015 12:03:19 +0000
Subject: Re: [PATCH 2/3 v2] hyperv: hyperv_fb.c: match wait_for_completion_timeout return type
Message-Id: <54C62D07.3040603@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="odijAUILueCiUeNxiUj4WCLoGjdwm3Mug"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1422197222-7967-1-git-send-email-der.herr@hofr.at>
In-Reply-To: <1422197222-7967-1-git-send-email-der.herr@hofr.at>
To: Nicholas Mc Guire <der.herr@hofr.at>, "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, devel@linuxdriverproject.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--odijAUILueCiUeNxiUj4WCLoGjdwm3Mug
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 25/01/15 16:47, Nicholas Mc Guire wrote:
> Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
> ---
>=20
> v2: fixed subject line
>=20
> The return type of wait_for_completion_timeout is unsigned long not
> int. This patch fixes up the declarations only.
>=20
> Patch was compile tested only for x86_64_defconfig + CONFIG_X86_VSMP=3D=
y
> CONFIG_HYPERV=3Dm, CONFIG_FB_HYPERV=3Dm

Why didn't you set the text above as the patch description (which is
empty at the moment)?

 Tomi



--odijAUILueCiUeNxiUj4WCLoGjdwm3Mug
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUxi0HAAoJEPo9qoy8lh71+A8QAKivgkPBhQp0gN1eItt1ceuc
+cxRNK+onip8UKx7ZCDKhz0q8H0dsZUdiXxnBa6RPYIGUBYSsLlP5y2jPrGotMok
+O8zKcSTQuHVL9fkv4c7GQ/T9DmKycX2k/aNWSWGy2TbESqbIc5nPCVI5NoZu3FK
K5kQEySW+keknb56ddCPt/2m8g+6316LQElgaW1eluIzGSeWKJKoL29TKCVY+oH+
vbKqe29CqCdldt+/u2AFSvfYSMELsBs6WQtLX+mIds7gre4e8vLgaeUsQ6kss2lK
Lyu0Y9+edN+66btMdOu3UkRgVBVUKKSqlEEgWVSHOA0DNpKRxaAg+oqw0nmjSTNp
zjJCyu0tkAV5BE7Pclc9OKr4Q54go9E2R2+cvKNzwTtzdvWM77LLYXeHluT+VfMx
Elux1nO/GoZWiV4b2i9fol1rqxGOZxo6jlAZ38aSiwgLWMSqRbzzfa9E5QwBlRl+
XI0XMgsvR6FBevUtFNV+tirMGBfPnXQbiq8Lbpf4tlHF4Rqlj+e2JWOHlq7b2pUE
ysXzL3FCzU4Ns8FLFk5U3FRgWTO9hb8e8j6Kj6+oogUsNjdJ0W1IHctZgJE6z3uz
mTKJHM7QtIXBmwZjxSmYixISSd2qwraGZnljjQqiSa3ipdd157sci4zYdR8UEFaV
9IxQncWA1c4BHWpR9OfT
=H242
-----END PGP SIGNATURE-----

--odijAUILueCiUeNxiUj4WCLoGjdwm3Mug--
