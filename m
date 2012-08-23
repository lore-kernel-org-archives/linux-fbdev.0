From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 23 Aug 2012 20:49:18 +0000
Subject: Re: [PATCH 06/10] video: exynos_dp: Fix get_pll_lock_status return value
Message-Id: <5036974E.1000900@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344398064-13563-7-git-send-email-seanpaul@chromium.org>
In-Reply-To: <1344398064-13563-7-git-send-email-seanpaul@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 08/20/2012 09:20 AM, Jingoo Han wrote:
> On Wednesday, August 08, 2012 12:54 PM Sean Paul wrote:
>>
>> Fix the return value of exynos_dp_get_pll_lock_status to
>> reflect what it actually returns.
>>
>> Signed-off-by: Sean Paul <seanpaul@chromium.org>
>> Reviewed-by: Olof Johansson <olofj@chromium.org>
> 
> 
> Acked-by: Jingoo Han <jg1.han@samsung.com>

Applied.


Thanks,

Florian Tobias Schandinat

> 
> 
>> ---
>>  drivers/video/exynos/exynos_dp_core.h |    2 +-
>>  drivers/video/exynos/exynos_dp_reg.c  |    2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/video/exynos/exynos_dp_core.h b/drivers/video/exynos/exynos_dp_core.h
>> index 8526e54..6431c65 100644
>> --- a/drivers/video/exynos/exynos_dp_core.h
>> +++ b/drivers/video/exynos/exynos_dp_core.h
>> @@ -43,7 +43,7 @@ void exynos_dp_init_interrupt(struct exynos_dp_device *dp);
>>  void exynos_dp_reset(struct exynos_dp_device *dp);
>>  void exynos_dp_swreset(struct exynos_dp_device *dp);
>>  void exynos_dp_config_interrupt(struct exynos_dp_device *dp);
>> -u32 exynos_dp_get_pll_lock_status(struct exynos_dp_device *dp);
>> +enum pll_status exynos_dp_get_pll_lock_status(struct exynos_dp_device *dp);
>>  void exynos_dp_set_pll_power_down(struct exynos_dp_device *dp, bool enable);
>>  void exynos_dp_set_analog_power_down(struct exynos_dp_device *dp,
>>  				enum analog_power_block block,
>> diff --git a/drivers/video/exynos/exynos_dp_reg.c b/drivers/video/exynos/exynos_dp_reg.c
>> index a121bed..d7b1494 100644
>> --- a/drivers/video/exynos/exynos_dp_reg.c
>> +++ b/drivers/video/exynos/exynos_dp_reg.c
>> @@ -179,7 +179,7 @@ void exynos_dp_config_interrupt(struct exynos_dp_device *dp)
>>  	writel(reg, dp->reg_base + EXYNOS_DP_INT_STA_MASK);
>>  }
>>
>> -u32 exynos_dp_get_pll_lock_status(struct exynos_dp_device *dp)
>> +enum pll_status exynos_dp_get_pll_lock_status(struct exynos_dp_device *dp)
>>  {
>>  	u32 reg;
>>
>> --
>> 1.7.7.3
> 
> 

