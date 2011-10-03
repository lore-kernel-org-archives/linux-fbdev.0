From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Mon, 03 Oct 2011 16:17:47 +0000
Subject: Re: [PATCH 1/9] drivers/video: fsl-diu-fb: fix some ioctls
Message-Id: <4E89E02B.9060201@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1317244795-24671-1-git-send-email-timur@freescale.com>
In-Reply-To: <1317244795-24671-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 09/28/2011 09:19 PM, Timur Tabi wrote:
> Use the _IOx macros to define the ioctl commands, instead of hard-coded
> numbers.  Unfortunately, the original definitions of MFB_SET_PIXFMT and
> MFB_GET_PIXFMT used the wrong value for the size, so this will break
> binary compatibility with older applications.

Don't break compatibility without the need to do so. Ask yourself whether using
those macros is really worth it. If the answer is yes, at least give userspace a
grace period, some kernel versions where both values work. For example you could
rename the old numerical ones to MFB_SET_PIXFMT_OLD and then add a compatibility
IOCTL, for example like this

case MFB_SET_PIXFMT_OLD:
	/* you could add a warning message here */
case MFB_SET_PIXFMT:
	...

Not much work and you could delete the compatibility stuff in a year or two but
it would it make much easier for users to upgrade.

I don't know your driver, can int be only 32 bit on all plattforms where it can
be used or is this another thing where compatibility can break?


Best regards,

Florian Tobias Schandinat

> 
> Also remove the FBIOGET_GWINFO and FBIOPUT_GWINFO ioctls.  FBIOPUT_GWINFO
> was never implemented, and FBIOGET_GWINFO was never used by any
> application.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>  drivers/video/fsl-diu-fb.c |    8 --------
>  include/linux/fsl-diu-fb.h |   20 ++++++++------------
>  2 files changed, 8 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
> index 5137fbb..e5905b7 100644
> --- a/drivers/video/fsl-diu-fb.c
> +++ b/drivers/video/fsl-diu-fb.c
> @@ -1030,14 +1030,6 @@ static int fsl_diu_ioctl(struct fb_info *info, unsigned int cmd,
>  			ad->ckmin_b = ck.blue_min;
>  		}
>  		break;
> -	case FBIOGET_GWINFO:
> -		if (mfbi->type = MFB_TYPE_OFF)
> -			return -ENODEV;
> -		/* get graphic window information */
> -		if (copy_to_user(buf, ad, sizeof(*ad)))
> -			return -EFAULT;
> -		break;
> -
>  	default:
>  		dev_err(info->dev, "unknown ioctl command (0x%08X)\n", cmd);
>  		return -ENOIOCTLCMD;
> diff --git a/include/linux/fsl-diu-fb.h b/include/linux/fsl-diu-fb.h
> index df23f59..5efb407 100644
> --- a/include/linux/fsl-diu-fb.h
> +++ b/include/linux/fsl-diu-fb.h
> @@ -33,22 +33,18 @@ struct mfb_chroma_key {
>  };
>  
>  struct aoi_display_offset {
> -	int x_aoi_d;
> -	int y_aoi_d;
> +	__s32 x_aoi_d;
> +	__s32 y_aoi_d;
>  };
>  
>  #define MFB_SET_CHROMA_KEY	_IOW('M', 1, struct mfb_chroma_key)
>  #define MFB_SET_BRIGHTNESS	_IOW('M', 3, __u8)
> -
> -#define MFB_SET_ALPHA		0x80014d00
> -#define MFB_GET_ALPHA		0x40014d00
> -#define MFB_SET_AOID		0x80084d04
> -#define MFB_GET_AOID		0x40084d04
> -#define MFB_SET_PIXFMT		0x80014d08
> -#define MFB_GET_PIXFMT		0x40014d08
> -
> -#define FBIOGET_GWINFO		0x46E0
> -#define FBIOPUT_GWINFO		0x46E1
> +#define MFB_SET_ALPHA		_IOW('M', 0, __u8)
> +#define MFB_GET_ALPHA		_IOR('M', 0, __u8)
> +#define MFB_SET_AOID		_IOW('M', 4, struct aoi_display_offset)
> +#define MFB_GET_AOID		_IOR('M', 4, struct aoi_display_offset)
> +#define MFB_SET_PIXFMT		_IOW('M', 8, __u32)
> +#define MFB_GET_PIXFMT		_IOR('M', 8, __u32)
>  
>  #ifdef __KERNEL__
>  #include <linux/spinlock.h>

