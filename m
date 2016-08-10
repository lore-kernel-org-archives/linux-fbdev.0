From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 10 Aug 2016 10:29:32 +0000
Subject: Re: [PATCH 2/3] video: fbdev: imxfb: enable lcd regulator in .probe
Message-Id: <bdcfe5b1-3d95-03a3-728b-a80f86c95932@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="URni2XLntngui155xvP5hai7BwTBcQDbO"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1457380425-20244-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1457380425-20244-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <56E2AA80.4050908@ti.com> <20160420191727.GS29108@pengutronix.de>
 <20160705100902.GM16643@pengutronix.de>
 <20160727195700.GE5629@pengutronix.de>
In-Reply-To: <20160727195700.GE5629@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org

--URni2XLntngui155xvP5hai7BwTBcQDbO
Content-Type: multipart/mixed; boundary="ppcFTpxNGriHd2RsK5EwPwhoBf9buqBXS"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org
Message-ID: <bdcfe5b1-3d95-03a3-728b-a80f86c95932@ti.com>
Subject: Re: [PATCH 2/3] video: fbdev: imxfb: enable lcd regulator in .probe
References: <1457380425-20244-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1457380425-20244-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <56E2AA80.4050908@ti.com> <20160420191727.GS29108@pengutronix.de>
 <20160705100902.GM16643@pengutronix.de>
 <20160727195700.GE5629@pengutronix.de>
In-Reply-To: <20160727195700.GE5629@pengutronix.de>

--ppcFTpxNGriHd2RsK5EwPwhoBf9buqBXS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 27/07/16 22:57, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Tue, Jul 05, 2016 at 12:09:02PM +0200, Uwe Kleine-K=C3=B6nig wrote:
>> To reach my goal to keep the display on (showing whatever the bootload=
er
>> initialized the display with) until the application starts caring for
>> the display some driver must enable the regulator. The only candidates=

>> are the lcd driver (i.e. the patch under discussion) or some mechanism=

>> in the fb core. As there doesn't seem to be code in the core (and the
>> core is dead?) what do you suggest me to do?
>=20
> Unfortunately I didn't get an answer here. Do you still have this mail
> on your radar?

Can you resend the series? And I think I had comments about the third
patch, to which I don't see any reply.

 Tomi


--ppcFTpxNGriHd2RsK5EwPwhoBf9buqBXS--

--URni2XLntngui155xvP5hai7BwTBcQDbO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXqwIMAAoJEPo9qoy8lh71eHkP/1KMMj9wGTObp4VNEh4hQr+N
3NVgUZKBcGENRL5maUijTTD86JPhA4+vuTlLZ2rWLQuSf633ZASkM67qazrwZ82M
CMuUzELrR7fGNXC3KlDvsYAwVp3OX1YVnjP86pZmdnfpv6wMiIHaQVHqEMyNumVT
IsEuNgbzlo4XDJT8NY0YJXFoPlw6qp1oNm3KIS7wgTL36vrcgyIYA/XNr9MaFhNF
vpetQ5LKbdo3NuEBPzMWJjW0bbh73TKfW8A8fR+TB0Z1eK92k/pxWciGrVhnC+k8
l0xp+qijzbDQymHCSV7Yyz5v2kezue2DAYjXNLab0R5aRTa2UfXSTEtHlsxW0NB+
KjfAMzj3xtaA23CX46VW0Son/ddRifS+0qXvPkVeZa6Jk0Qbb8s/UtdndrUrPZw2
bPizsztF+J1mWCKzzUhchSOCLcG6kQHkzIeCT4y9NFLkubKRnph2jYDHPkxtj35M
TnutM+QMb/Ir+jSnPCJGk3XQdl7OFIyKZVp0v9XtEq9730+yE50Z7fBMc758/Tft
gdzLWdi+H3XXjYw04NudJh4nXchjiOKXp/Xil19/j2aWSXb2zeQ03wbT5W2/xr/e
X89UmB4YLwq2slwq8aGtQSdCHieD/z+RZwtEf57Vp71/KVcGmUNGT4OCtZ3J3Y0u
uSqbhI0I8sBfC6xTKE5K
=+4Jr
-----END PGP SIGNATURE-----

--URni2XLntngui155xvP5hai7BwTBcQDbO--
