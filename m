From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 09 Apr 2015 11:34:26 +0000
Subject: Re: simple framebuffer slower by factor of 20, on socfpga (arm) platform
Message-Id: <552663C2.70308@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="eAAmwhGjGNb7ALdNwIiRwXPspkKkgXqVi"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150407121247.GA29497@amd> <CAMuHMdXWRx7bKWhQuWH05CbPTXPy5imCUcW1xUf2E8f7BtF9NQ@mail.gmail.com> <20150409110634.GA27407@amd> <552660C7.4020805@ti.com>
In-Reply-To: <552660C7.4020805@ti.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Marek Vasut <marek.vasut@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, Dinh Nguyen <dinh.linux@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Rob Clark <robdclark@gmail.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, shc_work@mail.ru, linux@arm.linux.org.uk, hsweeten@visionengravers.com, Archit Taneja <architt@codeaurora.org>

--eAAmwhGjGNb7ALdNwIiRwXPspkKkgXqVi
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 09/04/15 14:21, Tomi Valkeinen wrote:
> On 09/04/15 14:06, Pavel Machek wrote:
>> On Tue 2015-04-07 14:19:33, Geert Uytterhoeven wrote:
>>> Hi Pavel,
>>>
>>> On Tue, Apr 7, 2015 at 2:12 PM, Pavel Machek <pavel@ucw.cz> wrote:
>>>> I have an socfpga board, which uses has simple framebuffer implement=
ed
>>>> in the FPGA. On 3.15, framebuffer is fast:
>>>>
>>>> root@wagabuibui:~# time cat /dev/fb0 > /dev/null
>>>> real               0m 0.00s
>>>> user               0m 0.00s
>>>> sys                0m 0.00s
>>>>
>>>> on 3.18, this takes 220msec. Similar slowdown exists for
>>>> writes. Simple framebuffer did not change at all between 3.15 and
>>>> 3.18; resource flags of the framebuffer are still same (0x200).
>>>>
>>>> If I enable caching on 3.18, it speeds up a bit, to 70msec or
>>>> so... Which means problem is not only in caching.
>>>>
>>>> Any ideas?
>>>
>>> My first guess was  commit 67dc0d4758e5 ("vt_buffer: drop console buf=
fer
>>> copying optimisations"), but this was introduced only in v4.0-rc1.
>>>
>>> Just in case you encounter another performance regression after upgra=
ding
>>> to a more modern kernel ;-)
>>
>> :-). I did a git bisect, and it pointed to this. And reverting it
>> indeed fixes the problem in 3.18. Problem is still there in 4.0.

The difference is probably caused by memcpy() vs memcpy_fromio(). The
comment above memcpy_fromio() says "This needs to be optimized". I think
generally speaking memcpy_fromio() is correct for a framebuffer.

That said, if the fb is in RAM, and is only written by the CPU, I think
a normal memcpy() for fb_memcpy_fromfb() should be fine...

 Tomi



--eAAmwhGjGNb7ALdNwIiRwXPspkKkgXqVi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJVJmPCAAoJEPo9qoy8lh71cr4P/RvMdtMg8UoGHbVt+ET2G7et
6GaM7p13VmC/7SYYC7Een3B8fs2KG9SVL024IDyzIcclNUX3PscTnzYoZl0zfjr9
mM8ttOHxBv8J/flL/Pt4DoGlRh9lyEsxZoPucss3cZOOPT0m+C1qktKw5b6K9HbL
TIh9HK2WzWyoFT7ge0CvpCtFmrJF/vwLa5qVZEgDU9JqZBpz/BwK2xVY3IvGAWUh
T0C4orIr6NWEQU0ebx0fW3ue/7IM7/mE5sQ5vYZGDIXnAtM/Z9/c/Bbv0xqdAz2L
lXjPpSg7LHSVgT1ldU3lbxBEqc8Mh6FeOzW8GIhFE5K24fqT12etG0vtob57Gf0r
TwC64HeRZwEI4wvqBeXjsc9SUbfER006tluubQLKXoBMixU4hVd3KUbtbssgu63K
eBl46/fd7ArGzgFkilZkz/hnv20dVcEFs5soiDAplm2CtV2G5jKfqE+jRaGLM1TU
Shlwl4sP8HQd07VHUkfbZhHWVChfeV4ziSWE2Soe0Fek/DNCaGLHhfeOL8b6O6Su
axOKoOEbaL2tkmwvPsJZ185dMz1qIUTq9AGJGU4oNYFQT7UKBHR/RFKYmiVihC5s
C1ikcW715DOobF5Gisf4pB9m9yTwhX9umfHfDtz3l1ypnhmFDCjorTMktquJ8Q/m
YMTpaDKKw9ycIR68k5wJ
=reCY
-----END PGP SIGNATURE-----

--eAAmwhGjGNb7ALdNwIiRwXPspkKkgXqVi--
