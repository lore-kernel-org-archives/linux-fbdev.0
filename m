From: Rodolfo Giometti <giometti@enneenne.com>
Subject: Re: [PATCH 1/1] PXAFB: Support for backlight control
Date: Thu, 22 Feb 2007 09:32:04 +0100
Message-ID: <20070222083204.GN4641@enneenne.com>
References: <20070221145353.GA23916@enneenne.com> <1056908425.20070221180037@gmail.com> <20070221161210.GL4641@enneenne.com> <1741775233.20070221182608@gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932598AbXBVIbp@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1741775233.20070221182608@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Sokolovsky <pmiscml@gmail.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Richard Purdie <rpurdie@rpsys.net>

On Wed, Feb 21, 2007 at 06:26:08PM +0200, Paul Sokolovsky wrote:
k>   Why? It's the same, except that it already exists, generic one (not
> limited to pxafb), and requires 1 function (too bad that C doesn't
> support lambda's):

Ah, ok.

>   I sent a bit of criticism for that too ;-). YMMV, but kernel
> solutions are just bound to be pretty simple and generic and lack
> any "niceties", which you'd likely want to do anyway eventually. For
> example, what if you'll want to implement "fade out" effect for
> keyboard backlight? Doing it in adhoc manner in kernel? Whereas with
> the LCD classdev, you can write generic "fade out" trigger and
> attach/detach it from userspace.

I agree. I just wish to add a backlight support for my LCD and
minikeypad.

What do you suggest to me in order to accomplish such task?

Thanks for your suggestions,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127
