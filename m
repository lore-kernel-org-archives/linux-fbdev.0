From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Thu, 01 Feb 2018 11:06:42 +0000
Subject: Re: [PATCH 2/5] backlight: lp855x: document sysfs attributes
Message-Id: <20180201110642.qyjwyrdwglevlk5f@oak.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1516978005.git.aishpant@gmail.com>
 <09cd01366bf3b5c3030ad25450b46a9a3bc8a747.1516978005.git.aishpant@gmail.com>
In-Reply-To: <09cd01366bf3b5c3030ad25450b46a9a3bc8a747.1516978005.git.aishpant@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aishwarya Pant <aishpant@gmail.com>
Cc: Milo Kim <milo.kim@ti.com>, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Julia Lawall <julia.lawall@lip6.fr>, Greg KH <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>

On Fri, Jan 26, 2018 at 08:23:00PM +0530, Aishwarya Pant wrote:
> Add documentation for sysfs interface of Texas Instruments lp855x
> backlight driver by reading code and looking through git commit logs.
> 
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> ---
>  .../ABI/testing/sysfs-class-backlight-lp855x          | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-lp855x
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-backlight-lp855x b/Documentation/ABI/testing/sysfs-class-backlight-lp855x
> new file mode 100644
> index 000000000000..5b9d38958875
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-backlight-lp855x
> @@ -0,0 +1,19 @@
> +sysfs interface for Texas Instruments lp855x backlight driver
> +------------------------------------------------------------
> +
> +What:		/sys/class/backlight/<backlight>/chip_id
> +Date:		Mar, 2012
> +KernelVersion:	v3.10
> +Contact:	Milo Kim <milo.kim@ti.com>
> +Description:
> +		(RO) Displays the lp8755x chip id. Possible values are:
> +		lp8550, lp8551, lp8552, lp8553, lp8555, lp8556 or lp8557.
> +
> +
> +What:		/sys/class/backlight/<backlight>/bl_ctl_mode
> +Date:		Mar, 2012
> +KernelVersion:	v3.10
> +Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
> +Description:
> +		(RO) Displays whether the brightness is controlled by the pwm
> +		input("pwm based) or the i2c register("register based").

Since like the first patch in the series, these look like they are for
debugging. That thread is still active but whatever the outcome of that
thread please assume it also applies to this patch.


Daniel.
