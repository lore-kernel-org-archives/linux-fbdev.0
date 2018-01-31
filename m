From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Wed, 31 Jan 2018 11:34:23 +0000
Subject: Re: [PATCH 3/5] backlight: lm3639: document sysfs attributes
Message-Id: <20180131113423.v56373pepryyvl5x@oak.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1516978005.git.aishpant@gmail.com>
 <3b913654039eefb786abd6a29b99a74b8063830c.1516978005.git.aishpant@gmail.com>
In-Reply-To: <3b913654039eefb786abd6a29b99a74b8063830c.1516978005.git.aishpant@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aishwarya Pant <aishpant@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Julia Lawall <julia.lawall@lip6.fr>, Greg KH <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>

On Fri, Jan 26, 2018 at 08:23:57PM +0530, Aishwarya Pant wrote:
> Add documentation for sysfs interfaces of Texas Instruments lm3639
> backlight + flash led driver chip by looking through git commits and
> reading code.
> 
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-class-backlight-lm3639 | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-lm3639
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-backlight-lm3639 b/Documentation/ABI/testing/sysfs-class-backlight-lm3639
> new file mode 100644
> index 000000000000..ec87dc8f4395
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-backlight-lm3639
> @@ -0,0 +1,13 @@
> +sysfs interface for Texas Instruments lm3639 backlight + flash led driver chip
> +------------------------------------------------------------------------------
> +
> +What:		/sys/class/backlight/<backlight>/bled_mode
> +Date:		Oct, 2012
> +KernelVersion:	v3.10
> +Contact:	Lee Jones <lee.jones@linaro.org>,
> +		Daniel Thompson <daniel.thompson@linaro.org>,
> +		Jingoo Han <jingoohan1@gmail.com>

We've recently added a ML to MAINTAINERS (see
https://patchwork.kernel.org/patch/10169327/ ). I think a better Contact
might simply be:

Contact:	dri-devel@lists.freedesktop.org


> +Description:
> +		(WO) Write to the backlight mapping mode. The backlight current
> +		can be mapped for either exponential (value "0") or linear
> +		mapping modes (default).

The ambiguity of meaning w.r.t. linear or exponential is something of a thorn in 
the side of backlight... and so long as that ambiguity remains this
control is something the userspace may want to poke (albeit only once
during boot).

If you repost with an updated contact then please add my ack for this patch:
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
