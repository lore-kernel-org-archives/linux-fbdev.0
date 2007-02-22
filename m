From: Rodolfo Giometti <giometti@enneenne.com>
Subject: Re: [PATCH 1/1] PXAFB: Support for backlight control
Date: Thu, 22 Feb 2007 10:32:38 +0100
Message-ID: <20070222093238.GF13924@enneenne.com>
References: <20070221145353.GA23916@enneenne.com> <1172105946.5790.78.camel@localhost.localdomain> <20070222082848.GM4641@enneenne.com> <1172136430.5837.9.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751524AbXBVJcT@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1172136430.5837.9.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Purdie <rpurdie@rpsys.net>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Paul Sokolovsky <pmiscml@gmail.com>

On Thu, Feb 22, 2007 at 09:27:09AM +0000, Richard Purdie wrote:
> 
> Yes, my point is that you shouldn't need to touch pxafb if you use the
> backlight class. I know pxafb has backlight hooks but they are probably
> going to get removed at some point as they should no longer be needed.

I see.

> What changes do you need to it to be able to use it as a generic driver?
> 
> The main issue is that the structure definition is in one of the
> sharpsl.h files at the moment so most drivers can't get to it. Fix that
> and it should make a good generic driver.

I'll do as you suggest!

> Ideally I'd prefer to leave the name alone since there is broken
> userspace on the Zaurus that uses that name but I can see why people
> want it renamed if its to be used as a generic driver...

Yes. :)

I'll wait for the 2.6.21 to see what to do... thanks a lot,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127
