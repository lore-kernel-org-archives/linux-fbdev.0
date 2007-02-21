From: Rodolfo Giometti <giometti@enneenne.com>
Subject: Re: [PATCH 1/1] PXAFB: Support for backlight control
Date: Wed, 21 Feb 2007 17:12:10 +0100
Message-ID: <20070221161210.GL4641@enneenne.com>
References: <20070221145353.GA23916@enneenne.com> <1056908425.20070221180037@gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422646AbXBUQLz@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1056908425.20070221180037@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Sokolovsky <pmiscml@gmail.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Richard Purdie <rpurdie@rpsys.net>

On Wed, Feb 21, 2007 at 06:00:37PM +0200, Paul Sokolovsky wrote:
> 
>   On the other hand, there's already
> drivers/video/backlight/backlight.c which provides generic BL support,
> implemented using notifier callback for FB core. Moreover, there's

My patch _uses_ that support.

> corgi_bl.c driver which, contrary to its name is a generic driver for
> embedded/PDA device backlight. It essentially subclassses pretty
> abstract backlight.c, and provides good implementation for most BL
> implementation. What you really need to do to use it, is to supply
> single machine-dependent method, set_bl_intensity(). That method is
> usually <10 lines.

I see, but in this manner you need to make a complete file for each
board, while with my patch you can just put few lines into machine's
definition file (a struct and 2 functions).

>   With this in mind, adhoc backlight handlers in pxafb and few other
> drivers are artifacts of older times. And it's sad they are tried to
> be resurrected instead of being removed.

IMHO, the actual backlight support is not so much, infact I'd like to
generalize it to support also backlighted keyboards (or input
devices). :)

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127
