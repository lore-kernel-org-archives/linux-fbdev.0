From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Thu, 17 Jan 2013 03:15:12 +0000
Subject: Re: [PATCH 1/1] video: exynos: Use devm_* APIs in s6e8ax0.c
Message-Id: <CAK9yfHwzC5nA+cjjj9HJOL_T50O2X_Vh2YJWQ5DDNbGj8zSgOg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1355289083-28269-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1355289083-28269-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Florian,

On 17 December 2012 06:06, Donghwa Lee <dh09.lee@samsung.com> wrote:
> On Wed, Dec 12, 2012 at 14:11, Sachin Kamat wrote:
>>
>> devm_* APIs are device managed and make error handling
>> and code cleanup simpler.
>>
>> Cc: Donghwa Lee <dh09.lee@samsung.com>
>> Cc: Inki Dae <inki.dae@samsung.com>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> ---
>> Compile tested against linux-next.
>> ---
>>   drivers/video/exynos/s6e8ax0.c |   14 ++++----------
>>   1 files changed, 4 insertions(+), 10 deletions(-)
>>

>
> It looks good to me.
> Acked-by: Donghwa Lee <dh09.lee@samsung.com>

Can you please add this patch to to your tree if it looks OK?



-- 
With warm regards,
Sachin
