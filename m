From: Rob Herring <robh@kernel.org>
Date: Mon, 07 May 2018 16:40:56 +0000
Subject: Re: [PATCH V2 1/5] backlight: qcom-wled: Rename pm8941-wled.c to qcom-wled.c
Message-Id: <20180507164056.GA21042@rob-hp-laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1525342352-25072-1-git-send-email-kgunda@codeaurora.org>
 <1525342352-25072-2-git-send-email-kgunda@codeaurora.org>
In-Reply-To: <1525342352-25072-2-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kiran Gunda <kgunda@codeaurora.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, bjorn.andersson@linaro.org, linux-fbdev@vger.kernel.org, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-arm-msm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org

On Thu, May 03, 2018 at 03:42:28PM +0530, Kiran Gunda wrote:
> pm8941-wled.c driver is supporting the WLED peripheral
> on pm8941. Rename it to qcom-wled.c so that it can support
> WLED on multiple PMICs.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> ---
>  .../bindings/leds/backlight/{pm8941-wled.txt => qcom-wled.txt}    | 2 +-

Please split DT bindings from driver patches.

>  drivers/video/backlight/Kconfig                                   | 8 ++++----
>  drivers/video/backlight/Makefile                                  | 2 +-
>  drivers/video/backlight/{pm8941-wled.c => qcom-wled.c}            | 0
>  4 files changed, 6 insertions(+), 6 deletions(-)
>  rename Documentation/devicetree/bindings/leds/backlight/{pm8941-wled.txt => qcom-wled.txt} (95%)
>  rename drivers/video/backlight/{pm8941-wled.c => qcom-wled.c} (100%)
