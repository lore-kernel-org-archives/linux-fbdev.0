From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 30 Aug 2013 10:19:19 +0000
Subject: Re: [PATCH] drivers: video: i740fb: add 'default' processing contents for 'switch'.
Message-Id: <522071A7.4080405@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="61A7tqIfpFXE8eHIArDXAs1TfhsRTi6nW"
List-Id: <linux-fbdev.vger.kernel.org>
References: <51ECF12D.8060903@asianux.com>
In-Reply-To: <51ECF12D.8060903@asianux.com>
To: linux-fbdev@vger.kernel.org

--61A7tqIfpFXE8eHIArDXAs1TfhsRTi6nW
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 30/08/13 12:45, Chen Gang wrote:
> On 08/30/2013 05:16 PM, Tomi Valkeinen wrote:

>> So, in my opinion:
>>
>> - Normally we should presume the the stack is not corrupted, or
>> otherwise we'll end up with lots of checks all over.
>>
>=20
> It seems the above reply "Hmm... it really has quite a few same cases
> ..." is suitable for discussing with your opinion.

Well, if other drivers do silly things, it's no reason to do it here also=
=2E

>=20
>> - Even if i740_calc_fifo() is a static function, and we can analyze th=
e
>> _current_ situation, we don't know how the driver will evolve in the f=
uture.
>>
>=20
> For normal static function (not callback function) it can be in control=

> within inside (ourselves), don't like extern function, it is out of
> control with inside.
>=20
> So we can assume something in the future.

We can assume that only if we presume that the future changes are
bug-free. But more often than not there are bugs in the kernel drivers.

Now, say, if such a bug is introduced, and somebody is running the
kernel in a remote server, the driver will call BUG(). This will cause
the server to halt. The user won't see what happened, the connections
are just lost and the error is not written to a hard disk.

If, instead, the driver would do WARN, and continue or fail in a
controlled manner, the user can find out about the issue easily. Even if
there is a stack corruption, it's most likely the driver in question
that has it, and thus not really fatal.

Sure, there's the possibility that there's a bigger memory corruption,
which would go unnoticed by, say, the filesystem layer, resulting in a
corrupted filesystem. And we would catch this corruption by checking the
bpp variable. But, really, I find that very unlikely scenario.

Here's some old discussion about BUG:

http://yarchive.net/comp/linux/BUG.html

 Tomi



--61A7tqIfpFXE8eHIArDXAs1TfhsRTi6nW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSIHGnAAoJEPo9qoy8lh71PREP/2+ZHLi97D9yujtAd3LmQw9U
uVZGFEcQOmjZrsgZW6arclRXtzwyWskBpFqhWud9VQ2lg9kW4l3Kcles4wG3Xo2P
jNeE0vAZ1UjKVz8S2NsOMIx07JhakWNKZmH+ghwVvzhqxZJ5g62EinZ6ps8rBVyw
HLJ9DlpuHmuL2dkt0YDMvUtO9jSeUVQebUlf7r6sBubISYZ9114R0Kl0J0QBcqSA
Z1IwqFH3WNoJy+QRa9sgClYTzGdijvI82WuqsaEgQYEMDkVK36TybTuUVLOEy1e4
mAIpRDVVpxBPq0jj4Xc5OQmhDoojaVmqnWjM6H9qrAmuWm0E9F9RB46UpbyDBG4Q
/BUzRVNar/kiw7vfmUUBk93DcWfrC2aPxOkkZmHYtIn6Y7PHQYq62Vj7ubVV8YmU
WMIDE9EkCAWO1yfRK540Q6kFa/H/AQC4QfMFgSr4g0jacPYo3UcA9C7aAm9wxNKM
3CEfOfwcX8NJ7Pd9h04PvCE/UQDNXSzAILbbcRlXby0P4XFsqyX6hSWfd/fuf3yN
1l6MTRAWqqiCCkFTfgQRRTjDcfaloz7gCvOHHS+uHfbDRwJsVBOH1jRv2qDBttPU
uxKSmI2tNBqz039ZK5kiYgeZEvFqOUIjZseJO+ww+cnYcIAJiQLQa3yWP/6fXhVg
oTBHLIVV0t77H0IeyIga
=Ttka
-----END PGP SIGNATURE-----

--61A7tqIfpFXE8eHIArDXAs1TfhsRTi6nW--
