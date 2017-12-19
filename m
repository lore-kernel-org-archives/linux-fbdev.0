From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 19 Dec 2017 16:16:30 +0000
Subject: Re: [RFC PATCH v2 00/13] Kernel based bootsplash
Message-Id: <20171219161630.GI26573@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
In-Reply-To: <20171213194755.3409-1-mstaudt@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Max Staudt <mstaudt@suse.de>
Cc: linux-fbdev@vger.kernel.org, michal@markovi.net, b.zolnierkie@samsung.com, sndirsch@suse.com, oneukum@suse.com, tiwai@suse.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, philm@manjaro.org, bernhard.rosenkranzer@linaro.org

On Wed, Dec 13, 2017 at 08:47:42PM +0100, Max Staudt wrote:
> Dear fbdev and fbcon developers,
> 
> Thank you very much for your input for the first patch series.
> 
> I've included your feedback into this second roll, and kindly ask for
> your opinion on the new patch series.

Ok I've realized that my assumptions about why you need this aren't
holding up.

So from reading these patches it sounded like you want an in-kernel boot
splash because that would be on the display faster than a userspace one
like plymouth. That's the only reasons I can see for this (if there's
another good justification, please bring it up).

I only know of very embedded setups (tv top boxes, in vehicle
entertainment) where that kind of "time to first image" really matters,
and those systems:
- have a real hw kms driver
- don't have fbcon or fbdev emulation enabled (except for some closed
  source stacks that are a bit slow to adapt to the new world, and we
  don't care about those in gfx).

But from discussions it sounds like you very much want to use this on
servers, which makes 0 sense to me. On a server something like plymouth
should do a perfectly reasonable job.

So, why exactly do we need this?

(let's stop the other thread meanwhile, there's no point discussing
implementation details if the why? question isn't answered yet)

Cheers, Daniel

> 
> 
> Changes from v1 to v2:
> 
>  + Added a user space tool to create splash theme files
>  + Bumped the file format version:
>     - Larger structs for easy future expansion
>     - 2-byte corner offset
>     - Offset either from corner or from center
>     - Fixed padding before header->frame_ms
>  + Moved bootsplash_file.h to uapi/linux
>  + Merged several patches
>  + Theme files are now loaded via request_firmware()
>  + sysfs hook to allow loading of theme files via request_firmware()
>  + Dropped the .enable cmdline option and the default file name.
>    The splash will be shown as soon as a file is specified.
>  + Dropped custom workqueue in favor of the kernel queue
>    and cancel_delayed_work_sync()
>  + Marked loaded data as const, and load/enable it atomically
>  + Reduced global state by moving data into other structures
>  + EXPORT_SYMBOL_GPL for fbcon_set_dummyops()
>  + Atomic and barrier for splash enabled state instead of spinlock
>  + Reduced warnings to infos
>  + Rate limited printk
>  + Changed the multi-line comment layout to kernel style
>  + Simplified the file headers
>  + reST-ed the documentation
> 
> 
> 
> Max
> 
> 
> 
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
