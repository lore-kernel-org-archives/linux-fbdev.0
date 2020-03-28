From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 28 Mar 2020 18:12:59 +0000
Subject: Re: [PATCH] fbcon: fix null-ptr-deref in fbcon_switch
Message-Id: <20200328181259.GA24335@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200328151511.22932-1-hqjagain@gmail.com>
In-Reply-To: <20200328151511.22932-1-hqjagain@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Qiujun Huang <hqjagain@gmail.com>
Cc: daniel.thompson@linaro.org, b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, ghalat@redhat.com

Hi Qiujun

Thanks for looking into the sysbot bugs.

On Sat, Mar 28, 2020 at 11:15:10PM +0800, Qiujun Huang wrote:
> Add check for vc_cons[logo_shown].d, as it can be released by
> vt_ioctl(VT_DISALLOCATE).
> 
> Reported-by: syzbot+732528bae351682f1f27@syzkaller.appspotmail.com
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> ---
>  drivers/video/fbdev/core/fbcon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index bb6ae995c2e5..7ee0f7b55829 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2254,7 +2254,7 @@ static int fbcon_switch(struct vc_data *vc)
>  		fbcon_update_softback(vc);
>  	}
>  
> -	if (logo_shown >= 0) {
> +	if (logo_shown >= 0 && vc_cons_allocated(logo_shown)) {
>  		struct vc_data *conp2 = vc_cons[logo_shown].d;
>  
>  		if (conp2->vc_top = logo_lines
> @@ -2852,7 +2852,7 @@ static void fbcon_scrolldelta(struct vc_data *vc, int lines)
>  			return;
>  		if (vc->vc_mode != KD_TEXT || !lines)
>  			return;
> -		if (logo_shown >= 0) {
> +		if (logo_shown >= 0 && vc_cons_allocated(logo_shown)) {
>  			struct vc_data *conp2 = vc_cons[logo_shown].d;
>  
>  			if (conp2->vc_top = logo_lines

I am not familiar with this code.

But it looks like you try to avoid the sympton
which is that logo_shown has a wrong value after a
vc is deallocated, and do not fix the root cause.

We have:

vt_ioctl(VT_DISALLOCATE)
 |
 +- vc_deallocate()
     |
     +- visual_deinit()
         |
	 +- vc->vc_sw->con_deinit(vc)
	     |
	     +- fbcon_deinit()

Would it be better to update logo_shown
in fbcon_deinit()?
Then we will not try to do anything with
the logo in fbcon_switch().

fbcon_deinit() is called with console locked
so there should not be any races.

I did not stare long enough on the code to come up with a patch,
but this may be a better way to fix it.

	Sam
