From: Joe Perches <joe@perches.com>
Date: Sun, 08 Jul 2012 22:13:48 +0000
Subject: Re: [PATCH v2 05/11] fblog: register one fblog object per framebuffer
Message-Id: <1341785628.13174.28.camel@joe2Laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1341784614-2797-1-git-send-email-dh.herrmann@googlemail.com>
	 <1341784614-2797-6-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1341784614-2797-6-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, florianschandinat@gmx.de, linux-fbdev@vger.kernel.org, gregkh@linuxfoundation.org, alan@lxorguk.ukuu.org.uk, bonbons@linux-vserver.org

On Sun, 2012-07-08 at 23:56 +0200, David Herrmann wrote:
>

Hi David.  Trivial comments only:

> diff --git a/drivers/video/console/fblog.c b/drivers/video/console/fblog.c
[]
> @@ -23,15 +23,204 @@
>   * all fblog instances before running other graphics applications.
>   */

Please add
#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
before any #include and...

>  static int __init fblog_init(void)
>  {
> +	int ret;
> +
> +	ret = fb_register_client(&fblog_notifier);
> +	if (ret) {
> +		pr_err("fblog: cannot register framebuffer notifier");

Missing newline, pr_fmt would add module name.

		pr_err("cannot register framebuffer notifier\n");



