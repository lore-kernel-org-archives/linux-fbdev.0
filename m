From: InKi Dae <daeinki@gmail.com>
Date: Sat, 03 Jul 2010 07:20:16 +0000
Subject: Re: [PATCH 2/2] S5PV210: Add MIPI-DSI Driver.
Message-Id: <AANLkTimPUEdMOgEIXbfYf8WwNwy0jGz5CVYxxl3-rb9u@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4C29AF72.6090200@samsung.com> <4C29C766.7010901@samsung.com>
	<4C2DA889.5010809@samsung.com>
	<AANLkTinQ2jC1w6B9q-pirShQ9GJODDwmS6e80KWYRpMm@mail.gmail.com>
	<AANLkTilusz69vyqJE9v_8t3vDOeNex1wWC_u0m11kzjD@mail.gmail.com>
In-Reply-To: <AANLkTilusz69vyqJE9v_8t3vDOeNex1wWC_u0m11kzjD@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

oops, sorry.

it changed header file name to another.

2010/7/3 InKi Dae <daeinki@gmail.com>:
> Hi, Jaya.
>
> below is my answer.
>
> 2010/7/3 Jaya Kumar <jayakumar.lkml@gmail.com>:
>> Hi InKi,
>>
>> 2010/7/2 InKi Dae <inki.dae@samsung.com>:
>>> this patch addes MIPI-DSI Driver.
>>>
>>> to use this driver, some structures below should be added to machine
>>> specific file.
>>
>> A quick question. I'm having difficulty understanding the larger
>> picture here. There's the MIPI-DSI host controller driver (which I
>> think is what this patch is) which is specific to this platform. Then
>> there's the MIPI-DSI LCD panels which are supposed to be fully
>> platform independent, right? and would thus ideally have a platform
>> independent MIPI-DSI client driver?
>>
>
> hmm, is there any mipi-dsi master framework that it can use commonly
> in linux kernel? my driver is dependent on platform a little because
> lcd panel driver should include two header files.
>
>> Would I be correct in saying this patch below does not provide such an
>> abstraction and so structures that would be necessary for such a
>> display driver (eg: struct mipi_lcd_driver ) appear to be declared in
>> the samsung platform specific files. In other words, if we wanted to
>> support a particular MIPI-DSI LCD panel, it would require a client
>> driver that is tied intimately to this platform?
>>
>> Could you point us to an example mipi-dsi client driver that is using
>> the patch you provided? ie: something that is calling
>> s5p_dsim_register_lcd_driver. That would help us understand the
>> abstraction that is being made here.
>
> Ok, below is example code to mipi-dsi based lcd panel driver.
>
> #include <plat/dsim.h>
> #include <plat/mipi_ddi.h>
>
> static struct mipi_lcd_driver xxx_mipi_driver =3D {
> =A0 =A0 =A0 =A0 =A0 .name =A0=3D "xxx",
> =A0 =A0 =A0 =A0 =A0 .init =A0=3D xxx_init,
> =A0 =A0 =A0 =A0 =A0 .display_on =3D xxx_displsy_on,
> =A0 =A0 =A0 =A0 =A0 .set_link =3D xxx_set_link,
> =A0 =A0 =A0 =A0 =A0 .probe =3D xxx_probe,
> =A0 =A0 =A0 =A0 =A0 .suspend =3D xxx_suspend,
> =A0 =A0 =A0 =A0 =A0 .resume =3D xxx_resume,
> };
>
> static int xxx_init(void)
> {
> =A0 =A0 =A0 =A0 =A0 s5p_dsim_register_lcd_driver(&xxx_mipi_driver);
> =A0 =A0 =A0 =A0 =A0 return 0;
> }
>
> static void xxx_exit(void)
> {
> =A0 =A0 =A0 =A0 =A0return;
> }
>
> module_init(xxx_init);
> module_exit(xxx_exit);
>
> at module_init, xxx_mipi_driver would be registered to mipi master
> driver through
> s5p_dsim_register_lcd_driver func and when master driver is probed, xxx_p=
robe
> would be called by probe func of master driver.
>
> I wonder there is mipi-dsi master driver indenpendent on platform
> fully in linux kernel.
> if exsiting, I will use it as master driver. of course, the part
> dependent on platform
> would be implemented using that framework.
>
> Thank you.
>
