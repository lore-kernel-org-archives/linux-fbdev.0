From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 21 Aug 2015 06:41:22 +0000
Subject: Re: [RFC] fbdev/riva:change to use generice function to implement reverse_order()
Message-Id: <55D6C812.6080400@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="tChqb8AStiWLuT8IQjTg4ELiGcg0wFtCu"
List-Id: <linux-fbdev.vger.kernel.org>
References: <C21B8761-0447-45A6-B833-742E3B4C13DE@gmail.com> <55D5B3A9.6040901@ti.com> <867D66CD-9A3B-4536-B537-8C065C85E497@gmail.com>
In-Reply-To: <867D66CD-9A3B-4536-B537-8C065C85E497@gmail.com>
To: yalin wang <yalin.wang2010@gmail.com>
Cc: adaplas@gmail.com, plagnioj@jcrosoft.com, linux-fbdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

--tChqb8AStiWLuT8IQjTg4ELiGcg0wFtCu
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 20/08/15 14:30, yalin wang wrote:
>=20
>> On Aug 20, 2015, at 19:02, Tomi Valkeinen <tomi.valkeinen@ti.com> wrot=
e:
>>
>>
>> On 10/08/15 13:12, yalin wang wrote:
>>> This change to use swab32(bitrev32()) to implement reverse_order()
>>> function, have better performance on some platforms.
>>
>> Which platforms? Presuming you tested this, roughly how much better
>> performance? If you didn't, how do you know it's faster?
>=20
> i investigate on arm64 platforms:

Ok. So is any arm64 platform actually using these devices? If these
devices are mostly used by 32bit x86 platforms, optimizing them for
arm64 doesn't make any sense.

Possibly the patches are still good for x86 also, but that needs to be
proven.

 Tomi


--tChqb8AStiWLuT8IQjTg4ELiGcg0wFtCu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV1sgSAAoJEPo9qoy8lh71dhYP/2qR04hEUYBHtJXo3MQe6Evs
iCAoIrGgBw9YvSpXcRJ3JuB/WHbRqv4YtlSjyTf7YlChwxsQw0aJL5w//Cr0MnN5
tZS7uouF3GYN8yi7QYX5IYSwYVoscNxnO8nKcm/VSTDxRCB9Ui0q6iE1ey8wGCkP
poSqswtJvaXAMWKvNF/qJc9ELhpkIHUn4WHCtu1HQo+eyBuPzWxXGzugEZG51kcj
+hDJg98jp3jBWALLuGQypzeEq1KqbUFICXD4RocAwB1EwbS9fZg46FRKg90iEJYh
EGKk7NLZ6puBziF/wdDze70zKOdY7pilqdlJ8/DtTP2SxbH7ai3E658EUCcOZZ8f
Z/fZA0o0N+IFAl8RwxN5kv2c27VOD3OuJCG9BSoqU4L8e8YrXLRxTQU+Z3JWRjjM
IZ/WYB2RxHOwRNjA4LlusoRhLBVZfzZFkIq2z2XNOe3L2EHT6NCttdumFmt5jDa1
KOXszYMA06Heiqo24GszN1igor0YplZZjJXnkdfksZLb6Aocb/LqwZEzus2g4N/S
q+fC3DxkOQJfjvRt/U17HzURt5aE+tRNX4Eyn89eY2yVg1m8gKEsBDQO/2Sbl06P
Ff67sQ9A0Z9EgX7UdBSmkX0HEwuLJr3aOzHY4TDXgmhNSp64yF+8RzdxVKQsDNAg
9sZSSXG+NzYaOrEfUEMX
=0nVY
-----END PGP SIGNATURE-----

--tChqb8AStiWLuT8IQjTg4ELiGcg0wFtCu--
