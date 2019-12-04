From: Jani Nikula <jani.nikula@intel.com>
Date: Wed, 04 Dec 2019 06:31:06 +0000
Subject: Re: [Intel-gfx] [PATCH v3 04/12] video: fbdev: uvesafb: modify the static fb_ops directly
Message-Id: <87muc8haad.fsf@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575390740.git.jani.nikula@intel.com>
 <af63cda5de9fee3acd28e7d264f920338298bc0a.1575390740.git.jani.nikula@intel.com>
 <20191203170351.GH624164@phenom.ffwll.local>
In-Reply-To: <20191203170351.GH624164@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org

On Tue, 03 Dec 2019, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Tue, Dec 03, 2019 at 06:38:46PM +0200, Jani Nikula wrote:
>> Avoid modifying the fb_ops via info->fbops to let us make the pointer
>> const in the future.
>> 
>> Cc: linux-fbdev@vger.kernel.org
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>> ---
>>  drivers/video/fbdev/uvesafb.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
>> index 439565cae7ab..53d08d1b56f5 100644
>> --- a/drivers/video/fbdev/uvesafb.c
>> +++ b/drivers/video/fbdev/uvesafb.c
>> @@ -1440,7 +1440,7 @@ static void uvesafb_init_info(struct fb_info *info, struct vbe_mode_ib *mode)
>>  
>>  	/* Disable blanking if the user requested so. */
>>  	if (!blank)
>> -		info->fbops->fb_blank = NULL;
>> +		uvesafb_ops.fb_blank = NULL;
>>  
>>  	/*
>>  	 * Find out how much IO memory is required for the mode with
>> @@ -1510,7 +1510,7 @@ static void uvesafb_init_info(struct fb_info *info, struct vbe_mode_ib *mode)
>>  			(par->ypan ? FBINFO_HWACCEL_YPAN : 0);
>>  
>>  	if (!par->ypan)
>> -		info->fbops->fb_pan_display = NULL;
>> +		uvesafb_ops.fb_pan_display = NULL;
>>  }
>
> I read code.
>
> I cried.
>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> Also, with more reading and more bad dreams I'll get about this, I'm
> revising my take on patches 1&2 in this series. On those also
>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> as-is.

Thanks. I feel you.

And remember, all I ever wanted to do was

-static struct fb_ops intelfb_ops = {
+static const struct fb_ops intelfb_ops = {

in drivers/gpu/drm/i915/display/intel_fbdev.c.


BR,
Jani.


>
> Cheers, Daniel
>>  
>>  static void uvesafb_init_mtrr(struct fb_info *info)
>> -- 
>> 2.20.1
>> 
>> _______________________________________________
>> Intel-gfx mailing list
>> Intel-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Jani Nikula, Intel Open Source Graphics Center
