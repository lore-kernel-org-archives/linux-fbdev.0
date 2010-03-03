From: Pavel Machek <pavel@ucw.cz>
Date: Wed, 03 Mar 2010 06:04:11 +0000
Subject: Re: [PATCH 1/3] picolcd: driver for PicoLCD HID device
Message-Id: <20100303060411.GA1324@ucw.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100221002001.0a7e05a7@neptune.home> <20100224170049.0d04af3c@neptune.home>
In-Reply-To: <20100224170049.0d04af3c@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bruno Pr?mont <bonbons@linux-vserver.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>

Hi!

> +#ifdef CONFIG_LOGO
> +/*
> + * This is a default logo to be loaded upon driver initialization
> + * replacing the default PicoLCD image loaded on device
> + * initialization. This is to provide the user a cue that the
> + * Linux driver is loaded and ready.
> + *
> + * This logo contains the text PicoLCD in the center with one penguin
> + * on each side of the text. The penguins are a 64x64 rendition of
> + * the default framebuffer 80x80 monochrome image scaled down and
> + * cleaned up to retain something that looks a little better than
> + * a simple scaling.
> + *
> + * This logo is a simple xbm image created in GIMP and exported.
> + * To view the image copy the following two #defines plus the
> + * picolcd_bits to an ASCII text file and save with extension
> + * .xbm, then open with GIMP or any other graphical editor
> + * such as eog that recognizes the .xbm format.
> + */
> +#define picolcd_width 256
> +#define picolcd_height 64
> +static const u8 picolcd_bits[PICOLCDFB_SIZE] = {
> +	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +	0xff, 0xff, 0xff, 0xf8, 0x1f, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xf8, 0x1f, 0xff, 0xff, 0xff,

Please remove this. There are less ugly/shorter ways to tell the user
device is ready.
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
