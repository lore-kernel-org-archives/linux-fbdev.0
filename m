From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 30 Sep 2015 07:55:05 +0000
Subject: Re: [PATCH v2 1/2] fb_ddc: Allow I2C adapters without SCL read capability
Message-Id: <560B9559.6000807@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="uneh77gHfsv3mFkvtG9RWTch0NfA0sOk3"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1443132854-31786-1-git-send-email-linux@rainbow-software.org>
In-Reply-To: <1443132854-31786-1-git-send-email-linux@rainbow-software.org>
To: Ondrej Zary <linux@rainbow-software.org>, Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

--uneh77gHfsv3mFkvtG9RWTch0NfA0sOk3
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 25/09/15 01:14, Ondrej Zary wrote:
> i2c-algo-bit allows I2C adapters without SCL read capability to work
> but fb_ddc_read fails to work on them.
>=20
> Fix fb_ddc_read to work with I2C adapters not capable of reading SCL.
>=20
> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
> ---
>  drivers/video/fbdev/core/fb_ddc.c |   28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)

Thanks, queued this and the 2/2 patch for 4.4.

 Tomi


--uneh77gHfsv3mFkvtG9RWTch0NfA0sOk3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWC5VZAAoJEPo9qoy8lh71XQMP+gM/wRUEsNGlXaHjPCP5b+Ls
9vFi9dut/DoqgRiOIKNenaAw4lF+6gPxjwGcF6L/FriAiLpUxt5upL9HoN3V0Uix
nQ0M9g6N+jsAdENUF2uiVAydCe6CHIT8baUIAvVMykz4nzTCB73mLF9oMsevLVMp
NXSxL9DEriU8PLNfv+qHA8us2dtswrHhNyyZAgqBnO8mXcY4hNxr7MjD9bpxzOVK
q078f+5C2Nyhpkm6M0+hZn85T+7PZ6xESfZeuFmjBpACcw3JHR3rNC7Wmo9ckAMm
+ac83fMps9dhgdlMLwVvkiuKQWgLmeFNQdqychVSIjy9DN16VkEPHBNkOop5AViM
clNXdT6obYsi7HEs46wJa5pNBv52Yc1iLBXiAlSoSkWAMN9KkPa2wZ7cxfUMMRLH
UuDU7XsJIb0uNo3+OiZCoU9z7fUPPQ03UdNnji0I0D/4Axe3GY+OOab0D8ONC9Ov
beZHhkkEj8xV2DtpImHnUO2NSMGojqGxTptul0lsLQ9uDTLmEuaT4ljUk0yoq9bO
s/eOSa+dKLTnhshFeS1tdQ4e0yhf869k71z5iJDihCjP/yBB/vOgYYfpMJ2VgwN1
xxsiQwYrBOdZczSiyEMGYUIyrgoqyrHa4v/4aQa7VsXpecEcq5KtfCKSrhYrIpxv
YsD4xF4jOcXdCWqudtPG
=JwiO
-----END PGP SIGNATURE-----

--uneh77gHfsv3mFkvtG9RWTch0NfA0sOk3--
