From: Dan Murphy <dmurphy@ti.com>
Date: Tue, 01 Oct 2019 15:17:57 +0000
Subject: Re: [PATCH V6 5/8] backlight: qcom-wled: Restructure the driver for WLED3
Message-Id: <6f50ea19-f320-b4e6-f269-4d1e2189fa77@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1569825553-26039-1-git-send-email-kgunda@codeaurora.org>
 <1569825553-26039-6-git-send-email-kgunda@codeaurora.org>
In-Reply-To: <1569825553-26039-6-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kiran Gunda <kgunda@codeaurora.org>, bjorn.andersson@linaro.org, jingoohan1@gmail.com, lee.jones@linaro.org, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, daniel.thompson@linaro.org, jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org

Kiran

On 9/30/19 1:39 AM, Kiran Gunda wrote:
> Restructure the driver to add the support for new WLED
> peripherals.
>
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>   drivers/video/backlight/qcom-wled.c | 395 ++++++++++++++++++++++--------------
>   1 file changed, 245 insertions(+), 150 deletions(-)
>
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index f191242..740f1b6 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -7,59 +7,71 @@
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/of_device.h>
> +#include <linux/of_address.h>
>   #include <linux/regmap.h>
>   
>   /* From DT binding */
> +#define WLED_MAX_STRINGS				4
> +
>   #define WLED_DEFAULT_BRIGHTNESS				2048
>   
> -#define WLED3_SINK_REG_BRIGHT_MAX			0xFFF
> -#define WLED3_CTRL_REG_VAL_BASE				0x40
> +#define WLED_SINK_REG_BRIGHT_MAX			0xFFF

Why did you change some of these again?

Can you just change it to the final #define in patch 4/8?

Dan

<snip>
