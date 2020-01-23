From: Lee Jones <lee.jones@linaro.org>
Date: Thu, 23 Jan 2020 07:53:45 +0000
Subject: Re: [PATCH -next v2] backlight: qcom-wled: fix unsigned comparison to zero
Message-Id: <20200123075345.GO15507@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200122013240.132861-1-chenzhou10@huawei.com>
In-Reply-To: <20200122013240.132861-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Chen Zhou <chenzhou10@huawei.com>
Cc: daniel.thompson@linaro.org, kgunda@codeaurora.org, b.zolnierkie@samsung.com, jingoohan1@gmail.com, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, bjorn.andersson@linaro.org, agross@kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 22 Jan 2020, Chen Zhou wrote:

> Fixes coccicheck warning:
> ./drivers/video/backlight/qcom-wled.c:1104:5-15:
> 	WARNING: Unsigned expression compared with zero: string_len > 0
> 
> The unsigned variable string_len is assigned a return value from the call
> to of_property_count_elems_of_size(), which may return negative error code.
> 
> Fixes: 775d2ffb4af6 ("backlight: qcom-wled: Restructure the driver for WLED3")
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> changes in v2:
> - fix commit message description.
> 
> ---
>  drivers/video/backlight/qcom-wled.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
