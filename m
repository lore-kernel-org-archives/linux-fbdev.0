From: Timur Tabi <timur@tabi.org>
Date: Wed, 13 Mar 2013 15:37:39 +0000
Subject: Re: [PATCH] fbdev: fsl-diu-fb: optionally configure frame buffer depth in DT
Message-Id: <51409D43.4080902@tabi.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363188249-29341-1-git-send-email-agust@denx.de>
In-Reply-To: <1363188249-29341-1-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 03/13/2013 10:24 AM, Anatolij Gustschin wrote:
> @@ -30,5 +31,6 @@ Example for MPC5121:
>  		reg = <0x2100 0x100>;
>  		interrupts = <64 0x8>;
>  		interrupt-parent = <&ipic>;
> +		depth = <16>;

NACK.

Device trees are supposed to be used for describing the hardware, not
for software configuration.  Besides, the driver already supports a
command-line parameter for the color depth.  Your patch just overrides
that parameter (default_bpp) with a device tree property.

module_param_named(mode, fb_mode, charp, 0);
MODULE_PARM_DESC(mode,
        "Specify resolution as \"<xres>x<yres>[-<bpp>][@<refresh>]\" ");
module_param_named(bpp, default_bpp, ulong, 0);
MODULE_PARM_DESC(bpp, "Specify bit-per-pixel if not specified in 'mode'");
module_param_named(monitor, monitor_string, charp, 0);
MODULE_PARM_DESC(monitor, "Specify the monitor port "
        "(\"dvi\", \"lvds\", or \"dlvds\") if supported by the platform");
