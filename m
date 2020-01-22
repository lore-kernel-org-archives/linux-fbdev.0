From: Chen Zhou <chenzhou10@huawei.com>
Date: Wed, 22 Jan 2020 01:21:26 +0000
Subject: Re: [PATCH -next] backlight: qcom-wled: fix unsigned comparison to zero
Message-Id: <a497400e-b734-9346-5ce8-292e051f611a@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200120130143.35363-1-chenzhou10@huawei.com>
 <20200122003932.GA3948@builder>
In-Reply-To: <20200122003932.GA3948@builder>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: daniel.thompson@linaro.org, kgunda@codeaurora.org, b.zolnierkie@samsung.com, jingoohan1@gmail.com, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, agross@kernel.org, linux-arm-msm@vger.kernel.org, lee.jones@linaro.org

Hi Bjorn,

On 2020/1/22 8:39, Bjorn Andersson wrote:
> On Mon 20 Jan 05:01 PST 2020, Chen Zhou wrote:
> 
>> Fixes coccicheck warning:
>> ./drivers/video/backlight/qcom-wled.c:1104:5-15:
>> 	WARNING: Unsigned expression compared with zero: string_len > 0
>>
>> The unsigned variable string_len is assigned a return value from the call
>> to wled_configure, which may return negative error code.
>>
> 
> Afaict string_len is the return value of
> of_property_count_elems_of_size(), rather than wled_configure(). (And
> please append () to function names to make it even more obvious)
> 
> Except for that your patch looks good, so please update the commit
> message and add my Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Regards,
> Bjorn

Thanks for your review, i will fix this in next version.

Thanks,
Chen Zhou

> 
>> Fixes: 775d2ffb4af6 ("backlight: qcom-wled: Restructure the driver for WLED3")
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> ---
>>  drivers/video/backlight/qcom-wled.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
>> index d46052d..3d276b3 100644
>> --- a/drivers/video/backlight/qcom-wled.c
>> +++ b/drivers/video/backlight/qcom-wled.c
>> @@ -956,8 +956,8 @@ static int wled_configure(struct wled *wled, int version)
>>  	struct wled_config *cfg = &wled->cfg;
>>  	struct device *dev = wled->dev;
>>  	const __be32 *prop_addr;
>> -	u32 size, val, c, string_len;
>> -	int rc, i, j;
>> +	u32 size, val, c;
>> +	int rc, i, j, string_len;
>>  
>>  	const struct wled_u32_opts *u32_opts = NULL;
>>  	const struct wled_u32_opts wled3_opts[] = {
>> -- 
>> 2.7.4
>>
> 
> .
> 
