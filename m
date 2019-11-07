From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 07 Nov 2019 08:33:54 +0000
Subject: Re: [RFC PATCH 05/12] video: fbdev: matrox: convert to i2c_new_scanned_device
Message-Id: <20191107083354.GK23790@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191106095033.25182-1-wsa+renesas@sang-engineering.com>
 <20191106095033.25182-6-wsa+renesas@sang-engineering.com>
In-Reply-To: <20191106095033.25182-6-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Wed, Nov 06, 2019 at 10:50:23AM +0100, Wolfram Sang wrote:
> Move from the deprecated i2c_new_probed_device() to the new
> i2c_new_scanned_device(). Make use of the new ERRPTR if suitable.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Ack for merging through whatever tree you think this should best land
through.
-Daniel

> ---
> 
> Build tested only. RFC, please comment and/or ack, but don't apply yet.
> 
>  drivers/video/fbdev/matrox/i2c-matroxfb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/matrox/i2c-matroxfb.c b/drivers/video/fbdev/matrox/i2c-matroxfb.c
> index 34e2659c3189..e2e4705e3fe0 100644
> --- a/drivers/video/fbdev/matrox/i2c-matroxfb.c
> +++ b/drivers/video/fbdev/matrox/i2c-matroxfb.c
> @@ -191,8 +191,8 @@ static void* i2c_matroxfb_probe(struct matrox_fb_info* minfo) {
>  				0x1b, I2C_CLIENT_END
>  			};
>  
> -			i2c_new_probed_device(&m2info->maven.adapter,
> -					      &maven_info, addr_list, NULL);
> +			i2c_new_scanned_device(&m2info->maven.adapter,
> +					       &maven_info, addr_list, NULL);
>  		}
>  	}
>  	return m2info;
> -- 
> 2.20.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
