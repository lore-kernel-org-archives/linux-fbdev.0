From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 11 Nov 2019 09:25:43 +0000
Subject: Re: [PATCH V10 8/8] backlight: qcom-wled: Add auto string detection logic
Message-Id: <20191111092543.GV18902@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1572589624-6095-1-git-send-email-kgunda@codeaurora.org>
 <1572589624-6095-9-git-send-email-kgunda@codeaurora.org>
In-Reply-To: <1572589624-6095-9-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Kiran Gunda <kgunda@codeaurora.org>
Cc: bjorn.andersson@linaro.org, jingoohan1@gmail.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, daniel.thompson@linaro.org, jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org

On Fri, 01 Nov 2019, Kiran Gunda wrote:

> The auto string detection algorithm checks if the current WLED
> sink configuration is valid. It tries enabling every sink and
> checks if the OVP fault is observed. Based on this information
> it detects and enables the valid sink configuration.
> Auto calibration will be triggered when the OVP fault interrupts
> are seen frequently thereby it tries to fix the sink configuration.
> 
> The auto-detection also kicks in when the connected LED string
> of the display-backlight malfunctions (because of damage) and
> requires the damaged string to be turned off to prevent the
> complete panel and/or board from being damaged.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  drivers/video/backlight/qcom-wled.c | 400 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 394 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
