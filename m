From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 25 Jan 2011 06:49:49 +0000
Subject: Re: [PATCH 4/4 v5] powerpc, video: add SM501 support for charon board.
Message-Id: <20110125064949.GF11673@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1291451028-22532-2-git-send-email-hs@denx.de>
	<1295937946-26934-1-git-send-email-hs@denx.de>
In-Reply-To: <1295937946-26934-1-git-send-email-hs-ynQEQJNshbs@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Vincent Sanders <vince-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org

On Tue, Jan 25, 2011 at 07:45:46AM +0100, Heiko Schocher wrote:
> @@ -197,6 +198,15 @@
>  			#address-cells = <1>;
>  		};
>  
> +		display@1,0 {
> +			compatible = "smi,sm501";
> +			reg = <1 0x00000000 0x00800000
> +			       1 0x03e00000 0x00200000>;
> +			mode = "640x480-32@60";
> +			interrupts = <1 1 3>;
> +			little-endian;
> +		};
> +

The endian designation looks good, but it still doesn't explain why you
have a remaining CONFIG_PPC_MPC52xx ifdef encapsulating the property
check in the sm501fb patch. It shouldn't be needed at all. If the
platform supports OF then the property will need to be set one way or the
other, so there is no need for any board or CPU ifdeffery within the
driver itself.
