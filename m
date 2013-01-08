From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 08 Jan 2013 00:01:37 +0000
Subject: Re: [PATCH] backlight: check null deference of name when device is registered
Message-Id: <20130107160137.dec5098a.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000b01cdea55$92725aa0$b7570fe0$%han@samsung.com>
In-Reply-To: <000b01cdea55$92725aa0$b7570fe0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'LKML' <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org, 'Richard Purdie' <rpurdie@rpsys.net>, 'Devendra Naga' <devendra.aaru@gmail.com>

On Fri, 04 Jan 2013 17:29:11 +0900
Jingoo Han <jg1.han@samsung.com> wrote:

> NULL deference of name is checked when device is registered.
> If the name is null, it will cause a kernel oops in dev_set_name().
> 
> ...
>
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -292,6 +292,11 @@ struct backlight_device *backlight_device_register(const char *name,
>  	struct backlight_device *new_bd;
>  	int rc;
>  
> +	if (name = NULL) {
> +		pr_err("backlight name is null\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
>  	pr_debug("backlight_device_register: name=%s\n", name);

I don't understand this.

Is there some driver which is calling these functions with name=NULL? 
If so, which one(s)?

If "no" then why don't we declare that "passing name=NULL is a bug" and
leave the code as-is?

