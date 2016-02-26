From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 26 Feb 2016 10:13:07 +0000
Subject: Re: [PATCH v2 3/3] fbdev: omap2: panel-dpi: implement support for a vcc regulator
Message-Id: <56D02533.1060604@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MlfkvFqJouxL0WBKcDiXbN4Rciq2jW5m3"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1450610002-10531-4-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1450610002-10531-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-fbdev@vger.kernel.org

--MlfkvFqJouxL0WBKcDiXbN4Rciq2jW5m3
Content-Type: multipart/mixed; boundary="MAkl698nq1F1wckcRbsCFIvj21o6T9CGd"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org,
 kernel@pengutronix.de
Message-ID: <56D02533.1060604@ti.com>
Subject: Re: [PATCH v2 3/3] fbdev: omap2: panel-dpi: implement support for a
 vcc regulator
References: <1450610002-10531-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1450610002-10531-4-git-send-email-u.kleine-koenig@pengutronix.de>
 <56C31D50.1070501@ti.com> <20160216134826.GA32169@pengutronix.de>
In-Reply-To: <20160216134826.GA32169@pengutronix.de>

--MAkl698nq1F1wckcRbsCFIvj21o6T9CGd
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16/02/16 15:48, Uwe Kleine-K=C3=B6nig wrote:
> Hello Tomi,
>=20
> On Tue, Feb 16, 2016 at 03:00:00PM +0200, Tomi Valkeinen wrote:
>> On 20/12/15 13:13, Uwe Kleine-K=C3=B6nig wrote:
>>> @@ -223,6 +232,10 @@ static int panel_dpi_probe_of(struct platform_de=
vice *pdev)
>>>  	if (IS_ERR(gpio))
>>>  		return PTR_ERR(gpio);
>>> =20
>>> +	ddata->vcc_supply =3D devm_regulator_get(&pdev->dev, "vcc");
>>> +	if (IS_ERR(ddata->vcc_supply))
>>> +		return PTR_ERR(ddata->vcc_supply);
>>
>> devm_regulator_get_optional()?
>=20
> That would make the specification of a vcc supply obligatory IIUC. (Yes=
,
> the semantic difference between regulator_get vs. regulator_get_optiona=
l
> is reversed when comparing to gpio_get vs. gpio_get_optional.)

This is a bit confusing...

So, is regulator_get_optional() meant for cases where the device can
truly function without the supply in question? And regulator_get()
should be used when the device needs the supply, even if the supply
cannot be controlled via SW, and thus we may not even have the supply
visible in the SW side (leading to using dummy regulator)?

 Tomi


--MAkl698nq1F1wckcRbsCFIvj21o6T9CGd--

--MlfkvFqJouxL0WBKcDiXbN4Rciq2jW5m3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW0CUzAAoJEPo9qoy8lh71zHkP/3oRbKCTgGqHDBaMc+10NA8t
ZcTb8WdUtPimXYi6FAZCtIwJ5iELLaHisKo4vCe0x8vSb3j8P+sCmrbZOj65gZTS
tJjWGnCRpx5BP53xQd3U7F1pUfydGy5Zo4m3Kd4cWkrqyU0o9DIOc0h8XM3WrGH3
c3888yuYz7znbqi4fBt4PVvQWwoZHFdg2lbsclK838BfDFCxBurcN2Dvr3BIZsnR
/ovxHcvdGtvCV8YNvwcb/E8xujZvI1Qg4ciGioC/CaDA8YRE1pwy++gux3whMFVD
oJeq7xnVxv2RMLJH77RTpwcNE8aPwqnfk6okR15R5SaP7jugErgzfmtBaIpk5vw/
pfOAIB/VhtsUqLyUkWN30xaZFRgJV74gjZLwY80bySyJ0f5Jcyayi67J9UvYtK5C
1q5lssMseYb42xSTLIJ2vVoAG8hgKuGRZNisQgE4DL4KyMnnfDK6boU3QsUfRsoN
bLLauniBm92/aE5xSlMRotpTe2dflFwKqsaSv/a6M6bxt5UGU9q908X/xQSgFDLH
ahsPAKT3kPJ4YjJ8MKxtLZz+VqlDB//tdiSUfxk17Ohn6h+q6pRZEGoMqGWi3fcb
/LVUIQEyNDe8COsPqlGMHbaZhKgZRRO04opREgx6McFEiXI8/e21QnIe4Mg7aE5t
MNsHZhO084bhXdFRwqxF
=k1iI
-----END PGP SIGNATURE-----

--MlfkvFqJouxL0WBKcDiXbN4Rciq2jW5m3--
