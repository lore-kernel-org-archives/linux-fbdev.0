From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 07 Oct 2010 05:28:19 +0000
Subject: Re: [PATCH 2/2] powerpc/85xx: add DIU support to the Freecale P1022DS reference board
Message-Id: <0088605C-957A-4AA8-9E1D-05EE2F1F7115@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1284057597-17126-1-git-send-email-timur@freescale.com>
	<1284057597-17126-2-git-send-email-timur@freescale.com>
In-Reply-To: <1284057597-17126-2-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-fbdev@vger.kernel.org, yorksun@freescale.com


On Sep 9, 2010, at 1:39 PM, Timur Tabi wrote:

> +static void p1022ds_set_monitor_port(int monitor_port)
> +{
> +	struct device_node *pixis_node;
> +	u8 __iomem *brdcfg1;
> +
> +	pixis_node = of_find_compatible_node(NULL, NULL, "fsl,fpga-pixis");
> +	if (!pixis_node) {
> +		pr_err("p1022ds: missing ngPIXIS node\n");
> +		return;
> +	}
> +

update based on change to compatible in .dts

- k

