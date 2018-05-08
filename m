From: kgunda@codeaurora.org
Date: Tue, 08 May 2018 10:16:19 +0000
Subject: Re: [PATCH V2 2/5] backlight: qcom-wled: Add support for WLED4 peripheral
Message-Id: <398b0fafebdcad8072d592c2ab812286@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1525342352-25072-1-git-send-email-kgunda@codeaurora.org>
 <1525342352-25072-3-git-send-email-kgunda@codeaurora.org>
 <20180507164534.GB21042@rob-hp-laptop>
In-Reply-To: <20180507164534.GB21042@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: bjorn.andersson@linaro.org, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Mark Rutland <mark.rutland@arm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-arm-msm@vger.kernel.org

On 2018-05-07 22:15, Rob Herring wrote:
> On Thu, May 03, 2018 at 03:42:29PM +0530, Kiran Gunda wrote:
>> WLED4 peripheral is present on some PMICs like pmi8998
>> and pm660l. It has a different register map and also
>> configurations are different. Add support for it.
>> 
>> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
>> ---
>>  .../bindings/leds/backlight/qcom-wled.txt          | 172 ++++-
> 
> Please split bindings to a separate patch.
> 
> This is also a whole lot of churn re-formatting. That is fine, but 
> don't
> mix actual changes to the binding with re-formatting. You can do 2
> patches in this case:
> 
> - move and reformat (as long as the move shows up as a move
> and not a remove and add)
> - additions for new chips
> 
Sure. I will do it in the next series.
>>  drivers/video/backlight/qcom-wled.c                | 749 
>> +++++++++++++++------
>>  2 files changed, 696 insertions(+), 225 deletions(-)
