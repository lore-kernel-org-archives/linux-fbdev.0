From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 21 Aug 2015 08:01:41 +0000
Subject: Re: [RFC] fbdev/riva:change to use generice function to implement reverse_order()
Message-Id: <55D6DAE5.20304@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="PBjJ09ID8wXspKNAgmniaObit7tISXhnK"
List-Id: <linux-fbdev.vger.kernel.org>
References: <C21B8761-0447-45A6-B833-742E3B4C13DE@gmail.com> <55D5B3A9.6040901@ti.com> <867D66CD-9A3B-4536-B537-8C065C85E497@gmail.com> <55D6C812.6080400@ti.com> <4DCC50F3-9B6D-4A3A-9693-E7A7196564A8@gmail.com>
In-Reply-To: <4DCC50F3-9B6D-4A3A-9693-E7A7196564A8@gmail.com>
To: yalin wang <yalin.wang2010@gmail.com>
Cc: adaplas@gmail.com, plagnioj@jcrosoft.com, linux-fbdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

--PBjJ09ID8wXspKNAgmniaObit7tISXhnK
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 21/08/15 10:46, yalin wang wrote:

>>> i investigate on arm64 platforms:
>>
>> Ok. So is any arm64 platform actually using these devices? If these
>> devices are mostly used by 32bit x86 platforms, optimizing them for
>> arm64 doesn't make any sense.
>>
>> Possibly the patches are still good for x86 also, but that needs to be=

>> proven.
>>
> not exactly, because x86_64 don=92t have hardware instruction to do rbi=
t OP,
> i compile by test :

For old drivers i386 may be more relevant than x86_64.

So you don't have the actual HW?

These kind of optimizations should have some real world measurements,
not just compiling, looking at the assembly and guessing whether it's
faster or not.

 Tomi


--PBjJ09ID8wXspKNAgmniaObit7tISXhnK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV1trlAAoJEPo9qoy8lh71cDIP+wbZJDah/jhN9ZGMjDFzhrqe
zYmS++S7+l8mFPEuSWYuhRmyI+6NZ3tNQpXz/xoH8ZsEsTaxhzZtT0KTLmYDa/m+
XbtnUmm8VrB7IcMSJtqYQbnWzU+0ra+YOHFRJQzFKVkf20d2NnlE+UPvNCUkkjtQ
v743XUgA4bxusfcsnES36PC3LPGyCt94hH1Rs0QXwxJVyeq+bqdJ2XnCWHa9RJPV
YZ8DCi7bO1WiBcu8lALo+LBhnKaG0o2mTR59/zwzRsrinw62o7BTXGGOkZh179aa
awKZUnMW6JRH3P8d23148Lht3QNBM1xvRIy7tMNszk7ApjzXz/+egkj6y/mlYJ7K
HMlPYHB9yOaIuiESSxYiGkQO4qyRQUEf5RmgyLkOzZOHARzPcUgNijgqhkCC1S6u
dZVWiwYnpDvFqvEX52jxyrGsn5JvkIWgk9Uln/UInnOtglP/p2yA5PwMJWzjRhjL
pdu2yHR1EcrnqpmHxo6I55mWchvs0e+X0Lk0eMPN8vctN+EmjeUbmiN9U/ec3e6h
bfpj/sq5HZ3pDfzksx+U0ShARmXegZca89eajhdHuEComjO3I9L8CO1wOlRHkEA7
4j1NWjoAQ9jVIAMGh3hH4g6rzlUytMgBjTioVVcERl7CYrELouKag3/OWerdvvoJ
FdiSETaeqoooB7nZbrHw
=sB5t
-----END PGP SIGNATURE-----

--PBjJ09ID8wXspKNAgmniaObit7tISXhnK--
