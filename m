From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 13 Nov 2014 14:28:54 +0000
Subject: Re: [PATCH v3 1/4] dt-bindings: simplefb: Specify node location and handoff related properties
Message-Id: <5464C026.7030300@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="56rDmCkloI4VERVWVsFrTc6rHmuLeesVt"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415885645-24613-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1415885645-24613-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org

--56rDmCkloI4VERVWVsFrTc6rHmuLeesVt
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 13/11/14 15:34, Hans de Goede wrote:

> +chosen {
> +	framebuffer0: framebuffer@5fc00000 {
>  		compatible =3D "simple-framebuffer";
> -		reg =3D <0x1d385000 (1600 * 1200 * 2)>;
> +		reg =3D <0x5fc00000 (4096 * 1024)>;

Was there a reason for this change? The former version seems much more
obvious to me, especially as this is an example.

 Tomi



--56rDmCkloI4VERVWVsFrTc6rHmuLeesVt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZMAmAAoJEPo9qoy8lh71AuMQAKXAoN/xZBhAG+6Off4pU5R2
UFs2srAd7ntfdh28uZcr3cKJbKqp3IxaUnRuzhVDGUenx1AIQpzEvh6pKsUK/wJL
BrMiRrsQbSDHSzFUkFQjsZzESbB8pi7FWQmhux4V3wi5qcN6sFLJ8pG1O3JLjr1g
zIBayFyo7Sjaczm4jAkFYtuJVbUirJfr/aeUsI65IYUqpBROIeCyOa5ipau91LyP
HrJYpiCzqqs1XK2p9izltkSuhLFC2s+ncLVqwIVrdZ3KHE0oGDlRLmJ5EmBUfZyP
2BHwRU8L7v/EeVCFll7HDV+LCBI3s2di7KievtRYj77bDaM0B4o+aaE0ujur5MG4
pXxNKRv/ojuKYIVQ/0L4AF3g+c5tPp43fYwKZG+qYOR2bIHRPq54lB3Vvl4cyJfA
IEvQDfHqeA/eo1q4c6sFHmz5sgj4kgeMgFO544WHx+IdWO1M1m6na6YBubIqypQj
lNE5KaB2QRqdjrNe8h0UHag86mNB7XoKPUqhbv5GgGlr60GXee2iGPOuZAoxzkop
6JY6kFYqpnE4VPDqd1D//MgN1al3c8F2asXPx3mzlVvQoeOinIvBvg2sTMfuyZ7G
349HVXher+764b4aN4P7P6rerg5oHNqPLNrDMDAYi5IqfL7bZHj5Uv0zS1i0RXGP
CmcUMqMnGy46V+dVCYub
=YlU5
-----END PGP SIGNATURE-----

--56rDmCkloI4VERVWVsFrTc6rHmuLeesVt--
