From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 26 Nov 2013 14:44:09 +0000
Subject: Re: [PATCH -v2] fbdev: sh_mobile_meram: Fix defined but not used compiler warnings
Message-Id: <5294B3B9.3090104@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Cloo4CfUc1DfxGdu77nWCOTe7ACvVgPad"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1383728247-19294-1-git-send-email-geert@linux-m68k.org>
 <5204468.CmggZzW3kO@avalon>
In-Reply-To: <5204468.CmggZzW3kO@avalon>
To: linux-arm-kernel@lists.infradead.org

--Cloo4CfUc1DfxGdu77nWCOTe7ACvVgPad
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

On 2013-11-06 13:57, Laurent Pinchart wrote:
> Hi Geert,
>=20
> Thank you for the patch.
>=20
> On Wednesday 06 November 2013 09:57:27 Geert Uytterhoeven wrote:
>> If both CONFIG_PM_SLEEP and CONFIG_PM_RUNTIME are not set:
>>
>> drivers/video/sh_mobile_meram.c:573: warning: =E2=80=98sh_mobile_meram=
_suspend=E2=80=99
>> defined but not used drivers/video/sh_mobile_meram.c:597: warning:
>> =E2=80=98sh_mobile_meram_resume=E2=80=99 defined but not used
>>
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>=20
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>=20
> and applied to my tree.

What does that mean? Are you collecting sh_mobile video patches?

Or to rephrase, shall I apply this to fbdev fixes tree?

 Tomi



--Cloo4CfUc1DfxGdu77nWCOTe7ACvVgPad
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSlLO5AAoJEPo9qoy8lh71z50P/iIF1/0lsH127cSN9t0C95sb
QDcLCQwB6H+ZS67KVfDCtbw4Rx24qVwiI97hlUt9h/QrML26LZ4N3HUwZ4OqhlUa
giG5Csr3P7vTpYOnOn/WUFX/CRFcKyq3HZI9IHejFNsPo4/s+iEZvrnhUMPcvcb9
kcTacvftPBRJB2f2xErp5iWQD/S48nGuFr8B/KM1FKHQl+bvVcSct11jCCjaqlmc
YIjGuk+LbgCcho/W5+W7evp+ZdB6gjQDui3OCLIh/67L3Y87NQiqSWc8sqejz7iS
eMbCyXyiPP+LmtHEuvCXklF35FDartMDN1tQZM1dfRWRgwPXKDTjA6EvLb9TVceX
AY3m0abQ1PE8cTa4Sx7WKg+isQVLI6q2zWpGfsrSYr7eLWMZw1w/as8oU5X6vtUs
FV0bKupaYE3s1q77EymQ7PNF1h1G2gpwssNXXJgK3rWaj6HVwG261K040ocv6P3w
9B2qy/bqxGdzbIf6YkvSFWLH+PHrcAfgugnhNgzRDm/qAbvquHDxsbE11UKy3LQq
gttoG1iWZhOeIUllOUA9H0ZrPyZ3OJbyL8GhGKmHOxfCnrEhLeZGrD1UpJJzPKLd
rpFItZt8LjYD5VQUGF2JChow4QMeAoGuu5WFcoNyz3S7cFRhtprksGspA08093xI
6dTk0Z3szZ6xAHbwJJq2
=SxIq
-----END PGP SIGNATURE-----

--Cloo4CfUc1DfxGdu77nWCOTe7ACvVgPad--
