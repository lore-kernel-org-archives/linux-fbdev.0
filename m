From: Tushar Behera <tushar.behera@linaro.org>
Date: Tue, 30 Aug 2011 14:56:34 +0000
Subject: Re: [PATCH V8 1/5] ARM: EXYNOS4: Change clock name for FIMD
Message-Id: <4E5CF752.6060505@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1311202444-18137-1-git-send-email-jg1.han@samsung.com> <006501cc4776$2ee2a4a0$8ca7ede0$%kim@samsung.com>
In-Reply-To: <006501cc4776$2ee2a4a0$8ca7ede0$%kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: 'Jingoo Han' <jg1.han@samsung.com>, 'Paul Mundt' <lethal@linux-sh.org>, linux-samsung-soc@vger.kernel.org, linux-fbdev@vger.kernel.org, 'Jonghun Han' <jonghun.han@samsung.com>, 'Ben Dooks' <ben-linux@fluff.org>

On Thursday 21 July 2011 12:46 PM, Kukjin Kim wrote:
> Jingoo Han wrote:
>>
>> This patch changes clock for FIMD from 'fimd' to 'lcd'.
>> Also, devname for FIMD is changed from 's5pv310-fb' to 'exynos4-fb'.
>>
>> Signed-off-by: Jingoo Han<jg1.han@samsung.com>
>> ---
>>   arch/arm/mach-exynos4/clock.c |   12 ++++++------
>>   1 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
>> index 98b5cc4..778a202 100644
>> --- a/arch/arm/mach-exynos4/clock.c
>> +++ b/arch/arm/mach-exynos4/clock.c
>> @@ -405,13 +405,13 @@ static struct clk init_clocks_off[] = {
>>   		.enable		= exynos4_clk_ip_cam_ctrl,
>>   		.ctrlbit	= (1<<  3),
>>   	}, {
>> -		.name		= "fimd",
>> -		.devname	= "s5pv310-fb.0",
>> +		.name		= "lcd",
>> +		.devname	= "exynos4-fb.0",
>>   		.enable		= exynos4_clk_ip_lcd0_ctrl,
>>   		.ctrlbit	= (1<<  0),
>>   	}, {
>> -		.name		= "fimd",
>> -		.devname	= "s5pv310-fb.1",
>> +		.name		= "lcd",
>
> As I remember, some guys discussed about the clock name before.
>
> Please refer to the following diagram. Before EXYNOS4210 clk 'lcd' was used
> for FIMD IP core clock and source of the LCD pixel clock. But the mux used
> to select source of LCD pixel clock is removed. So 'lcd' clock is only used
> for core clock of FIMD IP. It isn't used for LCD pixel clock.
>
> As a result clock name was changed from lcd to fimd in the EXYNOS4210
> datasheet.
>
In drivers/video/s3c-fb.c:s3c_fb_probe(), the bus clock is assumed to be 
'lcd'. The bus clock name in all other related machine folder is 'lcd'. 
Hence for consistency, we might consider renaming 'fimd'=>'lcd', even 
though the clock name is different in the datasheet.


-- 
Tushar Behera
