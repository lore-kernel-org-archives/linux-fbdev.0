From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 14 Nov 2014 14:24:18 +0000
Subject: Re: [PATCH v5 1/5] dt-bindings: simplefb: Specify node location and handoff related properties
Message-Id: <54661092.6020907@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="OMFXBaQ0lXJDCAIEqDUTuukGgkLNpVGHF"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415962996-31712-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1415962996-31712-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org

--OMFXBaQ0lXJDCAIEqDUTuukGgkLNpVGHF
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 14/11/14 13:03, Hans de Goede wrote:
> Since simplefb nodes do not relate directly to hw typically they have b=
een
> placed in the root of the devicetree. As the represent runtime informat=
ion
> having them as sub-nodes of /chosen is more logical, specify this.
>=20
> Also specify when to set the chosen stdout-path property to a simplefb =
node.
>=20
> For reliable handover to a hardware specific driver, that driver needs =
to
> know which simplefb to unregister when taking over, specify how the hw =
driver
> can find the matching simplefb node.
>=20
> Last add some advice on how to fill and use simplefb nodes from a firmw=
are
> pov.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Ok, so I have pushed this and the other simplefb series to fbdev for-next=
=2E

I can still refresh the whole series if need be, but if possible I'd
rather take any new changes as patches on top of the current ones.

 Tomi



--OMFXBaQ0lXJDCAIEqDUTuukGgkLNpVGHF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZhCSAAoJEPo9qoy8lh71EHoQAKuINZQjILEupv3NNuPOS+57
Z+c1eISYLItqiNExsMJPVunhheLOhsn8mm7F31sXHDFQXFRHCol5iPvtv7woo7Nq
ET5E40nf0ES+hGUJyygGcFpKgM6JssQj4wW+JYC84L1W1XgcKRYaYGN7cKFgZfkN
Ygq7y7LI1fEvVr/J/b2JhgP07vFjFHOlewWLvP81AjHe8iwopjI1rtsyv/3Dqe3T
E4J1mPnoLHteVRKlLubU3VjX2EU+2+Fnj5yW1CGWMo3++L03yUkgaE616DNpcMxj
Hjzmwcfhx1BnRBaxCJT2ly96voizJTUE3khIFvNal6Dbg3T/LBrnEZYY4kAS1BZA
JcKbDQii6MufYxrxVwSIJedL1H0NV9NnhcZLFKWhvMNBjIllGgMKntye3p2MpwPq
3afKYELgyR7uDB8Spqq/7gwN+3HSAKXbr/0q/h78UDCEbEZVvgAKIhru+dOZXx4g
y5epcVSbyk9Mw17ryN6MYDJfGqYSRoD4RmUvZ0ipdGgPLc5Rw+pn3XcxaWVrD1la
kA5SYOFx4P+dDEO0Cg5Ao3XlNFASAzX5UCft6MKjcW26hlUpyd3JAzlRw/g17OVz
62Y5McFsWD+FoUxu2tQ/RRyoWS665belw47Sd4su9GSf0jxatI5SMPr6gNIQ90tQ
LZISJwf5a7Vk+fZ3VZGB
=bf8y
-----END PGP SIGNATURE-----

--OMFXBaQ0lXJDCAIEqDUTuukGgkLNpVGHF--
