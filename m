From: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Date: Wed, 10 Oct 2012 10:13:26 +0000
Subject: Re: [RFC PATCH 1/3] amba-clcd: Add Device Tree support to amba-clcd driver
Message-Id: <1349864006.3354.35.camel@linaro1.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348070666-9153-1-git-send-email-ryan.harkin@linaro.org>
 <1348070666-9153-2-git-send-email-ryan.harkin@linaro.org>
In-Reply-To: <1348070666-9153-2-git-send-email-ryan.harkin@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, 2012-09-19 at 17:04 +0100, Ryan Harkin wrote:
> Add support to parse the display configuration from device tree.
> 
> If the board does not provide platform specific functions in the struct
> clcd_board contained with the amba device info, then defaults are provided
> by the driver.
> 
> The device tree configuration can either ask for a DMA setup or provide a
> framebuffer address to be remapped into the driver.
> 
> Signed-off-by: Ryan Harkin <ryan.harkin@linaro.org>
> ---

<big snip>

>  static int clcdfb_probe(struct amba_device *dev, const struct amba_id *id)
>  {
>  	struct clcd_board *board = dev->dev.platform_data;
>  	struct clcd_fb *fb;
>  	int ret;
>  
> +#ifdef CONFIG_OF
> +	if (dev->dev.of_node) {
> +		const __be32 *prop;
> +		int len, na, ns;
> +		phys_addr_t reg_base;
> +
> +		na = of_n_addr_cells(dev->dev.of_node);
> +		ns = of_n_size_cells(dev->dev.of_node);
> +
> +		prop = of_get_property(dev->dev.of_node, "reg", &len);
> +		if (WARN_ON(!prop || len < (na + ns) * sizeof(*prop)))
> +			return -EINVAL;
> +		reg_base = of_read_number(prop, na);
> +
> +		if (dev->res.start != reg_base)
> +			return -EINVAL;

When the motherboard CLCD is used, the CLCD node is under the iofga node
and has a reg value equal to the offset from the start of the iofgpa,
however dev->res.start holds the calculated address of the start of the
iofga region plus the offset of the clcd, this means that the above
check fails.

The question is, what is the purpose of this check? Can't we rely on the
value of dev->res.start being consistent with dev->dev.of_node and so
just drop all the above code from "const __be32 *prop" onwards?

-- 
Tixy

