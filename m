From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 16 Apr 2018 14:32:32 +0000
Subject: Re: [PATCHv4 02/10] mfd: ti-lmu: switch to gpiod
Message-Id: <20180416143232.gz2aacazsphexexy@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
 <20180330172414.26575-3-sebastian.reichel@collabora.co.uk>
In-Reply-To: <20180330172414.26575-3-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Milo Kim <Milo.Kim@ti.com>, Daniel Thompson <daniel.thompson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Jingoo Han <jingoohan1@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

On Fri, 30 Mar 2018, Sebastian Reichel wrote:

> Use new descriptor based API instead of the legacy one.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  drivers/mfd/ti-lmu.c       | 28 ++++++++++++----------------
>  include/linux/mfd/ti-lmu.h |  3 ++-
>  2 files changed, 14 insertions(+), 17 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
