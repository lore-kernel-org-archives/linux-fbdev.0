From: Michael Hennerich <michael.hennerich@analog.com>
Date: Thu, 01 Feb 2018 16:28:06 +0000
Subject: Re: [PATCH 4/5] backlight: adp5520: document sysfs attributes
Message-Id: <53d4187f-98e3-4227-fdae-8a80f3ae3132@analog.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1516978005.git.aishpant@gmail.com>
 <fe0d47871d84f83a927e139928afaf754141b7fe.1516978005.git.aishpant@gmail.com>
In-Reply-To: <fe0d47871d84f83a927e139928afaf754141b7fe.1516978005.git.aishpant@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aishwarya Pant <aishpant@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>

On 26.01.2018 15:54, Aishwarya Pant wrote:
> Add documentation for sysfs interface of adp5520/adp5501 analog devices
> backlight driver by reading code and looking through git commit logs.
> 
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>   .../ABI/testing/sysfs-class-backlight-adp5520      | 31 ++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-adp5520
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-backlight-adp5520 b/Documentation/ABI/testing/sysfs-class-backlight-adp5520
> new file mode 100644
> index 000000000000..34b6ebafa210
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-backlight-adp5520
> @@ -0,0 +1,31 @@
> +sysfs interface for analog devices adp5520(01) backlight driver
> +---------------------------------------------------------------
> +
> +The backlight brightness control operates at three different levels for the
> +adp5520 and adp5501 devices: daylight (level 1), office (level 2) and dark
> +(level 3). By default the brightness operates at the daylight brightness level.
> +
> +What:		/sys/class/backlight/<backlight>/daylight_max
> +What:		/sys/class/backlight/<backlight>/office_max
> +What:		/sys/class/backlight/<backlight>/dark_max
> +Date:		Sep, 2009
> +KernelVersion:	v2.6.32
> +Contact:	Michael Hennerich <michael.hennerich@analog.com>
> +Description:
> +		(RW) Maximum current setting for the backlight when brightness
> +		is at one of the three levels (daylight, office or dark). This
> +		is an input code between 0 and 127, which is transformed to a
> +		value between 0 mA and 30 mA using linear or non-linear
> +		algorithms.
> +
> +What:		/sys/class/backlight/<backlight>/daylight_dim
> +What:		/sys/class/backlight/<backlight>/office_dim
> +What:		/sys/class/backlight/<backlight>/dark_dim
> +Date:		Sep, 2009
> +KernelVersion:	v2.6.32
> +Contact:	Michael Hennerich <michael.hennerich@analog.com>
> +Description:
> +		(RW) Dim current setting for the backlight when brightness is at
> +		one of the three levels (daylight, office or dark). This is an
> +		input code between 0 and 127, which is transformed to a value
> +		between 0 mA and 30 mA using linear or non-linear algorithms.
> 
