From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Wed, 19 Sep 2012 02:49:41 +0000
Subject: Re: [PATCH 2/2] video: exynos_mipi_dsi: Fix potential NULL pointer dereference
Message-Id: <CAK9yfHw7uxQhxhVXRvpgb=D+oeDrOrTnOXwKLyra_SSC4ybdQQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347968280-22343-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1347968280-22343-2-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 19 September 2012 07:58, Inki Dae <inki.dae@samsung.com> wrote:
>
>
>> -----Original Message-----
>> From: Sachin Kamat [mailto:sachin.kamat@linaro.org]
>> Sent: Tuesday, September 18, 2012 8:38 PM
>> To: linux-fbdev@vger.kernel.org
>> Cc: inki.dae@samsung.com; dh09.lee@samsung.com; FlorianSchandinat@gmx.de;
>> sachin.kamat@linaro.org; patches@linaro.org
>> Subject: [PATCH 2/2] video: exynos_mipi_dsi: Fix potential NULL pointer
>> dereference
>>
>> The error message printed when dsim is NULL references its member.
>> This will cause NULL pointer derefernce error. Hence change dev_err
>> to pr_err to avoid it.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> ---
>>  drivers/video/exynos/exynos_mipi_dsi_common.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/video/exynos/exynos_mipi_dsi_common.c
>> b/drivers/video/exynos/exynos_mipi_dsi_common.c
>> index 7cc4113..4fc64c4 100644
>> --- a/drivers/video/exynos/exynos_mipi_dsi_common.c
>> +++ b/drivers/video/exynos/exynos_mipi_dsi_common.c
>> @@ -80,7 +80,7 @@ irqreturn_t exynos_mipi_dsi_interrupt_handler(int irq,
>> void *dev_id)
>>       unsigned int intsrc, intmsk;
>>
>>       if (dsim = NULL) {
>> -             dev_err(dsim->dev, "%s: wrong parameter\n", __func__);
>> +             pr_err("%s: wrong parameter\n", __func__);
>>               return IRQ_NONE;
>>       }
>
> Please, just remove above exception codes. dsim was allocated and already
> checked by probe so this exception isn't needed.

Yes, that looks better if it is already ensured to be non-NULL. I had
not checked that.
Will remove this check and re-send.

Thanks.

>
> Thanks,
> Inki Dae
>
>
>>
>> --
>> 1.7.4.1
>



-- 
With warm regards,
Sachin
