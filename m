From: Stephen Warren <swarren@wwwdotorg.org>
Date: Wed, 08 Aug 2012 18:47:32 +0000
Subject: Re: [PATCH 5/8] video: vt8500: Add devicetree support for vt8500-fb and wm8505-fb
Message-Id: <5022B444.2020501@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344389967-8465-1-git-send-email-linux@prisktech.co.nz>
 <1344389967-8465-6-git-send-email-linux@prisktech.co.nz>
In-Reply-To: <1344389967-8465-6-git-send-email-linux@prisktech.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 08/07/2012 07:39 PM, Tony Prisk wrote:
> Update vt8500-fb, wm8505-fb and wmt-ge-rops to support device
> tree bindings.

> Small change in wm8505-fb.c to support WM8650 framebuffer color
> format.

That might warrant a separate patch?

> diff --git a/drivers/video/vt8500lcdfb.c b/drivers/video/vt8500lcdfb.c

> +	np = of_find_node_by_name(NULL, "display");
> +	if (!np) {
> +		pr_err("%s: No display description in Device Tree\n", __func__);
> +		ret = -EINVAL;
> +		goto failed_free_res;
> +	}

I believe that using hard-coded node names is frowned upon. Better would
be to put a phandle into the display controller's node that points at
the node representing the display, e.g.:

    fb@d800e400 {
        compatible = "via,vt8500-fb";
        reg = <0xd800e400 0x400>;
        interrupts = <12>;
        via,display = <&display>;
    };
    display: display {
        ...
    };

