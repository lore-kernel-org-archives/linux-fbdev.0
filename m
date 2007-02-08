From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: 2.6.20: Modular fb and logo crash
Date: Thu, 08 Feb 2007 11:12:49 -0500
Message-ID: <45CB4C01.2060709@tmr.com>
References: <Pine.LNX.4.62.0702071521340.29060@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1423220AbXBHQhY@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0702071521340.29060@pademelon.sonytel.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

Geert Uytterhoeven wrote:
> If you don't have any builtin frame buffer device driver and insmod a frame
> buffer device driver, the logo code will still try to display the logo (which
> is __initdata). This may cause a crash.
> 
> Originally (2.1.x, is it that long ago I used a modular frame buffer device
> driver?), this didn't happen because initmem_freed (which no longer exists) was
> checked. BTW, there's still a comment in drivers/video/console/fbcon.c about
> this.
> 
> Anyone else who's seeing this? Anyone with an idea how to fix this?
> Moving the logo code to userspace is not considered a solution ;-)

I used to see this when loading from a booted system, but not when the 
modules were in initrd. Don't know if that offers you any help or not. 
Clearly you want the fb built-in so you see the penguins, anyway. ;-D

-- 
Bill Davidsen <davidsen@tmr.com>
   "We have more to fear from the bungling of the incompetent than from
the machinations of the wicked."  - from Slashdot
