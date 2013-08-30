From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 30 Aug 2013 09:16:53 +0000
Subject: Re: [PATCH] drivers: video: i740fb: add 'default' processing contents for 'switch'.
Message-Id: <52206305.1060603@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="loGiK6OBb6HETlVsFBpVCQh0LMeBC81SK"
List-Id: <linux-fbdev.vger.kernel.org>
References: <51ECF12D.8060903@asianux.com>
In-Reply-To: <51ECF12D.8060903@asianux.com>
To: linux-fbdev@vger.kernel.org

--loGiK6OBb6HETlVsFBpVCQh0LMeBC81SK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 30/08/13 11:44, Chen Gang wrote:
> On 08/30/2013 04:36 PM, Tomi Valkeinen wrote:
>> On 30/08/13 11:17, Chen Gang wrote:
>>> On 08/30/2013 03:21 PM, Tomi Valkeinen wrote:
>>
>>>> I don't think you should use BUG there. BUG should be used when ther=
e's
>>>> not really a good way to continue. Here you could have just a WARN, =
and
>>>> return some default FIFO watermark value.
>>>>
>>>
>>> i740_calc_fifo() is a static function, so we can check its caller's
>>> information to find the suitable fixing ways (for extern function, we=

>>> almost can not do like this).
>>>
>>> it has only one caller i740fb_decode_var(), which has already let 'bp=
p'
>>> within the values (8, 15, 16, 24, 32). So if another values occurs, i=
t
>>> must be a BUG (e.g. the stack may override under ia32).
>>
>> My point was that there should almost never be need for BUG in a norma=
l
>> driver. BUG means that the whole kernel will probably halt. Even if an=

>> fb driver encounters a problem that should never happen, it should may=
be
>> give a WARN, and continue or fail in a controlled manner.
>>
>=20
> e.g when the stack is override under ia32, it is better to stop continu=
e
> as soon as possible to try to avoid the kernel continue blindly, that
> may let the coredump/KDB analyzers' work much easier.
>=20
> Hmm... when driver cause issue, it has effect with the whole kernel
> (kernel may die soon), so BUG() is used under the whole kernel wide
> (include normal drivers).

You want i740_calc_fifo() to check the bpp parameter and issue a BUG if
it's not a valid bpp-value, because in the current driver
i740_calc_fifo() is never called with a non-valid bpp, and thus a wrong
bpp indicates a stack corruption?

How about the freq parameter? In the current driver freq can never be
higher than 1000000. If it is, it's stack corruption. Maybe there should
be a BUG for that case also?

As I see it, you're just checking a single arbitrary value in an
arbitrary place in the driver, and protecting against stack corruption
there. Why not check all the values in all the functions of the driver
as well, looking for stack corruptions?

And the bigger issue is that you're only talking about the current
driver. The driver could be changed tomorrow, maybe calling
i740_calc_fifo() from some other place, where a wrong bpp could just
possibly happen. In that case it wouldn't be a stack corruption, but a
"normal" driver bug.

So, in my opinion:

- Normally we should presume the the stack is not corrupted, or
otherwise we'll end up with lots of checks all over.

- Even if i740_calc_fifo() is a static function, and we can analyze the
_current_ situation, we don't know how the driver will evolve in the futu=
re.

 Tomi



--loGiK6OBb6HETlVsFBpVCQh0LMeBC81SK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSIGMFAAoJEPo9qoy8lh71e7wP/j+XbduaxbrQsyCpHf+5xJCG
K7JIpgQow6uBVCoxHTSWlBOqm3OcqhOf7J7zbsmR+d4cNjxQNPndniIcqcQM60sl
ZAjERclsNqwquJtOp7dKboF0sLirXqsrqmXWaqMG+llLclUIjbdUR7eGK5h8ACQG
P+jXdcF+OAI4YUZaOD8tq+Pu6VXEuZjXyARPCuqtbLpA3O1M/CzO2i5UrdkPW/xX
Z2NGBxNExqQIXZD+RVKbi5aITg464VItolGEHv3oEuSubnWO22kACssx2Tmq9RNB
Hd33kYihAYPA5LQEQj+g0toBP2QCsUePDgGmdKzFAYaUrU365ytUDyBZcpOqSDyw
xIWK3792UnmgHgD9wLWSpz97yGH8l1sTwFjvvYpTdrwNcJSCjDS6Rxs7QQSU37su
d2As5FgGpJdbyOpeBKexNMQnbWd8WZ32LACVe7RJ+WXkd38J9iON/CwXY9+L6Wuf
WV9pur3AW90F0loUYhM6NFMUPMKuUuHK7Xjw71GwJ4CCzsW/XLBybyFPGFAZLKdl
7EmEvkWhq8nd4Mwvyr2NemhjxGTvy6enpcGzfClXzBcVSCY3aPKfawmQ7rUp2hfR
Dg7etddHTfMdlItJnhhsrLiYCOqiKTMuQ0ziNp2ygnBvppqeJMxYhGqd9qxoAAp1
lrIHbt4xKuPVyvun4gZg
=TMd/
-----END PGP SIGNATURE-----

--loGiK6OBb6HETlVsFBpVCQh0LMeBC81SK--
