From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Wed, 19 Jun 2013 17:24:44 +0000
Subject: Re: [RFC PATCH 5/5] ARM: Samsung: Remove MIPI PHY setup code
Message-Id: <51C1E95C.5040607@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1371231951-1969-1-git-send-email-s.nawrocki@samsung.com>
 <1371231951-1969-6-git-send-email-s.nawrocki@samsung.com>
 <51BE25A0.6050202@samsung.com>
In-Reply-To: <51BE25A0.6050202@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 06/16/2013 10:52 PM, Kukjin Kim wrote:
> On 06/15/13 02:45, Sylwester Nawrocki wrote:
>> > Generic PHY drivers are used to handle the MIPI CSIS and MIPI DSIM
>> > DPHYs so we can remove now unused code at arch/arm/plat-samsung.
>
> If so, sounds good :)
> 
>> > In case there is any board file for S5PV210 platforms using MIPI
>> > CSIS/DSIM (not any upstream currently) it should use the generic
>> > PHY API to bind the PHYs to respective PHY consumer drivers.
>
> To be honest, I didn't test this on boards but if the working is fine, 
> please go ahead without RFC.

Thanks for review. I've tested it on Exynos4412 based board, and will
check also on Exynos4210 TRATS before posting the final version.
It seems to work fine, I just won't be able to test on any non-dt
platform (s5pv210), and there is currently no users of MIPI CSIS/DSIM
on s5pv210. Moreover this series depends on the generic PHY API,
perhaps it can be merged for 3.11.

[1] http://www.spinics.net/lists/arm-kernel/msg251232.html

Regards,
Sylwester
