From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] no backlight on radeon after recent kernel
 "upgrade"s
Date: Thu, 22 Feb 2007 01:11:18 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702220109450.17121@pentafluge.infradead.org>
References: <20070219044616.GC25659@washoe.onerussian.com>
 <20070219000412.acad13de.akpm@linux-foundation.org>
 <1171876788.6046.3.camel@localhost.localdomain> <20070221055648.GM25659@washoe.onerussian.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932964AbXBVBL2@vger.kernel.org>
In-Reply-To: <20070221055648.GM25659@washoe.onerussian.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yaroslav Halchenko <lists@onerussian.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


> I built 2.6.20-mm2 without backlight support
> $> grep BACKLIGH /boot/config-2.6.20-mm2 
> # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
> # CONFIG_FB_BACKLIGHT is not set
> # CONFIG_FB_RIVA_BACKLIGHT is not set
> # CONFIG_FB_RADEON_BACKLIGHT is not set
> 
> that "eliminated" the problem. Also I can see the screen with pure
> 2.6.20 with backlight support (whatever it does since after
> loading lcd, backlight modules, my /sys/class/{lcd,backlight} are empty):
> 
> *$> grep BACKLIGH /boot/config-2.6.20 
> # CONFIG_FB_BACKLIGHT is not set
> CONFIG_BACKLIGHT_LCD_SUPPORT=y
> CONFIG_BACKLIGHT_CLASS_DEVICE=m
> CONFIG_BACKLIGHT_DEVICE=y

You need to explictly enable the backlight for your fbdev driver. It 
doesn't do the selecting magically for you.
Jus do a make "favorite"config and go to the fbdev menu and select the 
backlight option for your fbdev driver.
