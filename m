From: Olof Johansson <olof@lixom.net>
Date: Wed, 03 Apr 2013 06:46:53 +0000
Subject: Re: [PATCH] video: implement a dumb framebuffer driver
Message-Id: <20130403064653.GA6263@quad.lixom.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1364969830-6481-1-git-send-email-swarren@wwwdotorg.org>
In-Reply-To: <1364969830-6481-1-git-send-email-swarren@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Apr 03, 2013 at 12:17:10AM -0600, Stephen Warren wrote:
> A dumb frame-buffer describes a raw memory region that may be rendered
> to, with the assumption that the display hardware has already been set
> up to scan out from that buffer.
> 
> This is useful in cases where a bootloader exists and has set up the
> display hardware, but a Linux driver doesn't yet exist for the display
> hardware.
> 
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
> ---
> Should this be merged through akpm's tree (I think many fb drivers are
> these days), or if not, I could take it through the bcm2835 tree.

Yes, through akpm is the way to go (with ack from Rob/Grant for bindings).

> I ended up going with a separate FB driver:
> * DRM/KMS look much more complex, and don't provide any benefit that I can
>   tell for this simple driver.
> * Creating a separate driver rather than adjusting offb.c to work allows a
>   new clean binding to be defined, and doesn't require removing or ifdefing
>   PPC-isms in offb.c.

Sounds reasonable.

I've got some opinions on the color of this shed below. I don't have strong
opinions on the matter though.

> 
>  .../devicetree/bindings/video/dumb-framebuffer.txt |   25 +++
>  drivers/video/Kconfig                              |   17 ++
>  drivers/video/Makefile                             |    1 +
>  drivers/video/dumbfb.c                             |  234 ++++++++++++++++++++
>  4 files changed, 277 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/dumb-framebuffer.txt
>  create mode 100644 drivers/video/dumbfb.c
> 
> diff --git a/Documentation/devicetree/bindings/video/dumb-framebuffer.txt b/Documentation/devicetree/bindings/video/dumb-framebuffer.txt
> new file mode 100644
> index 0000000..ba6676b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/dumb-framebuffer.txt
> @@ -0,0 +1,25 @@
> +Dumb Framebuffer
> +
> +A dumb frame-buffer describes a raw memory region that may be rendered to,
> +with the assumption that the display hardware has already been set up to scan
> +out from that buffer.

I think we have preferred "simple" over "dumb" in the past in other context.

> +
> +Required properties:
> +- compatible: "dumb-framebuffer"
> +- reg: Should contain the location and size of the framebuffer memory.
> +- width: The width of the framebuffer in pixels.
> +- height: The height of the framebuffer in pixels.
> +- stride: The number of bytes in each line of the framebuffer.
> +- format: The format of the framebuffer surface. Valid values are:
> +  r5g6b5: A 16bpp format.

Hm, I'm used to this being written as "rgb565", which is also the format
string that the fsl-imx-drm binding seems to use.

I guess actual depth can easily be derived from format.

> +Example:
> +
> +	framebuffer {
> +		compatible = "dumb-framebuffer";
> +		reg = <0x1d385000 (1600 * 1200 * 2)>;
> +		width = <1600>;
> +		height = <1200>;
> +		stride = <(1600 * 2)>;
> +		format = "r5g6b5";
> +	};


-Olof
