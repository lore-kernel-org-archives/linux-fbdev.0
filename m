From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 21 Aug 2015 05:57:09 +0000
Subject: Re: [PATCH RESEND] video: fbdev: s3c-fb: Constify platform_device_id
Message-Id: <55D6BDB5.50309@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="HClKCKFgV2OD6xO7DMCUW2DENBhcxoiMQ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1436274047-3274-1-git-send-email-k.kozlowski.k@gmail.com> <254E99D1-79CE-4B90-B732-E5A4A1308DC4@gmail.com> <CAJKOXPc=k8r64_LuUGBaoOK87h07_zXUn_LoQ50KWfbk-1u69w@mail.gmail.com> <55D59AE2.7090201@ti.com> <55D682F3.5090800@samsung.com>
In-Reply-To: <55D682F3.5090800@samsung.com>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--HClKCKFgV2OD6xO7DMCUW2DENBhcxoiMQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 21/08/15 04:46, Krzysztof Kozlowski wrote:
> On 20.08.2015 18:16, Tomi Valkeinen wrote:
>>
>>
>> On 24/07/15 09:12, Krzysztof Kozlowski wrote:
>>> 2015-07-08 13:34 GMT+09:00 Jingoo Han <jingoohan1@gmail.com>:
>>>>
>>>> On 2015. 7. 7., at PM 10:00, Krzysztof Kozlowski <k.kozlowski.k@gmai=
l.com> wrote:
>>>>>
>>>>> The platform_device_id is not modified by the driver and core uses =
it as
>>>>> const.
>>>>>
>>>>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
>>>>
>>>> Acked-by: Jingoo Han <jingoohan1@gmail.com>
>>>>
>>>> Best regards,
>>>> Jingoo Han
>>>
>>> Seems nobody is picking it up, so I merge it through Samsung-SoC tree=
=2E
>>> If there are any objections please let me know.
>>
>> I can pick this up if you didn't already do that.
>=20
> Could you? It would be great.
> Kukjin did not pick it up so it is still waiting for some attention. :)=


Ok. I've queued this for 4.3.

 Tomi


--HClKCKFgV2OD6xO7DMCUW2DENBhcxoiMQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV1r21AAoJEPo9qoy8lh715V8P/1nIcDEHM0w8Le1v59+wkLgk
GlihMH9YC/ADjjn7bgwVF5eRnLNWaApNsdZy7s8HNyru6bTYgCwP1cFEqDvybFyp
zy9q9fj+3OR8dOKQxpZTNgqBfF/AP6IXen1jlf63aWRSrUxyvMSfA0mKnKHvvrVm
P7H85JCK2QBC3mzG8LoGVOtT0y6e3oGMN8LKlnfKUFJdA45vt6klipcy9XHg+rg/
OHoAWiDnO6nn5vn3soAJ3OdJjnl/9tkYWQxUshQa/qsqUvPgtpNqyXnjdKkHiEFg
FDRhBCnLkQ92ZkZuxgQCIEO7+HgRMurbA+Jzx6PGVY+rx+VVHmt6oFbq8U85WKoB
fAFW+wd8gN5NgB40uIIH/lAf5/FkeDKNGYSesLdasaOP8a22wLGjlH/xGDXGXvlY
Mi558a8II0O7Tl25R5UQQyGzOos1GZ9bugulWSYnUI4Su9Io6mDjYOyaICMclQBb
gQ9T6nC91GMYk72dcikJhFp5cgIfaak2PE11NmeT2Sl8g0amdzdZEWI6D/vrAMVG
K7uzjxHXbSwILU5Vw/Patl9UmYHj+Wa+PdUiYQmhf0r4o/XY+rvFgbfvsTcD2zAu
smyGbmhYxXTOhsyeGpN0IhFZcdExDDuhn5Jo4xjwB6cpyoi81x8ahUcFQ2U9BRUF
9NmAzOqYQtd9q81zgwxf
=RYdT
-----END PGP SIGNATURE-----

--HClKCKFgV2OD6xO7DMCUW2DENBhcxoiMQ--
