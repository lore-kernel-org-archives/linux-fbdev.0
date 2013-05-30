From: =?ISO-8859-1?Q?Andreas_Bie=DFmann?=  <andreas.biessmann@corscience.de>
Date: Thu, 30 May 2013 14:27:38 +0000
Subject: Re: [PATCH 1/8] video: atmel_lcdfb: fix platform data struct
Message-Id: <51A761DA.6020109@corscience.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130411145741.GB25242@game.jcrosoft.org>
 <1365692422-9565-1-git-send-email-plagnioj@jcrosoft.com>
 <CACQ1gAjF5kuu-czkj56-pQdTBUhvY5VodvfnF3RA_DN-O0b9NQ@mail.gmail.com>
 <20130529173538.GC23899@game.jcrosoft.org>
 <CACQ1gAhhsMw1-Znd8BC=A0rJBrB4pphCtH9v9qOQR+j2dY3vCw@mail.gmail.com>
 <20130529193220.GB19468@game.jcrosoft.org>
 <CACQ1gAj_m_aWaq5J41SY8EPwOH5-3zYPsf2WJCunvVnBCyq00Q@mail.gmail.com>
 <20130530072328.GE19468@game.jcrosoft.org>
In-Reply-To: <20130530072328.GE19468@game.jcrosoft.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On 30.05.13 09:23, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 08:39 Thu 30 May     , Richard Genoud wrote:
>> 2013/5/29 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>:
>>> On 19:44 Wed 29 May     , Richard Genoud wrote:
>>>> 2013/5/29 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>:
>>>>> On 16:36 Wed 29 May     , Richard Genoud wrote:
>>>>>> 2013/4/11 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>:
>>>>>>> Today we mix pdata and drivers data in the struct atmel_lcdfb_info
>>>>>>> Fix it and introduce a new struct atmel_lcdfb_pdata for platform da=
ta only
>>>>>>>
>>>>>>> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.=
com>
>>>>>>> Cc: linux-fbdev@vger.kernel.org
>>>>>>> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
>>>>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>>>>> Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
>>>>>>> ---
>>>>>>>  arch/arm/mach-at91/at91sam9261_devices.c    |    6 +-
>>>>>>>  arch/arm/mach-at91/at91sam9263_devices.c    |    6 +-
>>>>>>>  arch/arm/mach-at91/at91sam9g45_devices.c    |    6 +-
>>>>>>>  arch/arm/mach-at91/at91sam9rl_devices.c     |    6 +-
>>>>>>>  arch/arm/mach-at91/board-sam9261ek.c        |    6 +-
>>>>>>>  arch/arm/mach-at91/board-sam9263ek.c        |    4 +-
>>>>>>>  arch/arm/mach-at91/board-sam9m10g45ek.c     |    4 +-
>>>>>>>  arch/arm/mach-at91/board-sam9rlek.c         |    4 +-
>>>>>>>  arch/arm/mach-at91/board.h                  |    4 +-
>>>>>>>  arch/avr32/boards/atngw100/evklcd10x.c      |    6 +-
>>>>>>>  arch/avr32/boards/atngw100/mrmt.c           |    4 +-
>>>>>>>  arch/avr32/boards/atstk1000/atstk1000.h     |    2 +-
>>>>>>>  arch/avr32/boards/atstk1000/setup.c         |    2 +-
>>>>>>>  arch/avr32/boards/favr-32/setup.c           |    2 +-
>>>>>>>  arch/avr32/boards/hammerhead/setup.c        |    2 +-
>>>>>>>  arch/avr32/boards/merisc/display.c          |    2 +-
>>>>>>>  arch/avr32/boards/mimc200/setup.c           |    4 +-
>>>>>>>  arch/avr32/mach-at32ap/at32ap700x.c         |    8 +--
>>>>>>>  arch/avr32/mach-at32ap/include/mach/board.h |    4 +-
>>>>>>>  drivers/video/atmel_lcdfb.c                 |  104 +++++++++++++++=
++----------
>>>>>>>  include/video/atmel_lcdc.h                  |   24 +------
>>>>>>>  21 files changed, 109 insertions(+), 101 deletions(-)
>>>>>>>
>>>>>> [snip]
>>>>>>> diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdf=
b.c
>>>>>>> index c1a2914..98733cd4 100644
>>>>>>> --- a/drivers/video/atmel_lcdfb.c
>>>>>>> +++ b/drivers/video/atmel_lcdfb.c
>>>>>>> @@ -20,12 +20,45 @@
>>>>>>>  #include <linux/gfp.h>
>>>>>>>  #include <linux/module.h>
>>>>>>>  #include <linux/platform_data/atmel.h>
>>>>>>> +#include <video/of_display_timing.h>
>>>>>>>
>>>>>>>  #include <mach/cpu.h>
>>>>>>>  #include <asm/gpio.h>
>>>>>>>
>>>>>>>  #include <video/atmel_lcdc.h>
>>>>>>>
>>>>>>> +struct atmel_lcdfb_config {
>>>>>>> +       bool have_alt_pixclock;
>>>>>>> +       bool have_hozval;
>>>>>>> +       bool have_intensity_bit;
>>>>>>> +};
>>>>>>> +
>>>>>>> + /* LCD Controller info data structure, stored in device platform_=
data */
>>>>>>> +struct atmel_lcdfb_info {
>>>>>>> +       spinlock_t              lock;
>>>>>>> +       struct fb_info          *info;
>>>>>>> +       void __iomem            *mmio;
>>>>>>> +       int                     irq_base;
>>>>>>> +       struct work_struct      task;
>>>>>>> +
>>>>>>> +       unsigned int            smem_len;
>>>>>>> +       struct platform_device  *pdev;
>>>>>>> +       struct clk              *bus_clk;
>>>>>>> +       struct clk              *lcdc_clk;
>>>>>>> +
>>>>>>> +       struct backlight_device *backlight;
>>>>>>> +       u8                      bl_power;
>>>>>>> +       bool                    lcdcon_pol_negative;
>>>>>> I think lcdcon_pol_negative should be part of pdata, because it real=
ly
>>>>>> depends on how the PWM is wired on the board.
>>>>>>
>>>>>
>>>>> maybe but no one mainline use it on any pdata for non-dt boars
>>>>> so I did not want to expose it
>>>> Well, at least, I'm using it :)
>>>> (and I guess that Andreas is using it also, otherwise he wouldn't have
>>>> introduce it !)
>>>
>>> yes but pdata is for non-dt boards, for dt you can keep it in struct
>>> atmel_lcdfb_info and add a property
>>>
>>> if non-dt boards want it my answer is I do not care switch to DT
>>
>> ok (I use a full DT board based on sam9g35)
>>
>> so I'll add something like
>> sinfo->lcdcon_pol_negative =3D of_property_read_bool(display_np,
>> "atmel,lcdcon-pwm-pulse-low");
>> in /atmel_lcdfb.c
>>
>> But I thought the goal of this patch was to separate driver data from
>> platform specific data, and IMHO, lcdcon_pol_negative is a specificity
>> of the platform.
>=20
> You are right but as non one mainline use it as pdata I choose to drop it
> and only keep it on the driver as we can still use it for DT
>=20
> It's a way to force peopoe to switch to DT

well, we use it on an avr32 board (not mainlined; though no kernel
update planned currently) ... but no way to use DT currently.

Best regards

Andreas Bie=DFmann
