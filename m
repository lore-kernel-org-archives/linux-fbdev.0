From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Sat, 16 Jun 2012 22:33:34 +0000
Subject: Re: [PATCH 05/10] fblog: add framebuffer helpers
Message-Id: <20120617003334.765f6226@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1339884266-9201-1-git-send-email-dh.herrmann@googlemail.com>
	<1339884266-9201-6-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1339884266-9201-6-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-serial@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Sun, 17 June 2012 David Herrmann <dh.herrmann@googlemail.com> wrote:
> These helpers scan the system for all available framebuffers and register
> or unregister them. This is needed during startup and stopping fblog so we
> are aware of all connected displays.
> 
> The third helper handles mode changes by rescanning the mode and adjusting
> the buffer size.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
>  drivers/video/console/fblog.c |   29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/video/console/fblog.c b/drivers/video/console/fblog.c
> index e790971..7d4032e 100644
> --- a/drivers/video/console/fblog.c
> +++ b/drivers/video/console/fblog.c
> @@ -399,6 +399,35 @@ static void fblog_unregister(struct fblog_fb *fb)
>  	kfree(fb);
>  }
>  
> +static void fblog_register_all(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < FB_MAX; ++i)
> +		fblog_register(registered_fb[i]);

You should take registration_lock mutex for accessing registered_fb[],
even better would be to make use of get_fb_info() and put_fb_info()

> +}
> +
> +static void fblog_unregister_all(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < FB_MAX; ++i)
> +		fblog_unregister(fblog_info2fb(registered_fb[i]));

Same here.

Though for unregistering I'm wondering why you still scan through
registered_fb[], you should just scan your fblog_fbs[] array!

But here again, make sure to have proper locking to not get races with
registration of new framebuffers or removal of existing ones via
notifications.

> +}
> +
> +static void fblog_refresh(struct fblog_fb *fb)
> +{
> +	unsigned int width, height;
> +
> +	if (!fb || !fb->font)
> +		return;
> +
> +	width = fb->info->var.xres / fb->font->width;
> +	height = fb->info->var.yres / fb->font->height;
> +	fblog_buf_resize(&fb->buf, width, height);
> +	fblog_redraw(fb);
> +}
> +

All these new functions are still unused, for easier following of your
patch series it would be nice to have them connected when they are
introduced as otherwise on has to search all following patches for
finding possible users.

>  static int __init fblog_init(void)
>  {
>  	return 0;

Bruno
