From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Date: Mon, 20 Jul 2015 21:11:27 +0000
Subject: Re: [PATCH] backlight: pm8941-wled: Move PM8941 WLED driver to backlight
Message-Id: <55AD63FF.8090408@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1436990540-23354-1-git-send-email-bjorn.andersson@sonymobile.com> <55A764C5.5060205@samsung.com> <004401d0c2f6$9b73b820$d25b2860$@com>
In-Reply-To: <004401d0c2f6$9b73b820$d25b2860$@com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jingoohan1@gmail.com>, 'Bjorn Andersson' <bjorn.andersson@sonymobile.com>
Cc: 'Jacek Anaszewski' <j.anaszewski@samsung.com>, 'Rob Herring' <robh+dt@kernel.org>, 'Pawel Moll' <pawel.moll@arm.com>, 'Mark Rutland' <mark.rutland@arm.com>, 'Ian Campbell' <ijc+devicetree@hellion.org.uk>, 'Kumar Gala' <galak@codeaurora.org>, 'Bryan Wu' <cooloney@gmail.com>, 'Richard Purdie' <rpurdie@rpsys.net>, 'Lee Jones' <lee.jones@linaro.org>, 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, 'Rob Clark' <robdclark@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-msm@vger.kernel.org



On 20.07.2015 16:15, Jingoo Han wrote:
> On Thursday, July 16, 2015 5:01 PM, Jacek Anaszewski wrote:
>> On 07/15/2015 10:02 PM, Bjorn Andersson wrote:
>>> The Qualcomm PM8941 WLED block is used for backlight and should therefor
>>> be in the backlight framework and not in the LED framework. This moves
>>> the driver and adapts to the backlight api instead.
>>>
>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
>>> ---
>>>    .../devicetree/bindings/leds/leds-pm8941-wled.txt  |  5 +-
>>>    drivers/leds/Kconfig                               |  8 ---
>>>    drivers/leds/Makefile                              |  1 -
>>>    drivers/video/backlight/Kconfig                    |  8 +++
>>>    drivers/video/backlight/Makefile                   |  1 +
>>>    .../backlight/pm8941-wled.c}                       | 59 ++++++++++------------
>>>    6 files changed, 36 insertions(+), 46 deletions(-)
>>>    rename drivers/{leds/leds-pm8941-wled.c => video/backlight/pm8941-wled.c} (90%)
>>
>> Acked-by: Jacek Anaszewski <j.anaszewski@samsung.com>
>
> If you are not an author of this driver or a maintainer affected by this patch,
> Just 'Reviewed-by' looks good.

I am a LED subsystem maintainer.

-- 
Best Regards,
Jacek Anaszewski
