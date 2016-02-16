From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 16 Feb 2016 13:33:17 +0000
Subject: Re: [PATCH v2 2/3] fbdev: omap2: panel-dpi: make (limited) use of a reset gpio
Message-Id: <56C3251D.2030104@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="d5u0WJAkCegUB4Xc2Pqc0U3xRSjCCFMhH"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1450610002-10531-3-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1450610002-10531-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-fbdev@vger.kernel.org

--d5u0WJAkCegUB4Xc2Pqc0U3xRSjCCFMhH
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 16/02/16 15:31, Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Feb 16, 2016 at 03:01:55PM +0200, Tomi Valkeinen wrote:
>>
>> On 20/12/15 13:13, Uwe Kleine-K=C3=B6nig wrote:
>>> Some displays have a reset input. To assert that the display is
>>> functional the reset gpio must be deasserted.
>>>
>>> Teach the driver to get and drive such a gpio accordingly.
>>>
>>> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>=

>>> --
>>> Changes since (implicit) v1, sent with
>>> Message-Id: 1449753107-11410-4-git-send-email-uwe@kleine-koenig.org :=

>>>
>>>  - never assert reset because there are too many different panels wit=
h
>>>    too many different needs for their reset.
>>>  - split out dt binding changes
>>>  - reword commit log
>>
>> Please add these extra texts below the --- line below. Otherwise they
>> end up in the commit description.
>=20
> This was an accident. Should I resend for that one?

If there are other changes to other patches, resend the series. If there
are no other changes, I can just snip it out.

 Tomi


--d5u0WJAkCegUB4Xc2Pqc0U3xRSjCCFMhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWwyUdAAoJEPo9qoy8lh71miUP/2AK1Icrzq9087cnK5qiHt9+
KexrAHTj0C8uQ9hmi1jbi50slHXN+jpKnzawfRU+Zers36E6TLJqZF0TO7FE1/qA
xGXVmt3kXVoIvrw11qFf1uo/DTHWUljx4V306BPI+Ydl/8CSH88Px6cXbvC8Nk9E
PAfO99WC7odi8ycYYyRAcW6sybhBt2C/XOcvLwgG4pgEnWIlAEr3FoPoxCa4JuA6
2ChLekInZJjBGgTNH98igteTeCK1Xsjyfy5derrgPhH4mGuFfMrBa1wt7lh+PO30
W5bheKO2y8U2+Ej8q+vWCeXn1WNr8F12x/dyTswgtHB6RaYE8QA6vHkpOv5UcZRB
XVxK7TkKv+2MzOpWFmJ/fnfmcME0NOP/+hTJpmU2tpgITAP6P772WGMnymZoV+qI
4damQbmCCLVnz5i++T4xligtWJwzflAOU+vXIq5Vo7vaFVeZDLOn2JIA4LX+UtB8
StTX0spUwc9dQ4+LGwttdIAeaFvEM3PkvL6HIG80L1NmYbox0+uIi/XnMwqWQSqp
cIfRO2JHM5PiTo2t0wlcMyVibpCzsTB5yxFX0Su738SRxeBlZhqJF/vLUGZSRIgQ
GatbvGEda1s8TegqnOqn0yGFtyG491dlUPpT1c1ua00YVY00l7duGYUL4AmoUZe4
o/CT0U3+j0XNy7uVEvGj
=tZlX
-----END PGP SIGNATURE-----

--d5u0WJAkCegUB4Xc2Pqc0U3xRSjCCFMhH--
