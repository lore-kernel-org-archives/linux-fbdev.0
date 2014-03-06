From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 06 Mar 2014 08:52:00 +0000
Subject: Re: [PATCH 3/9] Doc/DT: Add DT binding documentation for DVI Connector
Message-Id: <53183730.5060205@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="TQJ1RXgncEldqqG3JXXPILmUer1UDHP3I"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>	<1393590016-9361-4-git-send-email-tomi.valkeinen@ti.com>	<20140228155937.GQ21483@n2100.arm.linux.org.uk>	<5310B567.7040605@ti.com>	<20140228162327.GT21483@n2100.arm.linux.org.uk>	<5316E31F.9050308@ti.com> <CAMuHMdWVSfKrudBhE7FW-ZWBvMOLWjrQZvn1qZUfRt_H+P7A2w@mail.gmail.com>
In-Reply-To: <CAMuHMdWVSfKrudBhE7FW-ZWBvMOLWjrQZvn1qZUfRt_H+P7A2w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, DRI Development <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>

--TQJ1RXgncEldqqG3JXXPILmUer1UDHP3I
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/03/14 10:39, Geert Uytterhoeven wrote:
> On Wed, Mar 5, 2014 at 9:41 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
>> On 28/02/14 18:23, Russell King - ARM Linux wrote:
>>
>>> That's rather a lot of compatible strings.  Another possibility is:
>>>
>>>       compatible =3D "dvi-connector";
>>>       analog;
>>>       digital;
>>>       single-link;
>>>       dual-link;
>>
>> I made the following changes compared to the posted version. I decided=

>> to leave the "single-link" out, as it's implied if "digital" is set.
>>
>>  Tomi
>>
>> @@ -6,11 +6,16 @@ Required properties:
>>
>>  Optional properties:
>>  - label: a symbolic name for the connector
>> -- i2c-bus: phandle to the i2c bus that is connected to DVI DDC
>> +- ddc-i2c-bus: phandle to the i2c bus that is connected to DVI DDC
>> +- analog: the connector has DVI analog pins
>> +- digital: the connector has DVI digital pins
>> +- dual-link: the connector has pins for DVI dual-link
>>
>>  Required nodes:
>>  - Video port for DVI input
>>
>> +Note: One (or both) of 'analog' or 'digital' must be set.
>=20
> So dual-link needs both "digital" and "dual-link"?

Yes. It is extra, but it felt clearer to me to have 'digital' as a
matching property for 'analog'.

Alternatively we could have three options:

analog;
digital-single-link;
digital-dual-link;

My reasoning to the format I chose was basically that when a connector
supports 'digital', it contains TMDS clock and TMDS data for link 1.
Adding dual link to that adds only TMDS data for link 2, so the second
data link is kind of an additional feature, marked with a flag.

Not a very big argument, and I'm fine with other format suggestions.

 Tomi



--TQJ1RXgncEldqqG3JXXPILmUer1UDHP3I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTGDcwAAoJEPo9qoy8lh71DvwP/jhYkTe3hYf29HbZhf1U8Dt+
P9XVeGNFi1II4FiJYWOnWsjaUHGKdX0ZmiWRhJp7vahH8GOgq1OoPkXUXcq4gE9G
1P8DE17/hENU99UxKcuQ1GgEMMUh0lls00a8HKpVTdpBKqXfpBKMSELpP6S2gy0s
gOiJ/WjgfoSBAwxqa4ef7RfRIPO5jFksxey4i8Dgoiojot48spWMHi58D7vxxiui
ofMp+0q4FUKrhvpzqsjIMdoQl9pBwlewclAvWd0KJD72yuqIlkLjlzeg1ffPHEia
pnM9wyH22Bz9qXsiQ2Lrs0k/Kfn0VYYghd8yPSGuJpNIJm4AmgteBOMJVdCQOIdE
pQ/XINd1aL2pby6SsRVWImfTXsYqKW8cFRLI8K67nJ8mRtui+qiBjxDlxy98i6Dc
XYMekIzigLHmsd5os6BQv7/RHp4hVDtvhsOYk0TTZYzeps4oXLJmsnfRVXrI0rqY
zR7vU4EdHDbq/cGCjogrnX1lHb7vtJQ+FpRvB0AiBTQyGAU32tjpFmFZjesUwbLZ
K6g4g1LXh0buUmgyiWE3R/1U2ZuziewcBhHSH7x1/geI7+NICgjbF5M+hItWEshf
uUaka4fh0d5+zVD0xNSg90VEZ3faJ5imEu0JYLmgJylIa/dAazTxxR1epplTJDOH
jniXnavF3ZvM1z4rfMJh
=Vdsd
-----END PGP SIGNATURE-----

--TQJ1RXgncEldqqG3JXXPILmUer1UDHP3I--
