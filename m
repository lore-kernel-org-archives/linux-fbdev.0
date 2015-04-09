From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 09 Apr 2015 11:21:43 +0000
Subject: Re: simple framebuffer slower by factor of 20, on socfpga (arm) platform
Message-Id: <552660C7.4020805@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="3klL8TUgUQAx1OM5PUfjFXGi7sabpi9XR"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150407121247.GA29497@amd> <CAMuHMdXWRx7bKWhQuWH05CbPTXPy5imCUcW1xUf2E8f7BtF9NQ@mail.gmail.com> <20150409110634.GA27407@amd>
In-Reply-To: <20150409110634.GA27407@amd>
To: Pavel Machek <pavel@ucw.cz>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Marek Vasut <marek.vasut@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, Dinh Nguyen <dinh.linux@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Rob Clark <robdclark@gmail.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, shc_work@mail.ru, linux@arm.linux.org.uk, hsweeten@visionengravers.com, Archit Taneja <architt@codeaurora.org>

--3klL8TUgUQAx1OM5PUfjFXGi7sabpi9XR
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 09/04/15 14:06, Pavel Machek wrote:
> On Tue 2015-04-07 14:19:33, Geert Uytterhoeven wrote:
>> Hi Pavel,
>>
>> On Tue, Apr 7, 2015 at 2:12 PM, Pavel Machek <pavel@ucw.cz> wrote:
>>> I have an socfpga board, which uses has simple framebuffer implemente=
d
>>> in the FPGA. On 3.15, framebuffer is fast:
>>>
>>> root@wagabuibui:~# time cat /dev/fb0 > /dev/null
>>> real               0m 0.00s
>>> user               0m 0.00s
>>> sys                0m 0.00s
>>>
>>> on 3.18, this takes 220msec. Similar slowdown exists for
>>> writes. Simple framebuffer did not change at all between 3.15 and
>>> 3.18; resource flags of the framebuffer are still same (0x200).
>>>
>>> If I enable caching on 3.18, it speeds up a bit, to 70msec or
>>> so... Which means problem is not only in caching.
>>>
>>> Any ideas?
>>
>> My first guess was  commit 67dc0d4758e5 ("vt_buffer: drop console buff=
er
>> copying optimisations"), but this was introduced only in v4.0-rc1.
>>
>> Just in case you encounter another performance regression after upgrad=
ing
>> to a more modern kernel ;-)
>=20
> :-). I did a git bisect, and it pointed to this. And reverting it
> indeed fixes the problem in 3.18. Problem is still there in 4.0.

Interesting. I can reproduce this also on TI's AM437x board, on 3.14
kernel. Without the patch:

# time cat /dev/fb0 > /dev/null
real    0m 0.01s
user    0m 0.00s
sys     0m 0.01s

With the patch:

# time cat /dev/fb0 > /dev/null
real    0m 0.19s
user    0m 0.01s
sys     0m 0.17s

> Archit do you know what is going on there? Should the revert be filled
> for 4.0?

(Cc'ing Archit's new email)

>=20
> 								Pavel
>=20
> commit 981409b25e2a99409b26daa67293ca1cfd5ea0a0
> Author: Archit Taneja <archit@ti.com>
> Date:   Fri Nov 16 14:46:04 2012 +0530
>=20
>     fbdev: arm has __raw I/O accessors, use them in fb.h
>=20
>     This removes the sparse warnings on arm platforms:
>=20
>     warning: cast removes address space of expression
>=20
>  Signed-off-by: Archit Taneja <archit@ti.com>
>  Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>  Cc: H Hartley Sweeten <hsweeten at visionengravers.com>
>  Cc: Alexander Shiyan <shc_work@mail.ru>
>  Cc: Russell King <linux@arm.linux.org.uk>



--3klL8TUgUQAx1OM5PUfjFXGi7sabpi9XR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJVJmDIAAoJEPo9qoy8lh7162wP/1X12Y94WLtpvOX6zuG35m4K
sKl9lyefh8hBGrSYXGjLrgYVaAAwZjzCTJDGdz83h5DGV2g0Uytie4bArxFR3ipf
h9ju/RB9O6TvLmUhybZG8T5PLpunCzAVo7776oCtlTx7UgwfVCa1exqDL4/DeFVA
nncxUynFdiPGB+VRTC3hiuoqGQz+I14YM0V0FcTdNDV61W5SQ5Rzh4kJon0B+4hB
mH0e2uKbmB2DFBU5tq/Jckq04E8vhAk/IiwRgsdrEmpwDvrKGbNgN03sjwBht1sy
UHU/x7+2xeprXdGonQ9G1/6XmN3U/QKcB47NToeoBm98JSiXLUl7o04+TVYE6IHP
gOQldjMqrh75E0FfUrwRlAzO/TZcXn32nLhB6RoIWmn+HcBGJdhsgz5aty93JJDO
byE150Yh1SQxsIpm8D1KjRyywcsA3GgHh7vQUJyE/AqBNJIqvBo7PibaZy4PUcUg
BpYPYAUgKv3lQ2qyCI1orIv3KHI6Za42Zlmx/FHQAiUYKm0I2Rb4s/us5XjJdYI6
W1tqRvatK45SKaIG3mAGbH7cLPN5QVQ2E0i1wgJ8jpqWIq4pRTYIqUYsmSuyPLw+
EYUPRIarkm36fyV7QHV3aQEL5p409HSwzReT6ncMjltuW302jYOju5upI33ctKU/
OhXPY4eOyuUcsShNC9Th
=dgVT
-----END PGP SIGNATURE-----

--3klL8TUgUQAx1OM5PUfjFXGi7sabpi9XR--
