From: Shawn Guo <shawn.guo@linaro.org>
Date: Sat, 06 Jul 2013 06:04:55 +0000
Subject: Re: [PATCH 4/4] fb: Add DCU framebuffer driver for Vybrid VF610 platform
Message-Id: <20130706060453.GE30164@S2101-09.ap.freescale.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1373010702-9244-1-git-send-email-b18965@freescale.com>
 <1373010702-9244-5-git-send-email-b18965@freescale.com>
In-Reply-To: <1373010702-9244-5-git-send-email-b18965@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Jul 05, 2013 at 03:51:42PM +0800, Alison Wang wrote:
> The Display Controller Unit (DCU) module is a system master that
> fetches graphics stored in internal or external memory and displays
> them on a TFT LCD panel. A wide range of panel sizes is supported
> and the timing of the interface signals is highly configurable.
> Graphics are read directly from memory and then blended in real-time,
> which allows for dynamic content creation with minimal CPU intervention.
> 
> The features:
> 
> (1) Full RGB888 output to TFT LCD panel.
> (2) For the current LCD panel, WQVGA "480x272" is supported.
> (3) Blending of each pixel using up to 4 source layers dependent on size of panel.
> (4) Each graphic layer can be placed with one pixel resolution in either axis.
> (5) Each graphic layer support RGB565 and RGB888 direct colors without alpha channel
> and BGRA8888 direct colors with an alpha channel.
> (6) Each graphic layer support alpha blending with 8-bit resolution.
> 
> This driver has been tested on Vybrid VF610 TOWER board.
> 
> Signed-off-by: Alison Wang <b18965@freescale.com>
> ---
>  drivers/video/Kconfig      |    9 +
>  drivers/video/Makefile     |    1 +
>  drivers/video/fsl-dcu-fb.c | 1091 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1101 insertions(+)
>  create mode 100644 drivers/video/fsl-dcu-fb.c

You should have a document under Documentation/devicetree/bindings/fb/.

Shawn

