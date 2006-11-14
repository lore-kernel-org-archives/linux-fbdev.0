From: "Miguel Ojeda" <maxextreme@gmail.com>
Subject: Re: ACPI output/lcd/auxdisplay mess
Date: Tue, 14 Nov 2006 23:26:17 +0100
Message-ID: <653402b90611141426y6db15a3bh8ea59f89c8f1bb39@mail.gmail.com>
References: <Pine.LNX.4.64.0611141939050.6957@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933457AbWKNW0U@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0611141939050.6957@pentafluge.infradead.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Luming Yu <Luming.yu@intel.com>, Andrew Zabolotny <zap@homelink.ru>, Jamey Hicks <jamey.hicks@hp.com>

On 11/14/06, James Simmons <jsimmons@infradead.org> wrote:
>
> I have noticed a bunch of patches coming in dealing with the same problem. How to handle displays
> i.e LCD, CRT etc. We have a lcd class in video/backlight which no one is using. Because no one was
> aware of it auxdisplay was created instead. Then we have the acpi code which wants a output class

Well, we were aware of video/backlight/* (read below). Anyway,
auxdisplay doesn't create a class; it did in first versions, but right
now it behaves just like a framebuffer, no classes in the playground
(maybe you read a old version?).

> to handle powering down the display device. Plus the acpi layer does something very similar to the
> framebuffer with getting edids and data relating to the display device. We really should place all
> this handling in one standard place. To do this I need to know what all of you require.
>

auxdisplay was discussed and created because lcd/backlight mean a primary LCD:

"Backlight & LCD device support"
	  Enable this to be able to choose the drivers for controlling the
	  backlight and the LCD panel on some platforms, for example on PDAs.

However, auxdisplay means "auxiliary display device drivers", not _the
display_. In such folder we can put every
auxiliar-optional-secundary-rare display (not just LCDs, framebuffers,
...) who has special requirements (like parport wiring, fixed refresh
rate, different properties...). Also, things like "set_contrast",
"max_constrast", "set_power"... didn't seem very appropriate.

There was a long discussion about this stuff and someone pointed out
the existence of video/backlight/*, so, well, we were aware of such
it. I think people prefered drivers/auxdisplay.

As people wish,

       Miguel Ojeda

-- 
Miguel Ojeda
http://maxextreme.googlepages.com/index.htm
