From: Samuel Ortiz <sameo@linux.intel.com>
Date: Fri, 22 Mar 2013 16:34:09 +0000
Subject: Re: [PATCH v3 1/3] mfd: as3711: add OF support
Message-Id: <20130322163409.GA8997@zurbaran>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363968949-12151-1-git-send-email-g.liakhovetski@gmx.de>
 <1363968949-12151-2-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1363968949-12151-2-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, devicetree-discuss@lists.ozlabs.org, Richard Purdie <rpurdie@rpsys.net>, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Hi Guennadi,

On Fri, Mar 22, 2013 at 05:15:47PM +0100, Guennadi Liakhovetski wrote:
> Add Flat Device Tree support to the AS3711 MFD driver. This patch just
> allows to bind the driver to I2C devices, instantiated from the DT.
> DT support for AS3711 cell drivers will be added in separate drivers.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> Reviwed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  Documentation/devicetree/bindings/mfd/as3711.txt |   73 ++++++++++++++++++++++
>  drivers/mfd/as3711.c                             |   27 +++++++-
>  2 files changed, 96 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/as3711.txt
Applied, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
