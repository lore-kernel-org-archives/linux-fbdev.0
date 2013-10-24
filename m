From: Olof Johansson <olof@lixom.net>
Date: Thu, 24 Oct 2013 17:06:15 +0000
Subject: Re: [PATCH 3/7] video: exynos_mipi_dsim: Use the generic PHY driver
Message-Id: <CAOesGMgbGvZB--uaJ2EowPFDYqGZb3iG9SZs9d0UVcJQLAZW3g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381940896-9355-1-git-send-email-kishon@ti.com>
 <1381940896-9355-4-git-send-email-kishon@ti.com>
 <CAOesGMhwotSY-1WQmt+wtsrsH2m30VE=j-MwyhpYU3mt_PSPPw@mail.gmail.com>
 <CAK9yfHxaLsdFGXiCxvs+HpMSuY6xWd=CGPv-YfSkJqWSxE+f-w@mail.gmail.com>
In-Reply-To: <CAK9yfHxaLsdFGXiCxvs+HpMSuY6xWd=CGPv-YfSkJqWSxE+f-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Oct 24, 2013 at 8:42 AM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Hi Olof,
>
> On 24 October 2013 20:00, Olof Johansson <olof@lixom.net> wrote:
>> Hi Kishon,
>>
>> On Wed, Oct 16, 2013 at 9:28 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>> diff --git a/drivers/video/exynos/exynos_mipi_dsi.c b/drivers/video/exynos/exynos_mipi_dsi.c
>>> index 32e5406..00b3a52 100644
>>> --- a/drivers/video/exynos/exynos_mipi_dsi.c
>>> +++ b/drivers/video/exynos/exynos_mipi_dsi.c
>>> @@ -156,8 +157,7 @@ static int exynos_mipi_dsi_blank_mode(struct mipi_dsim_device *dsim, int power)
>>>                 exynos_mipi_regulator_enable(dsim);
>>>
>>>                 /* enable MIPI-DSI PHY. */
>>> -               if (dsim->pd->phy_enable)
>>> -                       dsim->pd->phy_enable(pdev, true);
>>> +               phy_power_on(dsim->phy);
>>>
>>>                 clk_enable(dsim->clock);
>>>
>>
>> This introduces the below with exynos_defconfig:
>>
>> ../../drivers/video/exynos/exynos_mipi_dsi.c: In function
>> 'exynos_mipi_dsi_blank_mode':
>> ../../drivers/video/exynos/exynos_mipi_dsi.c:144:26: warning: unused
>> variable 'pdev' [-Wunused-variable]
>>   struct platform_device *pdev = to_platform_device(dsim->dev);
>>
>
> I have already submitted a patch to fix this [1]
>
> [1] http://marc.info/?l=linux-fbdev&m8233359617936&w=2

Ah, I'm not subscribed to the fbdev list. Next time it might be a good
idea to cc the same lists as the original patch. But thanks for fixing
it!


-Olof
