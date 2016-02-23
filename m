From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 23 Feb 2016 09:58:17 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <56CC2D39.80909@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Xs9UdAbShFO41vQ0FeKFmscp0K0qhDBFh"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <CACRpkdbnLgVsrSAu87wxSwktK3ftJzbQLXjU8y65tq=9Ynxicw@mail.gmail.com>
In-Reply-To: <CACRpkdbnLgVsrSAu87wxSwktK3ftJzbQLXjU8y65tq=9Ynxicw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org

--Xs9UdAbShFO41vQ0FeKFmscp0K0qhDBFh
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

(cc'ing a few more people as this is going into generic direction)

On 23/02/16 11:08, Linus Walleij wrote:
> On Thu, Feb 4, 2016 at 3:04 PM, Linus Walleij <linus.walleij@linaro.org=
> wrote:
>=20
>> This moves the versatile CLCD configuration to the device tree by:
>=20
> As this Schr=C3=B6dinger's cat approach seems controversial, as well
> as the alternative to manipulate the DT in memory at run-time,
> I will respin the series without the full Versatile support, adding
> plug-in for the other ARM boards and and half-baked support
> for the Versatile supporting just VGA (like the other reference
> designs from ARM).
>=20
> The pluggable displays prove yet again to be a problem to the
> world, sigh.
>=20
> I will think of a better solution, if any, for this for v4.6, but will
> put forward something that handles the Nomadik and all the
> other ARM reference designs for now.

I had a chat with Tom Rini and Pantelis Antoniou yesterday.

Panto is about to send a new series for DT overlay management soon. I
haven't had time to test that yet, but what it would give us is that you
could build DT overlay binaries as "firmware" into the kernel image, and
thus the panel DT data would be there even before rootfs is mounted. The
DT overlays can be loaded from the rootfs or initramfs too, if it's not
critical to get the display up early.

I'm not quite sure how it works if, as in versatile display case, there
are multiple DT overlays of which one has to be enabled. I hope there's
support to choose which one to use via kernel cmdline or similar.

I would personally like it much more if the bootloader would either
compose a final dtb from DT fragments and pass it to the kernel, or
alternatively the bootloader would pass the base dtb image and a bunch
of DT overlays to the kernel, and the kernel would deal with the DT
overlays.

In any case, I think the firmware solution is a good step forward, and
will probably work fine for many users. Then again, I haven't tested it
yet so I don't know the details, and it's not in the mainline.

 Tomi


--Xs9UdAbShFO41vQ0FeKFmscp0K0qhDBFh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWzC05AAoJEPo9qoy8lh71k6sP/0quTHA0qMrL276Bd3ZGdnyy
K745QQiAj5OolPzkT96geajndpv9rdum/e59nIrsTH6/wKKss4/0CGQspzb3rknP
3FKd/t9QVcLdyEirEBgnSN8LyzhJoLav3Z22blnZ2qxWh212vFjs899NfTXEfNHx
p6Mbhtv4+Rf/BPsv5N3wyjR++FFyNs0ss9/0sij2X2iLvIgzmaSisq60EaBSzFPb
iRt2Z0N2+4qPN0DIv+ENd8wCXLVoenkWV+fmcq8FRrACaSZKjIwEJMZFkmp6THE/
pqzowIv7IyUlOHbyPmfKbTxxh0LekQm+y5lU2oYZK3VnKFCUHdH9X7nA+Cuh5EBk
kYM5x6qFejjf+Wi1k4+n+UoJqSx0iu+16Yw1VUPOmn9TMIXEg32iDvR/F59Oi44f
8bhWS0q9CbpQlJ7n8LMj2G9NphD8dgnsjYzfSblhHnZ8g3EL6M1whtPh5602Whve
olFsAP1vOPook0qWowtdFqjlII2gEDGNBZOMtq8n+z2EeXRd7GnvirBdx+HXs5qs
bhAr/ubBO9169ZJDxwYVA6ak+C68HgprehiZZj5CN17MYqzddYMxFHuY3FwW532Y
IKlomAXtSLfAWQBk0g+zws0DJ3uLNNvXvkagr53tJNFz8KK0UB+ptn2FNKEefUp0
hHGSLU+OLLd11FtvJ4Me
=c/Zf
-----END PGP SIGNATURE-----

--Xs9UdAbShFO41vQ0FeKFmscp0K0qhDBFh--
