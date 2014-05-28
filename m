From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 28 May 2014 21:13:42 +0000
Subject: Re: [PATCH v2 1/5] gpu: ipu-v3: Move i.MX IPUv3 core driver out of staging
Message-Id: <20140528211342.GA18203@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1401113983-23132-1-git-send-email-p.zabel@pengutronix.de>
 <1401113983-23132-2-git-send-email-p.zabel@pengutronix.de>
In-Reply-To: <1401113983-23132-2-git-send-email-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, drm-devel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, kernel@pengutronix.de, Dave Airlie <airlied@redhat.com>, Russell King <rmk+kernel@arm.linux.org.uk>

On Mon, May 26, 2014 at 04:19:39PM +0200, Philipp Zabel wrote:
> The i.MX Image Processing Unit (IPU) contains a number of image processing
> blocks that sit right in the middle between DRM and V4L2. Some of the modules,
> such as Display Controller, Processor, and Interface (DC, DP, DI) or CMOS
> Sensor Interface (CSI) and their FIFOs could be assigned to either framework,
> but others, such as the dma controller (IDMAC) and image converter (IC) can
> be used by both.
> The IPUv3 core driver provides an internal API to access the modules, to be
> used by both DRM and V4L2 IPUv3 drivers.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
> Changes since RFC:
>  - Rebased onto current staging-next
>  - Removed an unrelated change to ipu_pixelformat_to_colorspace
>  - Avoided moving around the IPU_PIX_FMT_GBR24 #define


Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
