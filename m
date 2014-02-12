From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 12 Feb 2014 06:54:40 +0000
Subject: Re: [RFC PATCH] video: Use fb_sys_write rather than open-coding in drivers
Message-Id: <52FB1AB0.6090601@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="EiGS9Psp9HahiMvvinu71CTQbpqdvIls8"
List-Id: <linux-fbdev.vger.kernel.org>
References: <523BF40B.1090002@gmail.com> <52FA2E57.3010300@ti.com> <52FA7509.1060704@gmail.com>
In-Reply-To: <52FA7509.1060704@gmail.com>
To: Ryan Mallon <rmallon@gmail.com>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--EiGS9Psp9HahiMvvinu71CTQbpqdvIls8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/02/14 21:07, Ryan Mallon wrote:
> On 12/02/14 03:06, Tomi Valkeinen wrote:
>=20
>> On 20/09/13 10:06, Ryan Mallon wrote:
>>> Several video drivers open code the fb_write write function with code=

>>> which is very similar to fb_sys_write. Replace the open code versions=

>>> with calls to fb_sys_write. An fb_sync callback is added to each of
>>> the drivers.
>>>    =20
>>> Signed-off-by: Ryan Mallon <rmallon@gmail.com>
>>> ---
>>
>> Doesn't this change the behavior so that fb_write does no longer updat=
e
>> the display, but fb_sync does? I don't think fb_sync is even meant to
>> update the display, it's meant to wait for an update to finish. Then
>> again, I'm not sure about that, all I see in fb.h is "wait for blit
>> idle, optional"
>=20
>=20
> fb_write() in fbmem.c calls ->fb_sync() after ->fb_write(), and I've se=
t
> the fb_sync() for each of the drivers, so the behaviour should be
> unchanged for writes.
>=20
> The fb_sync() function is also called by fb_read() and=20
> fb_get_buffer_offset() (if FB_PIXMAP_SYNC flag is set). I don't know if=

> that will adversely affect behaviour.

Well, by just looking at the function names the drivers' fb_syncs call,
it sounds to me that with your patch fb_sync will update the LCD, i.e.
send data to it. Doing that in fb_read sounds totally wrong.

> Note that I haven't actually tested this code since I don't have any of=

> the hardware. It was just something I noticed while digging through
> framebuffer driver code.

Ok. Well, I think it's safer to drop these, then, if it's not 100% clear
that there are no unwanted side effects.

 Tomi



--EiGS9Psp9HahiMvvinu71CTQbpqdvIls8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS+xqwAAoJEPo9qoy8lh71unsP/ipJYko/gcOPXzbAPUGGTTDJ
FgTIHCOKC4K55HpAobLgTMwGOelJ6mpp2MMV/USg+5mPL4/ux+n6Lo48m3xr1sgl
wKUqRdvugyOJmbe3fhqPfOqsxz0ljYgWp9NMa9XJSJIFDeBu2s6Y/tyGopjOrSEQ
JNIc8p7s6tMn13b+lHuOTyx/ePLAUn8yGEi13BHLC0Mg8c3+BrLEU7iixs1SWMZY
m3xuzYMLJ6IPFNG9b75BP8yVweXfbveEt/+ekvPgAP1r0P4t3i8/kdMALRSRk1rJ
0Y1TfRXOHZqg7/pQuyLh43vmAG2vD+Gdd8PjSH/gnOwRxDTE2JkCTOlFAS/8he2w
MdvG2BeyBuSToduEvgyz5uO4gY8FIcJU+4RdBEQlE6hkmJmL2cnWrmszSmIWgXdO
wdVXwn51oWmzpNO7B7iTQpMwb2CnKlXNk78ROCA/M5Z+ysIDemAxFausAr6FRUgh
FtPaeEFO3D9x6qH/7r3XwqlDn/sn4z5VzzXM/Bu/M4YYUVEbYHWR1+nEac+rDQxw
FzLz9jikNyjL+5vYQhHqjrGjhMbwQtA4ny1JBZOCy4uDFrbT9F4JdPgiklRiHULL
pxRTBgWWw1SQQHw/oRhj1KO7MpmDXwFFywn9L+0KQ9I3t5oysir/V8rJ5UPgXwvP
8PZplz5n0ycoy3LdPsEo
=0k3d
-----END PGP SIGNATURE-----

--EiGS9Psp9HahiMvvinu71CTQbpqdvIls8--
