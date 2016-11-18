From: Rob Herring <robh@kernel.org>
Date: Fri, 18 Nov 2016 14:09:03 +0000
Subject: Re: [PATCHv0 1/1] fbdev: add Intel FPGA FRAME BUFFER driver
Message-Id: <20161118140903.q33zx7bk5nergq45@rob-hp-laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479287278-5192-1-git-send-email-hean.loong.ong@intel.com>
In-Reply-To: <1479287278-5192-1-git-send-email-hean.loong.ong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Ong, Hean Loong" <hean.loong.ong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, Nov 16, 2016 at 05:07:58PM +0800, Ong, Hean Loong wrote:
> From: Ong Hean Loong <hean.loong.ong@intel.com>
> 
> 	This patch enables the display port IP driver for
> 	Intel Arria 10 SOCFPGA Golden Hardware
> 	Reference Design (GHRD).
> 
> 	The driver requires enabling the options such as
> 	Coheherent Memory Allocation,
> 	Intel FPGA Frame Buffer, Frame Buffer Conasole
> 
> Signed-off-by: Ong Hean Loong <hean.loong.ong@intel.com>
> ---
>  .../devicetree/bindings/video/intelfpgavipfb.txt   |   22 ++

bindings/display/

It is preferred that bindings are a separate patch.

>  MAINTAINERS                                        |    6 +
>  drivers/video/fbdev/Kconfig                        |   15 +
>  drivers/video/fbdev/Makefile                       |    1 +
>  drivers/video/fbdev/intelfpgavipfb.c               |  302 ++++++++++++++++++++

AIUI, we're not taking new FB drivers. This should be a DRM driver 
instead.

>  5 files changed, 346 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/video/intelfpgavipfb.txt
>  create mode 100644 drivers/video/fbdev/intelfpgavipfb.c
> 
> diff --git a/Documentation/devicetree/bindings/video/intelfpgavipfb.txt b/Documentation/devicetree/bindings/video/intelfpgavipfb.txt
> new file mode 100644
> index 0000000..8928c99
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/intelfpgavipfb.txt
> @@ -0,0 +1,22 @@
> +Intel FPGA Video and Image Processing(VIP) Frame Buffer bindings
> +
> +Required properties:
> +- compatible: "intel,vip-frame-buffer2"

Should be something like 'intel,arria10-vip'. Describe the h/w block, 
frame-buffer is a Linux term.

> +- reg: Physical base address and length of the framebuffer controller's
> +  registers.
> +- max-width: The width of the framebuffer in pixels.
> +- max-height: The height of the framebuffer in pixels.
> +- bits-per-color: only "8" is currently supported

These are not h/w properties.

> +- mem-word-width = the bus width of the avalon master port on the frame reader

Needs a vendor prefix.

> +
> +Example:
> +
> +alt_vip_vfr_0: vip@0xff260000 {
> +	compatible = "intel,vip-frame-buffer2";
> +	reg = <0xff260000 0x00000080>;
> +	max-width = <1024>;
> +	max-height = <768>;
> +	bits-per-color = <8>;
> +	mem-word-width = <128>;
> +};
> +
