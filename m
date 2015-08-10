From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 10 Aug 2015 09:19:45 +0000
Subject: Re: [PATCH] fbdev: select versatile helpers for the integrator
Message-Id: <55C86CB1.2070805@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="sojpJoRk3NEvFSlOGPVQwE86PmxFqDwgo"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438090272-26266-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1438090272-26266-1-git-send-email-linus.walleij@linaro.org>
To: linux-fbdev@vger.kernel.org

--sojpJoRk3NEvFSlOGPVQwE86PmxFqDwgo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 10/08/15 12:03, Linus Walleij wrote:
> On Tue, Jul 28, 2015 at 3:31 PM, Linus Walleij <linus.walleij@linaro.or=
g> wrote:
>=20
>> Commit 11c32d7b6274cb0f554943d65bd4a126c4a86dcd
>> "video: move Versatile CLCD helpers" missed the fact
>> that the Integrator/CP is also using the helper, and
>> as a result the platform got only stubs and no graphics.
>> Add this as a default selection to Kconfig so we have
>> graphics again.
>>
>> Fixes: 11c32d7b6274 (video: move Versatile CLCD helpers)
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> Ping on this.
>=20
> Shall I take this into ARM SoC instead?

Sorry, I still haven't gotten into dealing with fbdev related mails
after my vacation...

This is needed for 4.2, right? I can pick this up.

 Tomi


--sojpJoRk3NEvFSlOGPVQwE86PmxFqDwgo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVyGyxAAoJEPo9qoy8lh712m8P/jGnF+lB8exxa87ZMO85jfuj
9rG2mGEJ3MBNsG5GDR876F8/RS2Lxin4JR9jYH351vbVdSf/CopsZDOx06i0Km/d
osd7ZB/N5Q9Lm3RizVl6+s+BuLPRtWPWkkzMBfDXgY6R05n32pH+i9VRLz+Ry/N1
WQGkI+KvXoZB25GW0pNpjgwfEyQUaIZcjmMjiDKRMHjE5tClOICTUC+QOJ5gt01W
L703/Wya7iSdWMvZ3L3sVHhSTDj7XTGdKE9EwNcpEAFQTCLZAcLu0yR56fPHFb0f
cpi/KfRfYiJac81c8ZAnpEGnv/pUKG/lZkYVx4Fh4HuILL2DR6KIQIPZ7ffSao1+
HEQucER1tf3PbfNsmDKrS7U4IId82cIvj/h96fxa4B9/fhNswjokI5Mkzb9GLBrW
J60iotdyYnO6jM1Ea7mEtKLjura6qwscwcilwoQcppPpb0/kcAXYHOmQ+Gxw9Cex
dQXGfV7uDRqnwXUCKoEJnIris7hzqyjYar2onBT11ZSDUX+byqKA414snfchVzrt
IkAdrINeUCVTgaOuDuh7cCdE97yM1eYg2uL1eq6ZSp5mMaZMVfbK0chT5wOk/mTG
ETo+/9Vb5E9+CwALKzvoRFQkt045N+ijWj9dO6xzIy06ffEo9vKS7n+1h3R5hw+9
XZesvVlsY6oz6ukRd4BQ
=i3DO
-----END PGP SIGNATURE-----

--sojpJoRk3NEvFSlOGPVQwE86PmxFqDwgo--
