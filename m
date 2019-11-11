From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 11 Nov 2019 09:25:11 +0000
Subject: Re: [PATCH V10 4/8] backlight: qcom-wled: Rename PM8941* to WLED3
Message-Id: <20191111092511.GR18902@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1572589624-6095-1-git-send-email-kgunda@codeaurora.org>
 <1572589624-6095-5-git-send-email-kgunda@codeaurora.org>
In-Reply-To: <1572589624-6095-5-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Kiran Gunda <kgunda@codeaurora.org>
Cc: bjorn.andersson@linaro.org, jingoohan1@gmail.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, daniel.thompson@linaro.org, jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org

On Fri, 01 Nov 2019, Kiran Gunda wrote:

> Rename the PM8941* references as WLED3 to make the driver
> generic and have WLED support for other PMICs. Also rename
> "i_boost_limit" and "i_limit" variables to "boost_i_limit"
> and "string_i_limit" respectively to resemble the corresponding
> register names.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> ---
>  drivers/video/backlight/qcom-wled.c | 248 ++++++++++++++++++------------------
>  1 file changed, 125 insertions(+), 123 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
