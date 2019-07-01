From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 01 Jul 2019 15:07:23 +0000
Subject: Re: [PATCH 3/3] video: fbdev: don't print error message on framebuffer_alloc() failure
Message-Id: <6e21ef05-9239-de09-4252-320b437297fa@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190614145128eucas1p2783e7d644ef8823d211896298e8988fc@eucas1p2.samsung.com>
 <3da197ed-a701-2aa7-d775-2bdbe9deab4a@samsung.com>
 <CAO-hwJJFKQEwEiDe1M6gP5D_yf0BxyzaJH-kxwxqkCVo52WK6g@mail.gmail.com>
In-Reply-To: <CAO-hwJJFKQEwEiDe1M6gP5D_yf0BxyzaJH-kxwxqkCVo52WK6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-fbdev@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons@linux-vserver.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>


On 7/1/19 10:37 AM, Benjamin Tissoires wrote:
> Hi Bartlomiej,

Hi Benjamin,

> On Fri, Jun 14, 2019 at 4:52 PM Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
>>
>> framebuffer_alloc() can fail only on kzalloc() memory allocation
>> failure and since kzalloc() will print error message in such case
>> we can omit printing extra error message in drivers (which BTW is
>> what the majority of framebuffer_alloc() users is doing already).
>>
>> Cc: "Bruno Pr=C3=A9mont" <bonbons@linux-vserver.org>
>> Cc: Jiri Kosina <jikos@kernel.org>
>> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> ---
>>  drivers/hid/hid-picolcd_fb.c                   |    4 +---
>>  drivers/video/fbdev/amifb.c                    |    4 +---
>>  drivers/video/fbdev/arkfb.c                    |    4 +---
>>  drivers/video/fbdev/atmel_lcdfb.c              |    4 +---
>>  drivers/video/fbdev/aty/aty128fb.c             |    5 ++---
>>  drivers/video/fbdev/aty/atyfb_base.c           |   10 ++++------
>>  drivers/video/fbdev/aty/radeon_base.c          |    2 --
>>  drivers/video/fbdev/chipsfb.c                  |    1 -
>>  drivers/video/fbdev/cirrusfb.c                 |    5 +----
>>  drivers/video/fbdev/da8xx-fb.c                 |    1 -
>>  drivers/video/fbdev/efifb.c                    |    1 -
>>  drivers/video/fbdev/grvga.c                    |    4 +---
>>  drivers/video/fbdev/gxt4500.c                  |    5 ++---
>>  drivers/video/fbdev/hyperv_fb.c                |    4 +---
>>  drivers/video/fbdev/i740fb.c                   |    4 +---
>>  drivers/video/fbdev/imsttfb.c                  |    5 +----
>>  drivers/video/fbdev/intelfb/intelfbdrv.c       |    5 ++---
>>  drivers/video/fbdev/jz4740_fb.c                |    4 +---
>>  drivers/video/fbdev/mb862xx/mb862xxfbdrv.c     |    5 +----
>>  drivers/video/fbdev/mbx/mbxfb.c                |    4 +---
>>  drivers/video/fbdev/omap/omapfb_main.c         |    2 --
>>  drivers/video/fbdev/omap2/omapfb/omapfb-main.c |    6 +-----
>>  drivers/video/fbdev/platinumfb.c               |    5 ++---
>>  drivers/video/fbdev/pmag-aa-fb.c               |    4 +---
>>  drivers/video/fbdev/pmag-ba-fb.c               |    4 +---
>>  drivers/video/fbdev/pmagb-b-fb.c               |    4 +---
>>  drivers/video/fbdev/pvr2fb.c                   |    6 +-----
>>  drivers/video/fbdev/riva/fbdev.c               |    1 -
>>  drivers/video/fbdev/s3c-fb.c                   |    4 +---
>>  drivers/video/fbdev/s3fb.c                     |    4 +---
>>  drivers/video/fbdev/sh_mobile_lcdcfb.c         |    8 ++------
>>  drivers/video/fbdev/sm501fb.c                  |    4 +---
>>  drivers/video/fbdev/sm712fb.c                  |    1 -
>>  drivers/video/fbdev/smscufx.c                  |    4 +---
>>  drivers/video/fbdev/ssd1307fb.c                |    4 +---
>>  drivers/video/fbdev/sunxvr1000.c               |    1 -
>>  drivers/video/fbdev/sunxvr2500.c               |    1 -
>>  drivers/video/fbdev/sunxvr500.c                |    1 -
>>  drivers/video/fbdev/tgafb.c                    |    4 +---
>>  drivers/video/fbdev/udlfb.c                    |    4 +---
>>  drivers/video/fbdev/via/viafbdev.c             |    6 +-----
>>  drivers/video/fbdev/vt8623fb.c                 |    4 +---
>>  42 files changed, 40 insertions(+), 123 deletions(-)
>>
>> Index: b/drivers/hid/hid-picolcd_fb.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D>> --- a/drivers/hid/hid-picolcd_fb.c
>> +++ b/drivers/hid/hid-picolcd_fb.c
>> @@ -522,10 +522,8 @@ int picolcd_init_framebuffer(struct pico
>>                         sizeof(struct fb_deferred_io) +
>>                         sizeof(struct picolcd_fb_data) +
>>                         PICOLCDFB_SIZE, dev);
>> -       if (info =3D NULL) {
>> -               dev_err(dev, "failed to allocate a framebuffer\n");
>> +       if (!info)
>>                 goto err_nomem;
>> -       }
>=20
> It would have been better to split this change as the HID and fbdev
> are different trees.

Ah, there are no modifications to framebuffer_alloc() itself so changes
are independent. I should have noticed that earlier, sorry about that..

> However, I do not expect a conflict here (there hasn't been updates of
> hid-picolcd_fb.c in a while), so feel free to take this patch through
> the fbdev tree with my:
> Acked-By: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thank you!

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
