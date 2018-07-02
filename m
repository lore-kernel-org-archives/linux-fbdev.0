From: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Date: Mon, 02 Jul 2018 07:36:02 +0000
Subject: Re: [PATCH] fbcon: introduce for_each_registered_fb() helper
Message-Id: <00590669b886b4cc54548e6101912c3d4d1752f2.camel@petrovitsch.priv.at>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1530202809-24105-1-git-send-email-ysxie@foxmail.com>
In-Reply-To: <1530202809-24105-1-git-send-email-ysxie@foxmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yisheng Xie <ysxie@foxmail.com>, b.zolnierkie@samsung.com, keescook@chromium.org, j.w.r.degoede@gmail.com, david@lechnology.com
Cc: andriy.shevchenko@linux.intel.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi all!

On Fri, 2018-06-29 at 00:20 +0800, Yisheng Xie wrote:
[...]
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index aa74a22..3e13b95 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -650,6 +650,10 @@ extern int fb_get_color_depth(struct
> fb_var_screeninfo *var,
>  extern int num_registered_fb;
>  extern struct class *fb_class;
>  
> +#define for_each_registered_fb(i)		\
> +	for (i = 0; i < FB_MAX; i++)		\
> +		if (registered_fb[i])
> +

That leaves the possibility of a dangling-else.
----  snip  ----
#define for_each_registered_fb(i)		\
	for (i = 0; i < FB_MAX; i++)		\
		if (!registered_fb[i])		\
			continue;		\
		else
----  snip  ----
avoids that.

Kind regards,
	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
                     LUGA : http://www.luga.at
