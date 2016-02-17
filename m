From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 17 Feb 2016 09:09:46 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <56C438DA.5040109@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="XMA1s3g8sIQhNqkJU1UDHC3AGmhIVCrGB"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org

--XMA1s3g8sIQhNqkJU1UDHC3AGmhIVCrGB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/02/16 16:04, Linus Walleij wrote:
> This moves the versatile CLCD configuration to the device tree by:
>=20
> - Deleting the board file set-up of CLCD displays and quirks,
>   instead relying on the driver to handle this. The driver will
>   attempt to auto-detect (like the board file did) and match to
>   a corresponding panel in the device tree.
>=20
> - Defining all auto-detectable panels in the device tree for the
>   versatile-ab, defaulting the first one to VGA. The right
>   panel will be selected at panel initialization, and should
>   just work for the IB1 daughterboard panels, like EPSON.
>=20
> - Creating a special superset DTS file for the IB2 daughterboard
>   (phone form-factor) equipped Versatile, overriding the default VGA
>   display with the Sanyo 2.5" portrait display definitions, so that
>   the IB2-equipped Versatile can be used with this. This follows
>   the pattern of how we define the Versatile PB as a superset of
>   Versatile AB.
>=20
> Tested on Versatile AB with just VGA with the default device tree,
> and with the IB2 daughterboard with the custom IB2 device tree.
> Tested to shunt in XVGA by modifying the device tree and this works
> too. Also tested on QEMU for Versatile in both VGA and Sanyo 2.5"
> mode. I don't have the IB1 daughterboard and its add-on displays,
> but it should work as long as the detection mechanism and device
> tree parameters are sound.

Well... I don't like this very much. The .dts should contain
descriptions for hardware that is connected. Have you looked at DT
overlays? I think they would be a much better match for this.

What's the SYS_CLCD register? An EEPROM or such, programmed when the
board is manufactured? Is the panel meant to be switchable by the user,
possibly to a panel that's not "standard"?

 Tomi


--XMA1s3g8sIQhNqkJU1UDHC3AGmhIVCrGB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWxDjaAAoJEPo9qoy8lh71xGQP/3erfG7GTEC9GNL+pUMbMO/u
UnnAdld8Za5bE5ocwTSzoMrC3VhF1ZjWOM/Bj82YdE0acI/mqPbQBSULocNiVuv4
O5S42Fehduc4u4Q0R5wwm4anv/aZwZTOAEEYH98QRpwoOSNCfZ4nwjjhaAlNRkpo
t+mYQGFFnLX9GgHiEFut/t7raD5yo1+fPlbL3KLHiQg272m7lYkZMK2Ebwjpg9Th
MMUuMqw7ELu79dswZc7xUrEUmXC9sGTrd1SPmdjsUnrl5cVkkX7oKVV38sp85PME
0XJDDsGp2LDt9NX7PDzkBIO30BrD2tJqmD9t5bgBbYHyB2E75WO8jvkObZFnvvxp
hnzdABe+zlG8EP1sHhK+zOI8v2bgBES9z+DxaWtZZkSbhMO//B1pl/7GGK5kgfk6
q+sfsMWvNxu2tPF3GBoXkisn4lOZGabnVHkdVCQPTXS6wulPoIuAYWWN2KH7VuSz
BRyr8pQkR/JMVeAb+Y5bs35+TGLu1XcNkfqbI5gTxnULRFn79JOpZtMy2HyDwv4C
D3+D56mK/ZhinudLDUfysWuP/5ThF9tguw1+S3JnWnoOBhUxWU/NODOyKewDmem4
+LTpf85iDJDnC8AzCv0Dm5YLbzcEvsdPjS9XMdo+7ehnEVhHfNUAJSyOCZWg+UX8
dcv5U9JdttDKN7W+PFNZ
=Ngtt
-----END PGP SIGNATURE-----

--XMA1s3g8sIQhNqkJU1UDHC3AGmhIVCrGB--
