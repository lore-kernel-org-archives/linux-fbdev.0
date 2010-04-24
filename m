From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 24 Apr 2010 15:07:48 +0000
Subject: Re: [RFC] Second OLPC Viafb series
Message-Id: <4BD30944.6060302@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272058093-20914-1-git-send-email-corbet@lwn.net>
In-Reply-To: <1272058093-20914-1-git-send-email-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, Deepak Saxena <dsaxena@laptop.org>, linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn

Hi,

Jonathan Corbet schrieb:
> So this is the second series of viafb patches - the stuff that I was really
> working toward since the beginning.  They depend on the previously-posted
> first series.  What's added here is a big refactoring of the driver to
> split its functions apart and the addition of code for GPIO, interrupt,
> DMA, and camera management.

this looks like a step in the right direction. But I have the feeling 
that it needs a lot of work before I'd consider it useful for mainline.

> Florian, I incorporated your indexed port I/O patch, since it was an
> obvious improvement and I was reworking that stuff anyway.

Thanks.
Could you please also take the proc fix (6) in your upstream branch as 
it is clearly a bugfix (and tainting the kernel is also something that 
should be avoided)

> The full series of patches can be pulled from:
> 
> 	git://git.lwn.net/linux-2.6.git viafb-posted

Probably I should use this the next time as this series again did not 
cleanly apply so I just fired patch on it (which worked as it was mostly 
due to a slight difference in our compile fixes).

So I wanted to runtime test it as you said that it might fix the 
I2C/GPIO issue I debugged. I gave up for now after hitting the following 
errors:

drivers/video/via/via-gpio.c:74: error: field 'gpio_chip' has incomplete 
type

so we should either select GPIOLIB or add ifdef's to avoid the dependency?

After that I hit

drivers/video/via/via_i2c.o: In function `init_module':
via_i2c.c:(.text+0x309): multiple definition of `init_module'
drivers/video/via/viafbdev.o:viafbdev.c:(.init.text+0x0): first defined here
drivers/video/via/via_i2c.o: In function `cleanup_module':
via_i2c.c:(.text+0x10): multiple definition of `cleanup_module'
drivers/video/via/viafbdev.o:viafbdev.c:(.exit.text+0x0): first defined here
drivers/video/via/via-gpio.o: In function `init_module':
via-gpio.c:(.text+0x1f6): multiple definition of `init_module'
drivers/video/via/viafbdev.o:viafbdev.c:(.init.text+0x0): first defined here
drivers/video/via/via-gpio.o: In function `cleanup_module':
via-gpio.c:(.text+0x0): multiple definition of `cleanup_module'
drivers/video/via/viafbdev.o:viafbdev.c:(.exit.text+0x0): first defined here

Guess that means you should only have one module init/exit per module. 
So either making via_i2c and via_gpio separate modules or calling these 
functions directly from the init/exit functions.

That's it for now as I'm really supposed to do some other stuff, too.


Thanks,

Florian Tobias Schandinat
