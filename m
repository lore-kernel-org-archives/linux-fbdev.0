From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Tue, 04 Oct 2011 20:19:20 +0000
Subject: Re: [patch] smscufx: change edid data to u8 instead of char
Message-Id: <4E8B6A48.8060003@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 09/21/2011 07:16 AM, Dan Carpenter wrote:
> Having "edid" as char caused a problem in ufx_read_edid() where we
> compared "edid[i] != 0xFF".  Because of the type difference, the
> condition was never true and the error checking failed.
> 
> Also I added a __user notation to silence a sparse complaint.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
> Compile tested only.  Please test carefully.
> 
> diff --git a/drivers/video/smscufx.c b/drivers/video/smscufx.c
> index 44c8cab..aaccffa 100644
> --- a/drivers/video/smscufx.c
> +++ b/drivers/video/smscufx.c
> @@ -103,7 +103,7 @@ struct ufx_data {
>  	struct delayed_work free_framebuffer_work;
>  	atomic_t usb_active; /* 0 = update virtual buffer, but no usb traffic */
>  	atomic_t lost_pixels; /* 1 = a render op failed. Need screen refresh */
> -	char *edid; /* null until we read edid from hw or get from sysfs */
> +	u8 *edid; /* null until we read edid from hw or get from sysfs */
>  	size_t edid_size;
>  	u32 pseudo_palette[256];
>  };
> @@ -993,7 +993,7 @@ static int ufx_ops_ioctl(struct fb_info *info, unsigned int cmd,
>  
>  	/* TODO: Update X server to get this from sysfs instead */
>  	if (cmd = UFX_IOCTL_RETURN_EDID) {
> -		char *edid = (char *)arg;
> +		u8 __user *edid = (u8 __user *)arg;
>  		if (copy_to_user(edid, dev->edid, dev->edid_size))
>  			return -EFAULT;
>  		return 0;
> @@ -1428,7 +1428,7 @@ static int ufx_i2c_wait_busy(struct ufx_data *dev)
>  }
>  
>  /* reads a 128-byte EDID block from the currently selected port and TAR */
> -static int ufx_read_edid(struct ufx_data *dev, char *edid, int edid_len)
> +static int ufx_read_edid(struct ufx_data *dev, u8 *edid, int edid_len)
>  {
>  	int i, j, status;
>  	u32 *edid_u32 = (u32 *)edid;
> @@ -1491,7 +1491,7 @@ static int ufx_setup_modes(struct ufx_data *dev, struct fb_info *info,
>  	char *default_edid, size_t default_edid_size)
>  {
>  	const struct fb_videomode *default_vmode = NULL;
> -	char *edid;
> +	u8 *edid;
>  	int i, result = 0, tries = 3;
>  
>  	if (info->dev) /* only use mutex if info has been registered */
> 

