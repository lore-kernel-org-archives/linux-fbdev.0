From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 20 Aug 2015 09:16:18 +0000
Subject: Re: [PATCH RESEND] video: fbdev: s3c-fb: Constify platform_device_id
Message-Id: <55D59AE2.7090201@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="JCrROvVmCJXbxlhVrakKtaB3p2xnqv1Io"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1436274047-3274-1-git-send-email-k.kozlowski.k@gmail.com>	<254E99D1-79CE-4B90-B732-E5A4A1308DC4@gmail.com> <CAJKOXPc=k8r64_LuUGBaoOK87h07_zXUn_LoQ50KWfbk-1u69w@mail.gmail.com>
In-Reply-To: <CAJKOXPc=k8r64_LuUGBaoOK87h07_zXUn_LoQ50KWfbk-1u69w@mail.gmail.com>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--JCrROvVmCJXbxlhVrakKtaB3p2xnqv1Io
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 24/07/15 09:12, Krzysztof Kozlowski wrote:
> 2015-07-08 13:34 GMT+09:00 Jingoo Han <jingoohan1@gmail.com>:
>>
>> On 2015. 7. 7., at PM 10:00, Krzysztof Kozlowski <k.kozlowski.k@gmail.=
com> wrote:
>>>
>>> The platform_device_id is not modified by the driver and core uses it=
 as
>>> const.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
>>
>> Acked-by: Jingoo Han <jingoohan1@gmail.com>
>>
>> Best regards,
>> Jingoo Han
>=20
> Seems nobody is picking it up, so I merge it through Samsung-SoC tree.
> If there are any objections please let me know.

I can pick this up if you didn't already do that.

 Tomi


--JCrROvVmCJXbxlhVrakKtaB3p2xnqv1Io
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV1ZriAAoJEPo9qoy8lh715K8P/R1w46ch4c/hb7t1o0RwIW/J
FgCBImd6WQNRufsrztxvgSeK5lJjPleetlITdsIEsgYnAmdVxDXQYPgv+Q9fHkw+
1Uy7l541asce5Teu5+TtP2/xkoPa8T+oG6rcff9Gy8/db5ot0yWb9rP3EHtLxLI4
VkkBC5COXcPCjU75tnlhG8xfUqMGlTKmciv7wjl2ZYKr/a4l+l9PjXv2Abcsakfr
BnC/yYM1ZOrOEAbquUbJ4CvjnaLw/sDHheo6vZHVd3RrLofwWiwxZT15gnDhPl/g
PsKGZ8XTn0xfRMHNd5qa2iAQNvSpm+4+0+d/8v77MbehOVtKfHlTjQjZTLLd4Zve
YenKtuq7uHIUdVtH/Q4Bo1OO8YY69Fbae9ZqLSCoNYmxux4QeOsCPOhy3GLnJ/Y8
93s98oXlTuus4qqlNWgefi8gJo6eFd/9DxWsNyx9HiMMC3lBV7R81c1HqjpyZXiE
a62KRcIb7LMiaZl4kzBEusyQUy5WHWoIVHrYz5RZnPe6pp77g0CS1OtW4Ld2qOAp
sH+HGNO2O+TK69Ikq1GgBiQo7YMWMw2V6fI00r/vR3ky7FcXJK3LK8zisENeufaV
iqP2UlBRPE+QFO8VrxtD/kDz9t/tOylbmsLnVibhDU2qFEWAH/OGKun6ebU4EPkv
hA7mZIABcNFMTd9aWXVR
=4Cyr
-----END PGP SIGNATURE-----

--JCrROvVmCJXbxlhVrakKtaB3p2xnqv1Io--
