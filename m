From: Marek Vasut <marex@denx.de>
Date: Mon, 20 May 2019 13:43:30 +0000
Subject: Re: [PATCH] video: fbdev: mxsfb: Remove driver
Message-Id: <1bb6a117-dcf4-8842-0c3a-c3e015b2f0a9@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190520130612.2214-1-festevam@gmail.com>
In-Reply-To: <20190520130612.2214-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fabio Estevam <festevam@gmail.com>, b.zolnierkie@samsung.com
Cc: dri-devel@lists.freedesktop.org, shawnguo@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de, linux-fbdev@vger.kernel.org

On 5/20/19 3:06 PM, Fabio Estevam wrote:
> There is a DRM version of the mxsfb driver for quite some time
> at drivers/gpu/drm/mxsfb/, so there is no need to keep maintaining
> the fbdev version any longer.
> 
> Remove the fbdev mxsfb driver in favour of the DRM version.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Acked-by: Marek Vasut <marex@denx.de>

-- 
Best regards,
Marek Vasut
