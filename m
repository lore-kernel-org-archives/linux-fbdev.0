From: Rob Herring <robh@kernel.org>
Date: Fri, 17 Nov 2017 20:28:34 +0000
Subject: Re: [PATCH V1 1/4] qcom: spmi-wled: Add support for qcom wled driver
Message-Id: <20171117202834.mqe26lslox3nlsfo@rob-hp-laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1510834717-21765-1-git-send-email-kgunda@codeaurora.org>
 <1510834717-21765-2-git-send-email-kgunda@codeaurora.org>
In-Reply-To: <1510834717-21765-2-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kiran Gunda <kgunda@codeaurora.org>
Cc: bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Mark Rutland <mark.rutland@arm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org

On Thu, Nov 16, 2017 at 05:48:34PM +0530, Kiran Gunda wrote:
> WLED driver provides the interface to the display driver to
> adjust the brightness of the display backlight.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> ---
>  .../bindings/leds/backlight/qcom-spmi-wled.txt     |  90 ++++

Please split bindings to separate patch.

>  drivers/video/backlight/Kconfig                    |   9 +
>  drivers/video/backlight/Makefile                   |   1 +
>  drivers/video/backlight/qcom-spmi-wled.c           | 504 +++++++++++++++++++++
>  4 files changed, 604 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/qcom-spmi-wled.txt
>  create mode 100644 drivers/video/backlight/qcom-spmi-wled.c
