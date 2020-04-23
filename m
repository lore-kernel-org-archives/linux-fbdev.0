From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Thu, 23 Apr 2020 17:08:56 +0000
Subject: Re: [PATCH V6 4/4] backlight: qcom-wled: Add support for WLED5 peripheral that is present on PM8150L
Message-Id: <20200423170856.f4r62iwcg7qtppva@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1587656017-27911-1-git-send-email-kgunda@codeaurora.org>
 <1587656017-27911-5-git-send-email-kgunda@codeaurora.org>
In-Reply-To: <1587656017-27911-5-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kiran Gunda <kgunda@codeaurora.org>
Cc: mark.rutland@arm.com, linux-fbdev@vger.kernel.org, b.zolnierkie@samsung.com, jingoohan1@gmail.com, Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, bjorn.andersson@linaro.org, devicetree@vger.kernel.org, robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz, linux-arm-msm@vger.kernel.org, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, lee.jones@linaro.org, linux-leds@vger.kernel.org

On Thu, Apr 23, 2020 at 09:03:37PM +0530, Kiran Gunda wrote:
> From: Subbaraman Narayanamurthy <subbaram@codeaurora.org>
> 
> PM8150L WLED supports the following:
>     - Two modulators and each sink can use any of the modulator
>     - Multiple CABC selection options from which one can be selected/enabled
>     - Multiple brightness width selection (12 bits to 15 bits)
> 
> Signed-off-by: Subbaraman Narayanamurthy <subbaram@codeaurora.org>
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
