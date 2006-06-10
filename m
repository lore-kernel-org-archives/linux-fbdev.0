From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 2/5] VT binding: Add sysfs support
Date: Fri, 9 Jun 2006 21:37:52 -0700
Message-ID: <20060610043752.GA20088@suse.de>
References: <448933D7.6040301@gmail.com> <20060609220803.GB7636@suse.de> <448A147A.3030108@gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030225AbWFJEh7@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <448A147A.3030108@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Sat, Jun 10, 2006 at 08:38:18AM +0800, Antonino A. Daplas wrote:
> Greg KH wrote:
> > On Fri, Jun 09, 2006 at 04:39:51PM +0800, Antonino A. Daplas wrote:
> >> Add sysfs attributes for binding and unbinding VT console drivers. The
> >> attributes are located in /sys/class/tty/console and are namely:
> >>
> >>     A. backend - list registered drivers in the following format:
> >>
> >>     "I C: Description"
> > 
> > No, this violates the "one value per file" issue with sysfs.  How do you
> > know you will not overflow the buffer passed to you?
> 
> I was wondering about this. I just want a way to show what are the currently
> loaded drivers, so it's a read-only attribute.  It's using snprintf (though
> I haven't added a check for possible overflows, should be a 2-liner). Maximum
> number of lines is 16, and there are examples of this rule-breakage in the
> current sysfs tree.
> 
> /sys/class/usb_host/usb_hostx/device/pools

Ah, thanks for pointing this out.  Those files should go to debugfs,
they do NOT belong in sysfs at all.

> Yes, none are valid excuses.  Anyway, what would be the best way? I was
> considering creating another class for vt_console, but that would entail
> the creation of a new device major number just for this.

No, you don't need a major to create a new class in sysfs at all.  Look
at usb_host for an example of that :)

And even if you did, we have loads of free major numbers now, it's not a
big deal to get a new one.

I vote for this, it would make things much easier.

> >>     Where: I  = ID number of the driver
> >>            C  = status of the driver which can be:
> >>
> >> 		S = system driver
> >> 		B = bound modular driver
> >> 		U = unbound modular driver
> >>
> >> 	   Description - text description of the driver
> >>
> >>     B. bind - binds a driver to the console layer
> >>
> >>        echo <ID> > /sys/class/tty/console/bind
> >>
> >>     C. unbind - unbinds a driver from the console layer
> >>
> >>        echo <ID> > /sys/class/tty/console/unbind
> >>
> >> The tty layer does nothing to these attributes except create them and punt all
> >> requests to the VT layer.
> > 
> > Why is this needed?  What is wrong with the current scheme of binding
> > ttys to the console?
> > 
> 
> The binding part, maybe none, but that's still debatable.  It's the unbinding
> feature that people are requesting.  Note the longish threads on "the future
> of graphics subsystem".  It would also ease the life of console driver
> developers, and it would stop people from pestering me on why they cannot unload
> their beloved framebuffer console and drivers and go back to VGA console.

Ok, I also read the 0/5 in this series which describes this in detail,
sorry for not seeing that (hint, cc: everyone on the series that one
too, so they get a bit of detail in the future.)

thanks,

greg k-h
