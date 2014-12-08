From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 08 Dec 2014 11:00:28 +0000
Subject: Re: [PATCH] video / PM: Replace CONFIG_PM_RUNTIME with CONFIG_PM
Message-Id: <548584CC.7010603@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="FRLHTuixXLWp3cwBRuTDNWWCmoWeGjcVg"
List-Id: <linux-fbdev.vger.kernel.org>
References: <19160360.7uJRUqlDQg@vostro.rjw.lan>
In-Reply-To: <19160360.7uJRUqlDQg@vostro.rjw.lan>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

--FRLHTuixXLWp3cwBRuTDNWWCmoWeGjcVg
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/12/14 04:36, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> After commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
> selected) PM_RUNTIME is always set if PM is set, so #ifdef blocks
> depending on CONFIG_PM_RUNTIME may now be changed to depend on
> CONFIG_PM.
>=20
> The alternative of CONFIG_PM_SLEEP and CONFIG_PM_RUNTIME may be
> replaced with CONFIG_PM too.
>=20
> Make these changes in 2 files under drivers/video/.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>=20
> Note: This depends on commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME =
if
> PM_SLEEP is selected) which is only in linux-next at the moment (via th=
e
> linux-pm tree).
>=20
> Please let me know if it is OK to take this one into linux-pm.

Does not seem to conflict with fbdev changes, so:

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi



--FRLHTuixXLWp3cwBRuTDNWWCmoWeGjcVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUhYTMAAoJEPo9qoy8lh71uXgQAIV22jLyJQL+DkDsmDE8buTT
tB0GkxxDqm/Z1HtO0BjDYxuDKNDlgJ3kPBCHOqi+aKxLM+Y71v8BdTpOY4UVDfPX
AX3oklbRazxLFeCWlFSNQ2oMXKFms1CuvQd2jRo98X3sYniP1Vt4mmcqlebW8dco
7GHFO/jgYnmpKrU5wz/CQeAvHSdaH5ArYb++uDWvvoOM1oKwA0+loNx3McJS2QSC
TqC20xR39Wu9m63gB6sa27tyhmRHb7XBdcXaVg3ubozfO+2oPKMP/6wupeT0nXUP
wl6V6tR6C3ZdRuyCe+HmOTXsFaUCWdosRWijaDIO762Rts9NnuThRjYN1AFLfQKC
IumkjFWXdHfsE+0R5nmcXAFha3UybMM/AtFS8l2tSieJMe/wQlo6ilk1NycCvfHA
Blf+Co2bCTmKEY241jNmQixw1Rkb5a0XAiL/wYVh2m86NIYf3ZvoOOWamAShNPkc
jXJdTrTTioMp9rEiqp1yHq4Cy7Qz3nyE0vCQHKzYHgsZFjAURl4hiJjHoqZ8ss8F
2PNEGK8Myy0R+8ArLdkVsmvS/jnXLW0n5PW/2xsP0Kb1SBGgDqR2Ob5YP3NvH9IL
VS2YfcyUa4dCADgAodBwRUjXsc4o2gUyMbQubxMurhcYv+bFx7TB0SuJrlRpltnR
nnttB9xQ9l43dRi31QxO
=zUcK
-----END PGP SIGNATURE-----

--FRLHTuixXLWp3cwBRuTDNWWCmoWeGjcVg--
