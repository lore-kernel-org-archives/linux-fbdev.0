From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 01 Jun 2020 13:25:17 +0000
Subject: Re: [PATCH] drivers/video: cleanup coding style in video a bit
Message-Id: <dacf902f-12c1-44ff-b214-b05446f07829@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200427080542eucas1p172bdcfd22affc288ec1ceaadf0dad2b0@eucas1p1.samsung.com>
 <20200427080530.3234-1-bernard@vivo.com>
In-Reply-To: <20200427080530.3234-1-bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bernard Zhao <bernard@vivo.com>
Cc: opensource.kernel@vivo.com, linux-fbdev@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Uma Shankar <uma.shankar@intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Shashank Sharma <shashank.sharma@intel.com>


On 4/27/20 10:05 AM, Bernard Zhao wrote:
> Eliminate the magic numbers, add vender infoframe size macro
> like other hdmi modules.
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>

Applied to drm-misc-next tree (patch should show up in v5.9), thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/hdmi.c | 2 +-
>  include/linux/hdmi.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
> index 856a8c4e84a2..f693076f2e5f 100644
> --- a/drivers/video/hdmi.c
> +++ b/drivers/video/hdmi.c
> @@ -495,7 +495,7 @@ int hdmi_vendor_infoframe_init(struct hdmi_vendor_infoframe *frame)
>  	 * value
>  	 */
>  	frame->s3d_struct = HDMI_3D_STRUCTURE_INVALID;
> -	frame->length = 4;
> +	frame->length = HDMI_VENDOR_INFOFRAME_SIZE;
>  
>  	return 0;
>  }
> diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
> index 9613d796cfb1..ff25aeb95ee4 100644
> --- a/include/linux/hdmi.h
> +++ b/include/linux/hdmi.h
> @@ -57,6 +57,7 @@ enum hdmi_infoframe_type {
>  #define HDMI_SPD_INFOFRAME_SIZE    25
>  #define HDMI_AUDIO_INFOFRAME_SIZE  10
>  #define HDMI_DRM_INFOFRAME_SIZE    26
> +#define HDMI_VENDOR_INFOFRAME_SIZE  4
>  
>  #define HDMI_INFOFRAME_SIZE(type)	\
>  	(HDMI_INFOFRAME_HEADER_SIZE + HDMI_ ## type ## _INFOFRAME_SIZE)
> 
