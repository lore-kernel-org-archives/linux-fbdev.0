From: Ladislav Michl <ladis@linux-mips.org>
Date: Mon, 15 Jan 2018 15:30:19 +0000
Subject: Re: [PATCH v2 0/5] video: udlfb: (not only) Logging cleanup
Message-Id: <20180115153019.GA2232@lenoch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180104193623.GA22612@lenoch>
In-Reply-To: <20180104193623.GA22612@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

Bartlomiej,

On Mon, Jan 15, 2018 at 03:28:35PM +0100, Bartlomiej Zolnierkiewicz wrote:
> I queued patches #1-4 for v4.16, thanks.
> 
> > >   video: udlfb: Switch from the pr_*() to the dev_*() logging functions
> 
> This one introduces new compile time warning:
> 
> drivers/video/fbdev/udlfb.c: In function ‘dlfb_init_framebuffer_work’:
> drivers/video/fbdev/udlfb.c:1694:24: warning: ignoring return value of ‘device_create_bin_file’, declared with attribute warn_unused_result [-Wunused-result]
>   device_create_bin_file(info->dev, &edid_attr);
>                         ^
> 
> Checking of device_create_bin_file()'s return value should not be removed,
> 
> [ ditto for device_create_file() ]
> 
> Also please fix the new comment introduced by the patch:
> 
> +               /* parent device is used otherwise*/
> 
> [  ...e*/ -> ...e */ ]

Fixed those and few more checkpatch warnings and will send v3 of just this
patch. However I'd like to know what toolchain are you using as I didn't
see above warning.

Thank you,
	ladis
