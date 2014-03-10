From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 10 Mar 2014 13:22:48 +0000
Subject: Re: [PATCHv3 00/41] OMAPDSS: DT support v3
Message-Id: <531DBCA8.80507@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="afr6f1SGcBTWJSX9cwlt8HDNQfmPvF2Vp"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
 <531823C5.1020008@ti.com> <20140307164929.GC3789@atomide.com>
In-Reply-To: <20140307164929.GC3789@atomide.com>
To: linux-arm-kernel@lists.infradead.org

--afr6f1SGcBTWJSX9cwlt8HDNQfmPvF2Vp
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/03/14 18:49, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140305 23:32]:
>> Hi Tony,
>>
>> On 21/01/14 12:56, Tomi Valkeinen wrote:
>>> Hi,
>>>
>>> Here's version 3 of the DSS DT series.
>>
>> Can you have a look at the arch/arm/ parts in the series and ack if
>> they're ok, i.e, patches 1, 2, 32.
>=20
> Patches 1, 2 & 32 look OK to me, so for those please feel free to add:
>=20
> Acked-by: Tony Lindgren <tony@atomide.com>

Thanks.

> How about do a pull request for just the .dts changes against current
> omap-for-v3.15/dt branch ASAP for me so I can pull it in? That is assum=
ing
> that just the .dts changes alone won't break anything.

Unfortunately they do break. At least pinmuxing is moved from the global
definitions to be handled by the respective display drivers, and there
are some regulator_name hacks that the DT patches remove.

I think those changes could be removed from my patches, and then added
back later when everything else has been merged.

The bigger issue is that suddenly there's lots of discussion about the
display DT bindings. If those are not resolved very soon, I guess I have
no choice but to again skip the merge window for the DSS DT changes.

 Tomi



--afr6f1SGcBTWJSX9cwlt8HDNQfmPvF2Vp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTHbyoAAoJEPo9qoy8lh71VLQP/2z8H92z1o1BnIA2roTyljxA
eVcatLA4UaZhfPHojbjzlN5Ap6lwAT5E5RtlNZfrdo41cGErxCk4mXmgO5IOa8EQ
i8NXlBaPWYJKuyUWdtuPP70p7rHBSM83a5GBWpCkVu70+qnoUXTA+ZbNYSG3PVqu
OSnwUFwLoBPjNiadK5PP0MvuFjwLHRYDb2GuB3smJu50DAe6g8Xh7OVDKZipyZbY
5B15zLp+64FEbRsfA6PiIrwiILQSPkmPNhsnijjfjM2lAM2CUxDRVQSgofOfxk6Y
nbyB4g2Yoe1hyo/RgsatQMhIzp6k+btO2LoKiKQxMay8r1+Tm9+VQZDCdMdK7Yrf
3kdYFaDv9YUO3MxIRQrwGH+TqiK1H83Z106nKKBp9G9mV1sufJQMs8S4+q/5C2Co
eXGAF0BByBIBKdrTMUUMVV0qew6AWCRTos5qmtkDdL2EBGVnxDirexD8L1i3EQFv
gpqJf9BzhXSRpGnQKFect8J+cZfklmhztDA18UOsUwMAzhSobrlQG1klxAFzTmGv
0c/7BjMzncj0a0f/JnOPRZcPRzbNtdwTdEIg8jIK2jyNDU9mWGmVe+QtlQTXPGCB
sFyT62bQP3GQTVr1encH+3xiw61HPnHyRQX0/pGLIy1o67kSUhuND0DPQOgY8gFX
2o0UnNug+ewRE4pE0w7H
=q7+W
-----END PGP SIGNATURE-----

--afr6f1SGcBTWJSX9cwlt8HDNQfmPvF2Vp--
