From: =?UTF-8?B?TWFya28gS2F0acSH?= <dromede@gmail.com>
Date: Thu, 29 Nov 2012 13:09:51 +0000
Subject: Re: [PATCH] backlight: corgi_lcd: Fix WARN_ON() when calling corgi_bl_set_intensity.
Message-Id: <CAHod+Gd3UU7NdRLAAbsX6TUugnjKBwUsDy7yBQzyykuf5GHMVQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1354139201-12834-1-git-send-email-dromede@gmail.com>
 <001501cdcdf2$b3f8f730$1beae590$%han@samsung.com>
In-Reply-To: <001501cdcdf2$b3f8f730$1beae590$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Nov 29, 2012 at 6:30 AM, Jingoo Han <jg1.han@samsung.com> wrote:
> On Thursday, November 29, 2012 6:47 AM, Marko Katic wrote
>> Subject: [PATCH] backlight: corgi_lcd: Fix WARN_ON() when calling corgi_bl_set_intensity.
>
> CC'ed Andrew Morton.
>
>
> Hi Marko Katic,
> The commit subject and commit message are not clear.
>
> How about using subject as below?
> backlight: corgi_lcd: use gpio_set_value_cansleep()
>
> In addition, 'Fix WARN_ON() when calling corgi_bl_set_intensity'
> would be the reason why you submit this patch.
> Please make the commit message more detail.
>
> Also, I have a question on gpio driver.
> In order to trigger WARN_ON(chip->can_sleep), 'can_sleep' should be
> set as 1. However, I cannot find 'can_sleep = 1' in the PXA gpio driver.
> What gpio driver do you use to test corgi_lcd driver?
>
>
> Best regards,
> Jingoo Han
>

Well, the commit message was short because i thought it was a quick
and obvious fix.
But it doesn't really matter now since you raise a valid point with
your question.
There are two classes of devices that use this lcd, corgi and spitz
(both are in mach-pxa tree). Both have
several variants. All of them use the SCOOP chip for backlight control
(arm/common/scoop.c) except akita which
uses the max7310 gpio expander for backlight control. The SCOOP chip
driver doesn't set can_sleep but the
max7310 does. So this patch is probably only valid for akita machines.
I'll test this further and post a revised patch
soon.
