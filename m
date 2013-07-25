From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 25 Jul 2013 23:52:09 +0000
Subject: Re: [PATCHv2 3/3] fb: backlight: HX8357: Add HX8369 support
Message-Id: <002301ce8991$f9b82060$ed286120$@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1374757513-2253-1-git-send-email-maxime.ripard@free-electrons.com>
 <1374757513-2253-4-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1374757513-2253-4-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thursday, July 25, 2013 10:05 PM, Maxime Ripard wrote:
> 
> From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> Add support for the Himax HX8369 controller as it is quite similar to the
> hx8357.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/video/backlight/hx8357.c | 221 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 206 insertions(+), 15 deletions(-)
> 

[....]

> +	ret = hx8357_spi_write_byte(lcdev, HX8357_SET_DISPLAY_ON);
> +	if (ret < 0)
> +		return ret;
> +
> +	msleep(100);

Hi Maxime Ripard,

Could you add comment on this huge delay, too?

Best regards,
Jingoo Han


