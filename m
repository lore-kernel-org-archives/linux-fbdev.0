From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 16 Apr 2018 14:38:01 +0000
Subject: Re: [PATCHv4 03/10] mfd: ti-lmu: use managed resource for everything
Message-Id: <20180416143801.umzbwdmmiotnblxh@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
 <20180330172414.26575-4-sebastian.reichel@collabora.co.uk>
In-Reply-To: <20180330172414.26575-4-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Milo Kim <Milo.Kim@ti.com>, Daniel Thompson <daniel.thompson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Jingoo Han <jingoohan1@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

On Fri, 30 Mar 2018, Sebastian Reichel wrote:

> This replaces all remaining unmanaged resources with device
> managed ones, so that the remove function is no longer needed.
> This makes the code slightly shorter and fixes two problems:
> 
> 1. The hardware is disabled after the child devices have
>    been removed. Previously there was a potential race
>    condition.
> 2. The hardware is disabled when mfd_add_devices fails
>    during probe.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  drivers/mfd/ti-lmu.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
