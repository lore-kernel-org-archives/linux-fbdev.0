From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 07 Mar 2014 13:08:56 +0000
Subject: Re: [PATCH 0/4] Cleanups and fix for video/pxa3xx-gcu
Message-Id: <5319C4E8.20809@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="jF9spq6eabJV9fQi4HOR3iqUE2N5JKCOH"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394035969-32420-1-git-send-email-zonque@gmail.com>
In-Reply-To: <1394035969-32420-1-git-send-email-zonque@gmail.com>
To: linux-fbdev@vger.kernel.org

--jF9spq6eabJV9fQi4HOR3iqUE2N5JKCOH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/03/14 12:53, Daniel Mack wrote:
> On 03/06/2014 11:30 AM, Tomi Valkeinen wrote:
>> On 06/03/14 12:18, Daniel Mack wrote:
>=20
>>>> That's clearly not the right place for it, but I
>>>> think it's easier to move it along the other files, and later move i=
t
>>>> back to drivers/video/.
>>>
>>> Maybe it might be worth adding a subdirectory for hardware accelerato=
rs?
>>> Because this is what the pxa3xx-gcu thing is all about really. And it=
's
>>> only a tiny transport layer that passed commands between the hardware=

>>> block and a DirectFB userspace driver.
>>
>> Well, there's drivers/gpu/. It sounds like a good match, and by "sound=
s"
>> I mean the word "gpu" sounds like a good match. I'm not sure if other
>> people have opinions on what drivers/gpu/ should contain, though.

I have applied this series to fbdev tree for 3.15.

> Yes, you're right. Do you think we should do that in a 2nd step maybe,
> after 3.15?

Maybe. Then again, drivers/video is not so bad a location, after fbdev
stuff has been moved to drivers/video/fbdev/. drivers/gpu doesn't seem
to have a specific maintainer, but I guess that goes through drm maintain=
er.

 Tomi



--jF9spq6eabJV9fQi4HOR3iqUE2N5JKCOH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTGcToAAoJEPo9qoy8lh71ny0P/3hI4NxBXN9VfdO+PKDga+pr
WsCfTdwWIPGqbQVvld9aPqnAyvAC0o13/QOoTifItyUuHymf22TAnw5dru+4+sdk
2mmov/srqrb/pIblFBOjZ4em4W6fpAuGNbi7GLIe2sy54CqssoKLK4RnLA3vhQhz
ddVZqbIk+bvk85sn7U48pQ7RA+gsCd5ppaxQ83Pt7GH/1rk+q60hLSitZ4YcDXvA
JP5W6clmwOtKTwcjfL7hsNVC6OK3tOYGboOGejZJ42ISIsEy/+wZk2b+SIQEfyF7
I+3cXBd7IdrEAZYZIkOsWyPG1lJTSVgcOcewMh63aflXJ8z/37EWKV0jv8eHv5Os
iq33u3leTqp9Xo7RFA142XTGSvGYs6yfMMgb3vmod60iZQuPAeja2qWjufmtgbJ4
7JXquLnLw0HNVg28d9H2ZlRruoiVKcBs4WNFSlsda4bgDKKAVhsZGBnZLWIGsTk1
Q2sfTxoASZ+5yEmTxXlEnH+nvHbkudZhIjlbHI2lB0X401pbIXgTLEGGAVc1eCrB
jDjx/quy7rVx6itTZkunZYg4FJuHR8cF7zSycwhr+eit35xbpHZ7PppeQcJKkB+j
iVNsGnmqje/UBvuh3UIjHGHs6aGziSpyT8m5EU96vLuHC/0sjd+FwfKtzNqrmISV
RFXviC/9ahXpbbLIPeuQ
=EZCK
-----END PGP SIGNATURE-----

--jF9spq6eabJV9fQi4HOR3iqUE2N5JKCOH--
