From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 30 Aug 2013 08:36:18 +0000
Subject: Re: [PATCH] drivers: video: i740fb: add 'default' processing contents for 'switch'.
Message-Id: <52205982.7010907@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="gWgKTi6llSGHOi4AjUcRw0hmxsVFmEshU"
List-Id: <linux-fbdev.vger.kernel.org>
References: <51ECF12D.8060903@asianux.com>
In-Reply-To: <51ECF12D.8060903@asianux.com>
To: linux-fbdev@vger.kernel.org

--gWgKTi6llSGHOi4AjUcRw0hmxsVFmEshU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 30/08/13 11:17, Chen Gang wrote:
> On 08/30/2013 03:21 PM, Tomi Valkeinen wrote:

>> I don't think you should use BUG there. BUG should be used when there'=
s
>> not really a good way to continue. Here you could have just a WARN, an=
d
>> return some default FIFO watermark value.
>>
>=20
> i740_calc_fifo() is a static function, so we can check its caller's
> information to find the suitable fixing ways (for extern function, we
> almost can not do like this).
>=20
> it has only one caller i740fb_decode_var(), which has already let 'bpp'=

> within the values (8, 15, 16, 24, 32). So if another values occurs, it
> must be a BUG (e.g. the stack may override under ia32).

My point was that there should almost never be need for BUG in a normal
driver. BUG means that the whole kernel will probably halt. Even if an
fb driver encounters a problem that should never happen, it should maybe
give a WARN, and continue or fail in a controlled manner.

 Tomi



--gWgKTi6llSGHOi4AjUcRw0hmxsVFmEshU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSIFmCAAoJEPo9qoy8lh71hcUP/0ixSbAV+BJwmBO4JX5khnsg
dcAmCoyiX/y/yUeZ3Pfk1eHd7JmngmYNfb/bdoLDLwyK6cWu1sA2scI6/dfK1gR0
QScJDAf4Hw7iiLDqjs4YPCoM8jzFFHhfHkaYZpcx+N5H+KduTm6BFA66i8tg9BWV
t1dGVNyNZiXPR/3yn2QGYvc5GtJxoNRkeiBbgOUR/m4PynPhP35O/RqOh6pNHP9g
PaK99dHEhp+vD2WQ2SH/oaYnGeWtcjboDvnsaUfAaQRlucH9V9DipTCZ37urCaLI
j8RyzsY7y5jNbpGQBgMzgGc7FKEnXRUbn+Iun89RDsbC/4dr7uYj8owldA7ppUHo
JO+YnYQYnyqghhNJqf1OqJNxcs5OY4aYUOtpbxJ3ks8P/JWKGeW3MzXpuWwQgS0D
zo+cNXUT2LtbrKOcxiEbV88P5OgcDqnnbW4FtNK/Se95Lh1TfUbn1uQLgsmyM1aL
NEpn0PB+oUE041TWUttWxCP+ORL1D3v2WsnoIC4R93qcVQwGhsxG8o09GKgClUsv
nMDm+v1gAq+nNWo8xopyNU1v+85fuhRf9wbbJm+mcX5ch4tPnb9XyrkBqFyR8hLx
AT+d0lv6xQjFkr7hQeNQVzOORh5ZU9LPoDn21phcLojrwFfJccvewEIT4qVqpjgY
TBYAzl7aj99/BnAz1cwA
=S6oP
-----END PGP SIGNATURE-----

--gWgKTi6llSGHOi4AjUcRw0hmxsVFmEshU--
