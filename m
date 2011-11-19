From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Sat, 19 Nov 2011 11:47:14 +0000
Subject: Re: [PATCH] fb: split out framebuffer initialization from
Message-Id: <20111119124714.2e98b9b3@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321308088-6327-1-git-send-email-timur@freescale.com>
In-Reply-To: <1321308088-6327-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Florian, Timur,

On Sat, 19 November 2011 Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:
> On 11/17/2011 08:19 PM, Timur Tabi wrote:
> > Timur Tabi wrote:
> >> Introduce functions framebuffer_init() and framebuffer_cleanup() to allow
> >> the initialization of a user-allocated fb_info object.
> >>
> >> framebuffer_alloc() allows for appending a private data structure when it
> >> allocates the fb_info object.  However, a driver that registers multiple
> >> framebuffers for one device may also need another private data structure
> >> for the device itself.  framebuffer_init() allows such drivers to store
> >> the fb_info objects in the device-specific private data structure,
> >> thereby simplifying memory allocation.
> >>
> >> Signed-off-by: Timur Tabi <timur@freescale.com>
> > 
> > Florian,
> > 
> > Any comments on this patch?  If you're okay with the change, I want to take
> > advantage of it in my framebuffer driver.
> 
> Of course you want, otherwise I'd be wondering why you are sending this patch
> at all.
> 
> But I don't see any advantages of your approach. Instead of pointers to fb_info
> with this patch you could embed fb_info directly in your data structure but that
> is barely a difference for a programmer I'd think. You'd still have to call your
> new functions on init/exit so the amount of function calls needed is the same
> with or without the patch (I could see an advantage if alloc and release were
> pure memory allocations). Or is this all about handling the case when fb_alloc
> fails?
> Historically some drivers don't even call alloc but have their own fb_info and
> call only register. I do not want to add yet another way of doing framebuffer
> initialization unless you can clearly show its benefits.

Wouldn't it even make sense to move some more of the initialization of fb_info
out of fb registration into this new init funtion? (I'm thinking about initializing
mutexes and the like)

This way fb_info could be used before being registered. Registration would then
be reduced to makeing the framebuffer visible to userspace and listed in
registered_fb[].

This way framebuffer_alloc() would be no more that kzalloc(), framebuffer_init()
would setup all "non-zero" fields of fb_info (including setup of all mutexes, one
of which is currently being done by framebuffer_alloc() and the rest by
do_register_framebuffer()!).

Bruno

> Best regards,
> 
> Florian Tobias Schandinat
