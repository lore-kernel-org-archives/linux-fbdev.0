From: Jacek Anaszewski <j.anaszewski@samsung.com>
Date: Thu, 16 Jul 2015 08:01:09 +0000
Subject: Re: [PATCH] backlight: pm8941-wled: Move PM8941 WLED driver to backlight
Message-Id: <55A764C5.5060205@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1436990540-23354-1-git-send-email-bjorn.andersson@sonymobile.com>
In-Reply-To: <1436990540-23354-1-git-send-email-bjorn.andersson@sonymobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Rob Clark <robdclark@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-msm@vger.kernel.org

Hi Bjorn,

On 07/15/2015 10:02 PM, Bjorn Andersson wrote:
> The Qualcomm PM8941 WLED block is used for backlight and should therefor
> be in the backlight framework and not in the LED framework. This moves
> the driver and adapts to the backlight api instead.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> ---
>   .../devicetree/bindings/leds/leds-pm8941-wled.txt  |  5 +-
>   drivers/leds/Kconfig                               |  8 ---
>   drivers/leds/Makefile                              |  1 -
>   drivers/video/backlight/Kconfig                    |  8 +++
>   drivers/video/backlight/Makefile                   |  1 +
>   .../backlight/pm8941-wled.c}                       | 59 ++++++++++------------
>   6 files changed, 36 insertions(+), 46 deletions(-)
>   rename drivers/{leds/leds-pm8941-wled.c => video/backlight/pm8941-wled.c} (90%)

Acked-by: Jacek Anaszewski <j.anaszewski@samsung.com>

-- 
Best Regards,
Jacek Anaszewski
