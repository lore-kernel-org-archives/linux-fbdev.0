From: Tomasz Figa <t.figa@samsung.com>
Date: Mon, 28 Oct 2013 12:24:31 +0000
Subject: Re: [PATCH 3/7] video: exynos_mipi_dsim: Use the generic PHY driver
Message-Id: <23467785.uRr31aFEN8@amdc1227>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381940896-9355-1-git-send-email-kishon@ti.com>
 <526997BC.8070602@gmail.com> <526E0038.7050805@samsung.com>
In-Reply-To: <526E0038.7050805@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Donghwa,

On Monday 28 of October 2013 15:12:08 Donghwa Lee wrote:
> On Fri, OCT 25, 2013 06:57, Sylwester Nawrocki wrote:
> > On 10/24/2013 05:57 PM, Kishon Vijay Abraham I wrote:
> >> On Thursday 24 October 2013 09:12 PM, Sachin Kamat wrote:
> >>> On 24 October 2013 20:00, Olof Johansson<olof@lixom.net>  wrote:
> >>>> On Wed, Oct 16, 2013 at 9:28 AM, Kishon Vijay Abraham I<kishon@ti.com>  wrote:
> >>>>> diff --git a/drivers/video/exynos/exynos_mipi_dsi.c b/drivers/video/exynos/exynos_mipi_dsi.c
> >>>>> index 32e5406..00b3a52 100644
> >>>>> --- a/drivers/video/exynos/exynos_mipi_dsi.c
> >>>>> +++ b/drivers/video/exynos/exynos_mipi_dsi.c
> >>>>> @@ -156,8 +157,7 @@ static int exynos_mipi_dsi_blank_mode(struct mipi_dsim_device *dsim, int power)
> >>>>>                  exynos_mipi_regulator_enable(dsim);
> >>>>>
> >>>>>                  /* enable MIPI-DSI PHY. */
> >>>>> -               if (dsim->pd->phy_enable)
> >>>>> -                       dsim->pd->phy_enable(pdev, true);
> >>>>> +               phy_power_on(dsim->phy);
> >>>>>
> >>>>>                  clk_enable(dsim->clock);
> >>>>>
> >>>>
> >>>> This introduces the below with exynos_defconfig:
> >>>>
> >>>> ../../drivers/video/exynos/exynos_mipi_dsi.c: In function
> >>>> 'exynos_mipi_dsi_blank_mode':
> >>>> ../../drivers/video/exynos/exynos_mipi_dsi.c:144:26: warning: unused
> >>>> variable 'pdev' [-Wunused-variable]
> >>>>    struct platform_device *pdev = to_platform_device(dsim->dev);
> >
> > Sorry about missing that, I only noticed this warning recently and didn't
> > get around to submit a patch.
> >
> >>> I have already submitted a patch to fix this [1]
> >
> > Thanks a lot guys for fixing this.
> >
> >>> [1] http://marc.info/?l=linux-fbdev&m8233359617936&w=2
> >>
> >> Sorry, missed that :-(
> >
> > This MIPI DSIM driver is affectively a dead code in the mainline now, once
> > Exynos become a dt-only platform. I guess it can be deleted for 3.14, once
> > S5P gets converted to the device tree. The new driver using CDF is basically
> > a complete rewrite. Or device tree support should be added to that driver,
> > but I believe it doesn't make sense without CDF.
> >
> 
> MIPI DSIM driver is not a dead code. There is a steady trickle of patches.
> It's kind of late, but, I will update it as DT based drivers as soon as possible.
> And Why do you think that DT support of existing MIPI DSIM is something less
> than great?

First of all, the exynos_mipi_dsim driver has currently no users in
mainline kernel, so it is essentially dead code. In addition, on
a platform that is the primary candidate for using it, which is Exynos,
there is no way to use it, due to no DT support.

As for the driver itself, it is not really a great example of good code.
It contains a hacks, like calling msleep() without any clear reason and
also many coding style issues. I'd prefer to replace it with the new
exynos-dsi driver rewritten completely in SRPOL, when CDF is finished.

Best regards,
Tomasz

