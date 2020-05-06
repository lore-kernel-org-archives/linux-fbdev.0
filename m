From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 06 May 2020 10:08:34 +0000
Subject: Re: [PATCH V6 4/4] backlight: qcom-wled: Add support for WLED5 peripheral that is present on PM8150L
Message-Id: <20200506100834.GG823950@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1587656017-27911-1-git-send-email-kgunda@codeaurora.org>
 <1587656017-27911-5-git-send-email-kgunda@codeaurora.org>
In-Reply-To: <1587656017-27911-5-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Kiran Gunda <kgunda@codeaurora.org>
Cc: mark.rutland@arm.com, daniel.thompson@linaro.org, b.zolnierkie@samsung.com, jingoohan1@gmail.com, Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, bjorn.andersson@linaro.org, devicetree@vger.kernel.org, robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz, linux-arm-msm@vger.kernel.org, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, linux-fbdev@vger.kernel.org, linux-leds@vger.kernel.org

On Thu, 23 Apr 2020, Kiran Gunda wrote:

> From: Subbaraman Narayanamurthy <subbaram@codeaurora.org>
> 
> PM8150L WLED supports the following:
>     - Two modulators and each sink can use any of the modulator
>     - Multiple CABC selection options from which one can be selected/enabled
>     - Multiple brightness width selection (12 bits to 15 bits)
> 
> Signed-off-by: Subbaraman Narayanamurthy <subbaram@codeaurora.org>
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> ---
>  drivers/video/backlight/qcom-wled.c | 378 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 376 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
