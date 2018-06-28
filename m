From: Hans de Goede <j.w.r.degoede@gmail.com>
Date: Thu, 28 Jun 2018 18:50:05 +0000
Subject: Re: [PATCH] fbcon: introduce for_each_registered_fb() helper
Message-Id: <0a591ed5-a990-f6d9-add2-8e22209a3fc2@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1530202809-24105-1-git-send-email-ysxie@foxmail.com>
In-Reply-To: <1530202809-24105-1-git-send-email-ysxie@foxmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yisheng Xie <ysxie@foxmail.com>, b.zolnierkie@samsung.com, keescook@chromium.org, david@lechnology.com
Cc: andriy.shevchenko@linux.intel.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

Looks good, but you should probably do a new version based on:

https://github.com/bzolnier/linux/tree/fbdev-for-next

This has one more loop to replace, in the fbcon_output_notifier()
function which was introduced by:
https://github.com/bzolnier/linux/commit/83d83bebf40132e2d55ec58af666713cc76f9764

Regards,

Hans



On 28-06-18 18:20, Yisheng Xie wrote:
> Following pattern is often used:
> 
>   for (i = 0; i < FB_MAX; i++) {
>          if (registered_fb[i]) {
>                  ...
>          }
>   }
> 
> Therefore, as Andy's suggestion, for_each_registered_fb() helper can
> be introduced to make the code easier to read and write by reducing
> indentation level. It also saves few lines of code in each occurrence.
> 
> This patch convert all part here at the same time.
> 
> Signed-off-by: Yisheng Xie <ysxie@foxmail.com>
> ---
>   drivers/video/fbdev/core/fbcon.c | 25 +++++++++----------------
>   drivers/video/fbdev/core/fbmem.c |  4 +---
>   include/linux/fb.h               |  4 ++++
>   3 files changed, 14 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index c910e74..610853d 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2220,8 +2220,8 @@ static int fbcon_switch(struct vc_data *vc)
>   	 *
>   	 * info->currcon = vc->vc_num;
>   	 */
> -	for (i = 0; i < FB_MAX; i++) {
> -		if (registered_fb[i] != NULL && registered_fb[i]->fbcon_par) {
> +	for_each_registered_fb(i) {
> +		if (registered_fb[i]->fbcon_par) {
>   			struct fbcon_ops *o = registered_fb[i]->fbcon_par;
>   
>   			o->currcon = vc->vc_num;
> @@ -3103,11 +3103,9 @@ static int fbcon_fb_unregistered(struct fb_info *info)
>   	if (idx = info_idx) {
>   		info_idx = -1;
>   
> -		for (i = 0; i < FB_MAX; i++) {
> -			if (registered_fb[i] != NULL) {
> -				info_idx = i;
> -				break;
> -			}
> +		for_each_registered_fb(i) {
> +			info_idx = i;
> +			break;
>   		}
>   	}
>   
> @@ -3562,11 +3560,9 @@ static void fbcon_start(void)
>   
>   		console_lock();
>   
> -		for (i = 0; i < FB_MAX; i++) {
> -			if (registered_fb[i] != NULL) {
> -				info_idx = i;
> -				break;
> -			}
> +		for_each_registered_fb(i) {
> +			info_idx = i;
> +			break;
>   		}
>   
>   		do_fbcon_takeover(0);
> @@ -3586,15 +3582,12 @@ static void fbcon_exit(void)
>   	kfree((void *)softback_buf);
>   	softback_buf = 0UL;
>   
> -	for (i = 0; i < FB_MAX; i++) {
> +	for_each_registered_fb(i) {
>   		int pending = 0;
>   
>   		mapped = 0;
>   		info = registered_fb[i];
>   
> -		if (info = NULL)
> -			continue;
> -
>   		if (info->queue.func)
>   			pending = cancel_work_sync(&info->queue);
>   		DPRINTK("fbcon: %s pending work\n", (pending ? "canceled" :
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 609438d..645c6ac 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1593,10 +1593,8 @@ static int do_remove_conflicting_framebuffers(struct apertures_struct *a,
>   	int i, ret;
>   
>   	/* check all firmware fbs and kick off if the base addr overlaps */
> -	for (i = 0 ; i < FB_MAX; i++) {
> +	for_each_registered_fb(i) {
>   		struct apertures_struct *gen_aper;
> -		if (!registered_fb[i])
> -			continue;
>   
>   		if (!(registered_fb[i]->flags & FBINFO_MISC_FIRMWARE))
>   			continue;
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index aa74a22..3e13b95 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -650,6 +650,10 @@ extern int fb_get_color_depth(struct fb_var_screeninfo *var,
>   extern int num_registered_fb;
>   extern struct class *fb_class;
>   
> +#define for_each_registered_fb(i)		\
> +	for (i = 0; i < FB_MAX; i++)		\
> +		if (registered_fb[i])
> +
>   extern int lock_fb_info(struct fb_info *info);
>   
>   static inline void unlock_fb_info(struct fb_info *info)
> 
