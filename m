From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 10 Mar 2015 10:45:49 +0000
Subject: Re: [PATCH 5/8] fbdev: ssd1307fb: Add module parameter bitsperpixel.
Message-Id: <54FECB5D.1020908@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8NO6pTL33IeoXnGo4GfPvXRQQotUmMtMn"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de> <1423261694-5939-6-git-send-email-niederp@physik.uni-kl.de> <20150207112043.GO2079@lukather> <20150207170503.045490aa@maestro.intranet> <20150214155415.GC25269@lukather>
In-Reply-To: <20150214155415.GC25269@lukather>
To: Maxime Ripard <maxime.ripard@free-electrons.com>, =?windows-1252?Q?Thomas_Niederpr=FCm?= <niederp@physik.uni-kl.de>
Cc: linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, linux-kernel@vger.kernel.org

--8NO6pTL33IeoXnGo4GfPvXRQQotUmMtMn
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 14/02/15 17:54, Maxime Ripard wrote:
> On Sat, Feb 07, 2015 at 05:05:03PM +0100, Thomas Niederpr=FCm wrote:
>> Am Sat, 7 Feb 2015 12:20:43 +0100
>> schrieb Maxime Ripard <maxime.ripard@free-electrons.com>:
>>
>>> On Fri, Feb 06, 2015 at 11:28:11PM +0100, niederp@physik.uni-kl.de
>>> wrote:
>>>> From: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>
>>>>
>>>> This patch adds a module parameter 'bitsperpixel' to adjust the
>>>> colordepth of the framebuffer. All values >1 will result in memory
>>>> map of the requested color depth. However only the MSB of each
>>>> pixel will be sent to the device. The framebuffer identifies itself
>>>> as a grayscale display with the specified depth.
>>>
>>> I'm not sure this is the right thing to do.
>>>
>>> The bits per pixel for this display is rightfully defined, used and
>>> reported to the userspace, why would you want to change that?
>>
>> You are right of course. The display is 1bpp and it reports to be 1
>> bpp. The problem is that there is almost no userspace library that can=

>> handle 1 bit framebuffers correctly. So it is nice if the framebuffer
>> (optionally) can expose itself as 8 bits per pixel grayscale to the
>> userspace program. As an example this allows to run DirectFB on the
>> framebuffer, which is not possible out of the box for 1bpp.
>>
>> Also note that if do not set the module parameter at load time
>> the framebuffer will be 1bpp. So you have to actively set that module
>> parameter to make the framebuffer pretend to be more than 1bpp.
>>
>> In any case I don't cling to that patch, I just thought it was a nice
>> feature.
>=20
> I'd say that the right fix would be to patch DirectFB, instead of
> faking that in the kernel.
>=20
> But again, that's probably Tomi's call, not mine.

Right, I'm not thrilled =3D). I don't think it's a good idea to lie to th=
e
userspace (except when fixing regressions).

 Tomi



--8NO6pTL33IeoXnGo4GfPvXRQQotUmMtMn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU/stdAAoJEPo9qoy8lh71FKQQAKYv5frUA9ZKCQSBJd3digNv
MGA7tZFjit73tfD4PC3ozZCZOqAu2HeLPkq8wdEU23v+UooeC50b4g820b2AKeEM
uTWKS3wxb1QWKCw7coLcp173bDGCpleu8AOcFyC5L6wkiShTJHcqZxiBLjJorIci
4Go5hxdOO73Psxw4TfxzG6Dp73wlzRs47Dvm4zZIrbPMlupX9mB/UDBgckbaAjZq
nu0cr4aw9qk3keZFWfeSuiJHKZixWxarhBFIK1SCv4N5TIilbF5ELT2eliu+GfD4
mXsiVvxKNIwnm7bLJzu02MfrPmf1bqrydCxwidIGHoFApGbfZ0RaA/mOGoOKYaZx
BWlC09IITzWLbVsyL6trwJD/JmOMoMCyfOgC76KkI9dmn7448l12OU36s5wF8fsL
l/E2ra3dj41OwEyOzV7oOzUHLzQNLrjn2PSMrqpf/TV/eQ1/v+jFk2sIM/kVesei
pp7Rj/ZvHwRSgr0ojuTcjwSMhIoA4YHJqkxr4DfNuF+ktikCG1IXPtTDIh1hKH+r
E8TJJNPRH36O1tW/NZq/g75Mk7DtgkWeokDXmeerMGywJUNFsg7ynflIZ5HGMalO
/s7TLA/eSO1N8fKfRTnqd7r1R4zojCq0VGEkD6le9eqQOTRQZICTfyMlvzNd2Ynv
b5gV5QZYGWNeHdbz3R2X
=1Yl7
-----END PGP SIGNATURE-----

--8NO6pTL33IeoXnGo4GfPvXRQQotUmMtMn--
