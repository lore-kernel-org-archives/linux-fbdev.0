From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 25 Nov 2014 13:38:02 +0000
Subject: Re: [PATCH v3 2/2] dt-bindings: simplefb-sunxi: Add sunxi simplefb extensions
Message-Id: <5474863A.5040801@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="stKCBNMHWKr9p33iMngmxajA5t3O6jPtS"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1416309051-26784-1-git-send-email-hdegoede@redhat.com>
 <1416309051-26784-3-git-send-email-hdegoede@redhat.com>
 <547476DA.2030004@ti.com> <54747B72.1050406@redhat.com>
 <54747DCF.9010502@ti.com> <5474824F.8080000@redhat.com>
In-Reply-To: <5474824F.8080000@redhat.com>
To: linux-arm-kernel@lists.infradead.org

--stKCBNMHWKr9p33iMngmxajA5t3O6jPtS
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 25/11/14 15:21, Hans de Goede wrote:

>> Shouldn't the compatible then be "allwinner,sunxi-simple-framebuffer",=

>> to differentiate from some other SoC Allwinner has or might create in
>> the future? That is, presuming you're confident enough that a single
>> compatible string covers all the current and forthcoming sunxi SoCs.
>=20
> This was discussed in an earlier thread, we (Ian Campbell, Grant and me=
)

Okay. Sorry for not having time at the moment to follow the discussions
properly. =3D)

> decided to settle on allwinner,simple-framebuffer to make it clear that=

> these are allwinner extensions to the standard simple-framebuffer bindi=
ngs,
> and that the node otherwise is simple-framebuffer compatible.
>=20
> We were afraid that e.g. sun4i-simple-framebuffer would signal that it
> is not a normal simple-framebuffer node, so we decided to go with just
> the allwinner, prefix to indicate that it uses allwinner specific
> extensions.

Wouldn't

compatible =3D "allwinner,sun4i-simple-framebuffer", "simple-framebuffer"=
;

tell that it's a simple-framebuffer, with allwinner's sun4i extensions?

I guess you can have just "allwinner,simple-framebuffer", and then if a
new Allwinner SoC has a totally different display controller, the
documentation would specify that this property is for that SoC, and this
another property is for that another SoC. But isn't the compatible
string what's supposed to use in cases like this?

And if the new SoC is not sunxi, but some totally other family, there's
need for a new compatible string anyway, as
"simple-framebuffer-sunxi.txt" is for sunxi only.

 Tomi



--stKCBNMHWKr9p33iMngmxajA5t3O6jPtS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUdIY6AAoJEPo9qoy8lh71Z8YQAKGw8qxcZtZ4TiTdSs8S10rZ
pDlzOiNkDO85WaRa0jeZNzJRSynndIJtM6SVJI5lVWbbF35GfzjHCNZviatzqlz3
Y8vF1PQ+iP7t4Ds3aekNpYW/XuBfBUkr/iCnv4qLXUK/1RHC8YCVjgp6LxXUWIey
aH1UY4yozuGgnOpIps4o2BEJ1qKFc35WqdTmW7Oa5oRfQW9qmrz0O5jBSoMnxY57
c4ftksk3d0qkw7av6PwTTyFo12SAp0mC37ozqCTMdgFJgHd0iZABojeywhgdmhxt
z/wFgUiK1yT+OxRYEE0kN6kTpoZExo+Fa30vPhm+PTIJ4QP4tWUcwD0zTooREQ1c
zdMYC7shalyuDZOK/rNedcWeYa4XgGTAxkYKO6/zTn29ZnAC41VUpbPwtUT1+G4D
pWlQZi0uqJ/MeaywxkP8cl2WSN+GPG8VfhrqreryxtcNaz7jSkuVSXkVZF1koJq9
4SxQjwCFaI9+FMYyW/uXitqyD2XPujRkmr7xVPktbd3W+yA4G/G1sd9PlHfubnFC
jW7gHvAjMmYuZIFwsrJwaH0+X7z9QX45w2etBq9335qVXMo9VUoY3px9lF82C+by
AUeluZZyDJ6XLp45WuHJS1fzs8ZgS4xMaQMLyYTG0sJBJnddUXMval1mGNZXP7wj
tRR7vA4VLD0dgI3JjODj
=6zqK
-----END PGP SIGNATURE-----

--stKCBNMHWKr9p33iMngmxajA5t3O6jPtS--
