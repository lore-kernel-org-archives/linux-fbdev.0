From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 21 Mar 2014 14:07:50 +0000
Subject: Re: [PATCH] drivers/video: fix mb862xx_i2c depends issue build failure
Message-Id: <532C47B6.70106@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="r5f8iUxr2vWlQ8WUx9wSnjx2oHM83NRRg"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1395328560-48497-1-git-send-email-paul.gortmaker@windriver.com> <532C3F64.2020601@ti.com> <532C4476.2030706@windriver.com>
In-Reply-To: <532C4476.2030706@windriver.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jim Davis <jim.epost@gmail.com>, Fengguang Wu <fengguang.wu@intel.com>

--r5f8iUxr2vWlQ8WUx9wSnjx2oHM83NRRg
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 21/03/14 15:53, Paul Gortmaker wrote:
> On 14-03-21 09:32 AM, Tomi Valkeinen wrote:
>> Hi,
>>
>> On 20/03/14 17:16, Paul Gortmaker wrote:
>>> Any randconfig that sets I2C=3Dm and FB_MB862XX_I2C=3Dy will
>>> encounter a final link failure that looks like this:
>>
>> It compiles fine with I2C=3Dm, FB_MB862XX=3Dm and FB_MB862XX_I2C=3Dy.
>>
>>> drivers/built-in.o: In function `mb862xx_i2c_init':
>>> drivers/video/mb862xx/mb862xx-i2c.c:165: undefined reference to `i2c_=
add_adapter'
>>> drivers/built-in.o: In function `mb862xx_i2c_exit':
>>> drivers/video/mb862xx/mb862xx-i2c.c:176: undefined reference to `i2c_=
del_adapter'
>>>
>>> Since FB_MB862XX_I2C is a bool and not tristate, simply
>>> don't offer it at all if core I2C support is not built in.
>>
>> FB_MB862XX_I2C is not a driver, it just adds the i2c support to
>> FB_MB862XX. The relevant thing is whether FB_MB862XX is m or y, so
>> compiling with:
>>
>> I2C=3Dm, FB_MB862XX=3Dy and FB_MB862XX_I2C=3Dy
>>
>> will fail.
>=20
> How would you suggest we fix it then?  Perhaps we could simplify the
> Kconfig space and just get rid of FB_MB862XX_I2C entirely?  Is there
> ever a reason why someone would want it turned off when I2C is present?=


I'm not familiar with the driver and devices that use it, so I can't
really say. But you could probably have a board with the FB_MB862XX,
without i2c displays, while still you'd have I2C for other uses. So
there you could minimally reduce the kernel size by leaving out the
FB_MB862XX_I2C.

I'm fine with that solution, though. But how would it work in practice?
Did you mean that FB_MB862XX would depend on I2C? That's not a good
option, but how would you otherwise make the i2c dependency correct?

Actually, I'm fine with the original patch also, as I believe the case
where I2C=3Dm is somewhat theoretical (correct me if I'm wrong). But the
patch description was totally wrong, and if that solution is preferred,
it should also clearly state that the patch prevents the I2C support
when I2C is built as a module. But I think your proposal in this mail is
better.

Maybe there are even better ways to handle it in the Kconfig, as such
"add feature X to the driver" sounds quite common to me.

 Tomi



--r5f8iUxr2vWlQ8WUx9wSnjx2oHM83NRRg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTLEe2AAoJEPo9qoy8lh71t0AP/3ASgiLwo2DwIj4gWJ1gQINl
oHj7wpY9nGEkv4qMO58B6DiX6JDpjafsFpAznX8GcH5J42pAh5EXU4uJGyTCriWm
H/lk0FK7xiz1abYWuVevPuT5posuaRUwlTX6zLerhu+QHmYEgkAHw8BM4mFnY2Dg
zyp9qQXCfp2sJ7epG4wPc6VDBfkfYK7myjBVae2O9cWksEOk8uoWzxplFZXz3FP2
Z1c/04QYFLeEiCPXYPHRUJLvHhwqABxuv3lB+U4L1pbS1uKOVeIUS+G1cNIGfJJb
0w5+d3PFjy6mJPp2m8KYI9/AAvmJzPendjwH5tsPXDlxS4gqzkKgIfYnBm0hw93v
bu8Y8k6r53rjkjwuG77u3aLavGZaFh63ILMDBHkzdfRINsF2jBfIMwg8iKQLpzJ+
flNsVL2UwATJzoDiHGrTMMnzg5oBDI9TrIjfoZBE5bCjmmq0QRUqkOu3triGiqZq
q/sIbLveAN0uGu1CsZq04P8EyWH1h3GcmK6/yeuznTvMRWPtR4PNhubvjlCovZ3P
cum9k+beiiwcw+1NnWzKNMlMvoHsVqAUmTxboED10tcbP5nPkP6ImmSArWaGtv7L
l/9VJRG1eydGDJdVqn+HApMAgs+iHCCtiHLJDI7nuWrx9EA9tpNguHeftDQYTMVN
lPBTEQwQ/2fTuMRRHkfL
=zjXF
-----END PGP SIGNATURE-----

--r5f8iUxr2vWlQ8WUx9wSnjx2oHM83NRRg--
