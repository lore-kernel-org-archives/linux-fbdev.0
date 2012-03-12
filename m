From: Joe Perches <joe@perches.com>
Date: Mon, 12 Mar 2012 23:07:56 +0000
Subject: Re: [PATCH] Added backlight driver for Acer Aspire 4736
Message-Id: <1331593676.13200.37.camel@joe2Laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331608337.2267.67.camel@debian.Gayathri>
In-Reply-To: <1331608337.2267.67.camel@debian.Gayathri>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pradeep Subrahmanion <subrahmanion.pradeep@gmail.com>
Cc: rpurdie@rpsys.net, FlorianSchandinat@gmx.de, akpm@linux-foundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2012-03-12 at 23:12 -0400, Pradeep Subrahmanion wrote:
> Hi ,

Hello yourself.

Just some trivial comments:

> diff --git a/drivers/video/backlight/acer4736_bl.c b/drivers/video/backlight/acer4736_bl.c
[]
Please add
#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
before any include

> +static int update_brightness(struct backlight_device *bd)
> +{
> +	u8 intensity = bd->props.brightness;
> +	if (intensity > max_brightness) {
> +		printk(KERN_INFO "Acer4736_bl: Invalid parameter. Maximum value is %d"
> +		, max_brightness);

Beginning a line with a comma is not at all common and
should be avoided.  printks need newline terminations,
and this would be better as pr_info.  Maybe:

		pr_info("Invalid parameter %u: Maximum allowed value: %u\n",
			intensity, max_brightness);

> +	printk(KERN_INFO "Loading Acer 4736 backlight driver\n");

	pr_info("Loading backlight driver\n");



