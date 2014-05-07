From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 07 May 2014 09:40:49 +0000
Subject: Re: [PATCH v2 1/3] video: clps711x: Add new Cirrus Logic CLPS711X framebuffer driver
Message-Id: <5369FFA1.20000@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="sRoHwiQQ0FwgJxeuKJdrMJ50Exqgm7IdO"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1397285583-15187-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1397285583-15187-1-git-send-email-shc_work@mail.ru>
To: linux-fbdev@vger.kernel.org

--sRoHwiQQ0FwgJxeuKJdrMJ50Exqgm7IdO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 30/04/14 15:36, Alexander Shiyan wrote:

>> Hmm what? So is the old driver totally broken, and cannot be used at t=
he
>> moment? Or why you can't test on real hardware?
>=20
> Firstly, the driver uses a fixed values for xres, yres, pixclock and sp=
ecific
> variable ac_precale.
> Secondly, the driver uses a fixed value for the physical address of the=
 buffer.
> Totally, it does not give me the ability to use the driver in the curre=
nt state.
> Unlikely that this will look good if I make these two significant chang=
es in
> a single patch...
>=20
> At this time the driver has three user.
> Only one of them should theoretically work.
> clps711x-autcpu12 should not work in the absence of memblock_reserve().=

> clps711x-p720t should not work due to physical address limitation as i
> noticed before. Board means to use SRAM instead of SDRAM.
> Only clps711x-edb7211 should work fine (in theory).
> Is this a good reason to replace the driver? I think yes.

Ok, if the situation is that bad, maybe we can just switch to the new
driver. Have you verified that those boards do not work from anyone? Or
asked someone to test the new driver with those boards?

I'm still not really happy about it, and I'd much rather see the current
driver fixed. But if no one having those boards is up to the task
(probably not if they have not been working at all), maybe just ditching
the old driver and adding a new is the only way forward.

One change that I think would be good is to change the series to first
remove the old driver, and then add the new one, with the same file name
as the old one. That way git log will show the history for both the new
and the old driver.

>> Note that I don't know anything about the fb hardware in question, nor=

>> the driver. Maybe there's a valid reason to write a new driver from
>> scratch. But there very rarely is.
>>
>> And "because I already wrote a new driver, and it's a waste of time fo=
r
>> me to throw away my work and patch the old one", is not a very good re=
ason.
>=20
>>> if you imagine a new file as a diff to the old, this can be clearly s=
een.
>>>
>>> There is no reason to waste time on a series of changes since I
>>> can not even check these changes on real hardware, but only in the
>>> last stage when the driver will be the current version.
>=20
> Summing up, I want to ask why the driver can not be reviewed as a
> new and not compared to the old?

It can, of course. But we normally should not.

Fixing the old driver will keep all the fixes and tweaks that have been
debugged and solved with the old driver. Creating a new driver easily
makes those old fixes disappear.

Fixing the old driver also keeps the history, making it possible to see
where an issue was introduced etc.

> And yes, the time can be spent on more productive things to do than
> to create a series, leading eventually to the same result.

Yes, your time. But if, say, the new driver introduces bugs that already
were fixed in the old driver, causing problems to other people, and to
me as the maintainer, I'm sure the other people and me are not going to
say "well this is ok, as this saved Alexander's time" =3D).

 Tomi



--sRoHwiQQ0FwgJxeuKJdrMJ50Exqgm7IdO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTaf+hAAoJEPo9qoy8lh71YIYP/iD5iMhochMJUDNBJPqdwZJR
cUjFL/aCfbbSchp6gki/DC0PZJsuv+Ysc36EKLG8EmB1ZxoQ4fFQKxB5q0vlEahn
cOti6sGoRfLJ/wf4Z9ZqtrZhq+4leZMBrIOsDVGhzbmkHxgbNZkYzZ4snWuTGKy7
fFv7OKiQ7W9Wa51QKCGEiDnb8hFVnB3BdNu/atUAg1H7yOmQqER6msELImBHAoxf
75qLikSjvasdz7NWBDdzzctdD2MBljPev14xF2Hy2dkqLWaZB0HtWP08QbOHfNqs
PtGUld0zWcr5XOxCanqLoy9BRW4pEpB7QDbViMmHDq1NRYOI4hT4wYtGL6chQMdx
fXYpPexJGl35PbyWtb6t3DmlHCHHGgy1k8xfEr62mpitmOWqzXhVqpQ7LaFuAJhV
ZYxiVmHHd1Dqur73KNmf1xBz3j4LSy4iP4rQZrF5k7/1Htrhe8HbDTZ9nwfi5T89
BO7dvDvuYNq/GMNSh4AeLsRBJQQ+7mPB60/HJSjHs0y97sGTBevJ5qhSZiCJKFF8
nfPyGPFcKKNrYStlvoHQkRiftS6/aBdnYGQXC7TbKvKQ8OB8MC16MplrX98h8bli
ODVYHDQdm389d8RRJB84YDOpR80Dr3dgyY9FCBouweJfJGdAQmU7JKV/wmu22jQ9
1q1gt8XzdcmYDZ7l8d0W
=iaqY
-----END PGP SIGNATURE-----

--sRoHwiQQ0FwgJxeuKJdrMJ50Exqgm7IdO--
