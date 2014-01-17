From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 17 Jan 2014 04:58:19 +0000
Subject: Re: [PATCH 1/2] video: exynos: Remove OF dependency for Exynos DP
Message-Id: <CAK9yfHwrRNj=cfOueP1zmdEdVU3igg0-9A8pNa237GQ2t75fFQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389933172-22991-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1389933172-22991-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 17 January 2014 10:17, Jingoo Han <jg1.han@samsung.com> wrote:
> On Friday, January 17, 2014 1:33 PM, Sachin Kamat wrote:
>>
>> Exynos is now a DT only platform. Hence there is no need
>> for an explicit OF dependency. Remove it.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>
> Acked-by: Jingoo Han <jg1.han@samsung.com>

Thanks.
>
> Thank you for sending the patch. However, please CC me,
> because I am a maintainer of Exynos DP driver.

Sorry for missing you on the CC list. I think you probably need to
update the MAINTAINER file
entry to reflect this.

---
With warm regards,
Sachin
