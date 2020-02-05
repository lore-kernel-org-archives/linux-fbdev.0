From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Date: Wed, 05 Feb 2020 18:19:08 +0000
Subject: Re: [PATCH 1/3] fbdev/g364fb: Fix build failure
Message-Id: <08447d52-0007-6f68-3848-209295a61d13@amsat.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1580610812.git.fthain@telegraphics.com.au>
 <d8f19ebc00a7688da739d41d584d081d1559f0d2.1580610812.git.fthain@telegraphics.com.au>
 <CAAdtpL7SpzfqSmEcuVszNyXfrRegC20txoS5j7Ss3WkCmyRH+g@mail.gmail.com>
In-Reply-To: <CAAdtpL7SpzfqSmEcuVszNyXfrRegC20txoS5j7Ss3WkCmyRH+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Finn Thain <fthain@telegraphics.com.au>
Cc: linux-fbdev@vger.kernel.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Burton <paulburton@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, James Hogan <jhogan@kernel.org>, open list <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, Thomas Bogendoerfer <tbogendoerfer@suse.de>, dri-devel@lists.freedesktop.org, Laurent Vivier <laurent@vivier.eu>

On 2/5/20 7:02 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On Sun, Feb 2, 2020 at 3:41 AM Finn Thain <fthain@telegraphics.com.au> wr=
ote:
>>
>> This patch resolves these compiler errors and warnings --
>>
>>   CC      drivers/video/fbdev/g364fb.o
>> drivers/video/fbdev/g364fb.c: In function 'g364fb_cursor':
>> drivers/video/fbdev/g364fb.c:137:9: error: 'x' undeclared (first use in =
this function)
>> drivers/video/fbdev/g364fb.c:137:9: note: each undeclared identifier is =
reported only once for each function it appears in
>> drivers/video/fbdev/g364fb.c:137:7: error: implicit declaration of funct=
ion 'fontwidth' [-Werror=3Dimplicit-function-declaration]
>> drivers/video/fbdev/g364fb.c:137:23: error: 'p' undeclared (first use in=
 this function)
>> drivers/video/fbdev/g364fb.c:137:38: error: 'y' undeclared (first use in=
 this function)
>> drivers/video/fbdev/g364fb.c:137:7: error: implicit declaration of funct=
ion 'fontheight' [-Werror=3Dimplicit-function-declaration]
>> drivers/video/fbdev/g364fb.c: In function 'g364fb_init':
>> drivers/video/fbdev/g364fb.c:233:24: error: 'fbvar' undeclared (first us=
e in this function)
>> drivers/video/fbdev/g364fb.c:234:24: error: 'xres' undeclared (first use=
 in this function)
>=20
> 18 years unnoticed...
>=20
>> drivers/video/fbdev/g364fb.c:201:14: warning: unused variable 'j' [-Wunu=
sed-variable]
>> drivers/video/fbdev/g364fb.c:197:25: warning: unused variable 'pal_ptr' =
[-Wunused-variable]
>>
>> The MIPS Magnum framebuffer console now works when tested in QEMU.
>>
>> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>=20
> This commit is the kernel 'git origin' import, not the proper reference.
>=20
> The actual change is between v2.5.17/2.5.19:
> https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/diff/dri=
vers/video/g364fb.c?id=B30e6e183a728923267
> Date: 2002-05-22 07:52:33...
>=20
> The same commit introduced the changes in g364fb_cursor(), which was
> implemented previous to v2.4.0 so it is hard to follow from there.
>=20
> Nobody complains during 18 years so I doubt anyone care that
> g364fb_cursor() is removed.
> And by removing it, you improve the kernel quality, so:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> (Maybe remove the unhelpful 'Fixes' tag).
>=20
>> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
>> ---
>>  drivers/video/fbdev/g364fb.c | 29 +++--------------------------
>>  1 file changed, 3 insertions(+), 26 deletions(-)

Note, you need to rebase your series due to:

  commit 8a48ac339398f21282985bff16552447d41dcfb2
  Author: Jani Nikula <jani.nikula@intel.com>
  Date:   Tue Dec 3 18:38:50 2019 +0200

      video: constify fb ops across all drivers
