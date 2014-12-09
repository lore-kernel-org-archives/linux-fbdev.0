From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 09 Dec 2014 08:13:04 +0000
Subject: Re: [PATCH v2 2/2] backlight/lp855x: Add supply regulator to lp855x
Message-Id: <11871302.y60x8yR8Ol@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1417570752-23633-1-git-send-email-seanpaul@chromium.org> <54866695.3050307@ti.com> <000a01d01362$aee684d0$0cb38e70$%han@samsung.com>
In-Reply-To: <000a01d01362$aee684d0$0cb38e70$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: "'Kim, Milo'" <milo.kim-l0cyMroinI0@public.gmane.org>, 'Sean Paul' <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, =?ISO-8859-1?Q?=27St=E9phane?= Marchesin' <marcheu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, 'Aaron Durbin' <adurbin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

On Tuesday 09 December 2014 12:46:15 Jingoo Han wrote:
> On Tuesday, December 09, 2014 12:04 PM, Kim, Milo wrote:
> > 
> > Hi Arnd,
> > 
> > Good to talk to you again. It's been a long time since I met you in
> > Linaro Connect HK few years ago 
> > 
> > On 12/3/2014 11:11 PM, Arnd Bergmann wrote:
> > > While your two patches are both correct (and applied already), I took
> > > a look at the platform_data header and noticed that all users of this
> > > file have been converted to DT a while ago, so it would be nice to clean
> > > it up by integrating the linux/platform_data/lp855x.h header file into the
> > > drivers/video/backlight/lp855x_bl.c itself.
> > 
> > I like this cleanup but need to consider few things.
> > 
> > - Platform which does not support the DT
> > In this case, there is no way to configure options like backlight device
> > control mode. Without the DT, only default options are set.
> > To change the settings, the driver modification is required.
> > I don't want to write project/platform dependency code inside the driver.
> > 
> > - Backward compatibility
> > Some customers have been using this platform data in their board-*.c
> > (but this *.c has not been mainlined yet).
> > My concern is the backward compatibility issue may happen in their projects.
> 
> I understand this situation. In the case of Exynos DisplayPort driver,
> a similar issue happened. At that time, the conclusion was that
> out-of-tree code (not mainlined yet) cannot be considered.

Right. Basically when the only reason to have code in the kernel is
to support someone with an out-of-tree patch set, they can be expected
to add the extra bit to their patch set, it doesn't add any extra burden
to them, and it makes our lives easier.

	Arnd
