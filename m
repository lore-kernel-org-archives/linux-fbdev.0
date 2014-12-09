From: "Kim, Milo" <milo.kim@ti.com>
Date: Tue, 09 Dec 2014 03:03:49 +0000
Subject: Re: [PATCH v2 2/2] backlight/lp855x: Add supply regulator to lp855x
Message-Id: <54866695.3050307@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1417570752-23633-1-git-send-email-seanpaul@chromium.org> <1417570752-23633-2-git-send-email-seanpaul@chromium.org> <5204192.bzM5jPIgHv@wuerfel>
In-Reply-To: <5204192.bzM5jPIgHv@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Sean Paul <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, =?windows-1252?Q?St=E9phane_?= =?windows-1252?Q?Marchesin?= <marcheu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Aaron Durbin <adurbin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

Hi Arnd,

Good to talk to you again. It's been a long time since I met you in 
Linaro Connect HK few years ago :)

On 12/3/2014 11:11 PM, Arnd Bergmann wrote:
> While your two patches are both correct (and applied already), I took
> a look at the platform_data header and noticed that all users of this
> file have been converted to DT a while ago, so it would be nice to clean
> it up by integrating the linux/platform_data/lp855x.h header file into the
> drivers/video/backlight/lp855x_bl.c itself.

I like this cleanup but need to consider few things.

- Platform which does not support the DT
In this case, there is no way to configure options like backlight device 
control mode. Without the DT, only default options are set.
To change the settings, the driver modification is required.
I don't want to write project/platform dependency code inside the driver.

- Backward compatibility
Some customers have been using this platform data in their board-*.c 
(but this *.c has not been mainlined yet).
My concern is the backward compatibility issue may happen in their projects.

Best regards,
Milo
