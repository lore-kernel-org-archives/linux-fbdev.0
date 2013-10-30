From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Date: Wed, 30 Oct 2013 00:43:38 +0000
Subject: Re: [PATCH 3/7] video: exynos_mipi_dsim: Use the generic PHY driver
Message-Id: <5270563A.5080605@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381940896-9355-1-git-send-email-kishon@ti.com>
 <526997BC.8070602@gmail.com> <526E0038.7050805@samsung.com>
 <23467785.uRr31aFEN8@amdc1227> <526F7412.60004@samsung.com>
In-Reply-To: <526F7412.60004@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 10/29/2013 09:38 AM, Donghwa Lee wrote:
> On Tue, OCT 28, 2013 21:24, Tomasz Figa wrote:
>> On Monday 28 of October 2013 15:12:08 Donghwa Lee wrote:
[...]
>> First of all, the exynos_mipi_dsim driver has currently no users in
>> mainline kernel, so it is essentially dead code. In addition, on
>> a platform that is the primary candidate for using it, which is Exynos,
>> there is no way to use it, due to no DT support.
>
> As I mentioned above, patches are submitted sometimes and I will update
> this driver as soon as possible to support DT.
>
>> As for the driver itself, it is not really a great example of good code.
>> It contains a hacks, like calling msleep() without any clear reason and
>> also many coding style issues. I'd prefer to replace it with the new
>> exynos-dsi driver rewritten completely in SRPOL, when CDF is finished.
>
> Yes, I know this drivers had been changed about only minor issues and
> it is not really good code style. And CDF is more good and light.
> But discussion for CDF is still remaining a kind of requests. If it is merged
> into linux kernel and many users use it, existing MIPI DSI drivers will be
> replaced with the new drivers naturally, isn't it?

Not necessarily. Our goal should be to have fairly stable DT binding at the
SoC side so all available panels can possibly be used with any SoC without
problems.

Then please refrain for a while from pushing entirely vendor specific DT
bindings upstream. Let's focus instead on an as much as possible common
framework and the DT bindings. Whether the CDF will be part of DRM or not
the DT bindings are supposed to be generic, so they work with whatever
driver architecture.

I guess you could try to come up with an unstable DT binding for the
MIPI DSIM and display panels it is used with, but at this stage it seems
just a waste of time.
If there were no SoC specific panel drivers in the kernel there would be
now much less trouble with DT support.

--
Thanks,
Sylwester
