From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Wed, 01 Jun 2011 20:02:59 +0000
Subject: Re: Mirror "module" for framebuffer
Message-Id: <20110601220259.7e838306@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4DE67493.6090708@daccii.it>
In-Reply-To: <4DE67493.6090708@daccii.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

[re-adding linux-fbdev, please make sure to reply-to-all]

On Wed, 01 June 2011 Daniele Salvatore Albano <info@daccii.it> wrote:
>  From what i understand, technically i should hook registered 
> framebuffer and change the callback (info->fbdefio->deferred_io), 
> restoring it on module unloading to avoid the caos.
>
> In this way i could "catch" updates passed to the pagelist argument of 
> the deferred io callback, add them to an own list, and call the original 
> callback to let the driver to do the own work.

Note that some framebuffer drivers might implement (lots) of private
ioctls to implement (accelerated) drawing primitives.
So unless you know the driver you are hooking onto all bets are open.

> This is in the kernel from 2.6.20, so it should be on phone kernel.
> 
> I've a couple more questions:
> - i need to access the structure containing the list of registered 
> framebuffer device (struct fb_info *registered_fb[FB_MAX]), i've seen 
> that there is an export symbol on registered_fb so can i access that 
> directly/num_registered_fb?

You can access it (as does fbcon) though that direct access may/will
go away in the future as (since 2.6.39) now that array is protected
by a mutex on fb core side (fbcon being indirectly fine through its
synchronization via notification events, except when loading fbcon
module)
If you do access the list, write an function to do just that
so there is no big rewrite needed to move your driver forward.

> - i need to know when a framebuffer is registered, i've seen that there 
> is fb_register_client ... from what i see it seems that callback are 
> called on every event so from the callback itself i should check for 
> FB_EVENT_FB_REGISTERED, is this right?

If you want to know when framebuffers get (un)registered (or get
reconfigured) this is the way to go.

> - (stupid question) do all fb modules implement deferred input/output?

No, only a few selected ones implement deferred input/output, usually
because the real framebuffer cannot be mapped into memory or the link
to it is just dead slow so changes are pushed down to device at regular
intervals.


I'm wondering if you not better had to create a new framebuffer driver
(based on virtual framebuffer) with fbdefio to push the changes to a
backing framebuffer [the way fbcon draws console] (as well as whatever you
use to stream to the remote system).
This will make you lose any potential hardware acceleration but keep
things simple.
Though you would need ability to move software to your new framebuffer.

Bruno
