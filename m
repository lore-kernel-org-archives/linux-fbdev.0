From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 26 Feb 2010 08:12:17 +0000
Subject: Re: [PATCH 1/3] picolcd: driver for PicoLCD HID device
Message-Id: <20100226081217.GA17444@core.coreip.homeip.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100221002001.0a7e05a7@neptune.home>
 <20100224170049.0d04af3c@neptune.home>
 <201002241927.53532.oliver@neukum.org>
 <ffb352764fc5a0da5cca6f3da7fc2603.squirrel@intranet.cs.nmsu.edu>
 <alpine.LNX.2.00.1002251157500.30967@pobox.suse.cz>
 <7316226fbd1cb53b7f90965c54acd343.squirrel@intranet.cs.nmsu.edu>
In-Reply-To: <7316226fbd1cb53b7f90965c54acd343.squirrel@intranet.cs.nmsu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rick L. Vinyard, Jr." <rvinyard@cs.nmsu.edu>
Cc: Jiri Kosina <jkosina@suse.cz>, Oliver Neukum <oliver@neukum.org>, Bruno =?iso-8859-1?Q?Pr=C3=A9mont?= <bonbons@linux-vserver.org>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Nicu Pavel <npavel@ituner.com>

On Thu, Feb 25, 2010 at 08:34:42AM -0700, Rick L. Vinyard, Jr. wrote:
> Jiri Kosina wrote:
> > On Wed, 24 Feb 2010, Rick L. Vinyard, Jr. wrote:
> >
> >> The key difference is the replacement of spin_lock() with spin_trylock()
> >> such that if the non-interrupt code has already obtained the lock, the
> >> interrupt will not deadlock but instead take the else path and schedule
> >> a
> >> framebuffer update at the next interval.
> >
> > Why is _irqsave() and/or deferred work not enough? The aproach with
> > _trylock() seems to be overly complicated for no good reason (I personally
> > become very suspicious every time I see code that is using _trylock()).
> >
> 
> I was concerned about _irqsave() because the lock is split across two
> functions to protect the urb after it is handed off to the usb subsystem
> with usb_submit_urb(). It's locked in g13_fb_send() and unlocked in the
> urb completion callback.
> 
> As for deferred work, the g13_fb_send() is the I/O portion of the deferred
> framebuffer callback. I was concerned that without a lock one deferred
> update could hand the urb off to the usb subsystem and a second could try
> to access it before it was handed back to the driver.
> 
> In this case the _trylock() would fail and in the else patch we would
> defer yet again until the next update cycle.
> 

What you are looking for here is called test_and_set_bit(). Do not muddy
the waters with a lock.

-- 
Dmitry
