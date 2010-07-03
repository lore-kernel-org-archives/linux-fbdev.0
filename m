From: InKi Dae <daeinki@gmail.com>
Date: Sat, 03 Jul 2010 05:21:41 +0000
Subject: Re: [PATCH 2/2] S5PV210: Add MIPI-DSI Driver.
Message-Id: <AANLkTilusz69vyqJE9v_8t3vDOeNex1wWC_u0m11kzjD@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4C29AF72.6090200@samsung.com> <4C29C766.7010901@samsung.com>
	<4C2DA889.5010809@samsung.com>
	<AANLkTinQ2jC1w6B9q-pirShQ9GJODDwmS6e80KWYRpMm@mail.gmail.com>
In-Reply-To: <AANLkTinQ2jC1w6B9q-pirShQ9GJODDwmS6e80KWYRpMm@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi, Jaya.

below is my answer.

2010/7/3 Jaya Kumar <jayakumar.lkml@gmail.com>:
> Hi InKi,
>
> 2010/7/2 InKi Dae <inki.dae@samsung.com>:
>> this patch addes MIPI-DSI Driver.
>>
>> to use this driver, some structures below should be added to machine
>> specific file.
>
> A quick question. I'm having difficulty understanding the larger
> picture here. There's the MIPI-DSI host controller driver (which I
> think is what this patch is) which is specific to this platform. Then
> there's the MIPI-DSI LCD panels which are supposed to be fully
> platform independent, right? and would thus ideally have a platform
> independent MIPI-DSI client driver?
>

hmm, is there any mipi-dsi master framework that it can use commonly
in linux kernel? my driver is dependent on platform a little because
lcd panel driver should include two header files.

> Would I be correct in saying this patch below does not provide such an
> abstraction and so structures that would be necessary for such a
> display driver (eg: struct mipi_lcd_driver ) appear to be declared in
> the samsung platform specific files. In other words, if we wanted to
> support a particular MIPI-DSI LCD panel, it would require a client
> driver that is tied intimately to this platform?
>
> Could you point us to an example mipi-dsi client driver that is using
> the patch you provided? ie: something that is calling
> s5p_dsim_register_lcd_driver. That would help us understand the
> abstraction that is being made here.

Ok, below is example code to mipi-dsi based lcd panel driver.

#include <plat/regs-dsim.h>
#include <plat/dsim.h>

static struct mipi_lcd_driver xxx_mipi_driver = {
           .name  = "xxx",
           .init  = xxx_init,
           .display_on = xxx_displsy_on,
           .set_link = xxx_set_link,
           .probe = xxx_probe,
           .suspend = xxx_suspend,
           .resume = xxx_resume,
};

static int xxx_init(void)
{
           s5p_dsim_register_lcd_driver(&xxx_mipi_driver);
           return 0;
}

static void xxx_exit(void)
{
          return;
}

module_init(xxx_init);
module_exit(xxx_exit);

at module_init, xxx_mipi_driver would be registered to mipi master
driver through
s5p_dsim_register_lcd_driver func and when master driver is probed, xxx_probe
would be called by probe func of master driver.

I wonder there is mipi-dsi master driver indenpendent on platform
fully in linux kernel.
if exsiting, I will use it as master driver. of course, the part
dependent on platform
would be implemented using that framework.

Thank you.
