From: "Kendall Bennett" <KendallB@scitechsoft.com>
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Date: Fri, 15 Oct 2004 11:36:04 -0700
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <416FB624.27698.1D23BA6@localhost>
References: <416E6ADC.3007.294DF20D@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268303AbUJOSjJ@vger.kernel.org>
In-reply-to: <87d5zkqj8h.fsf@bytesex.org>
Content-description: Mail message body
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Gerd Knorr <kraxel@bytesex.org>, linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, penguinppc-team@lists.penguinppc.org

Gerd Knorr <kraxel@bytesex.org> wrote:

> "Kendall Bennett" <KendallB@scitechsoft.com> writes:
> 
> > Note that the SNAPBoot code uses the x86emu BIOS emulator project as the 
> > core CPU emulation technology, and project we have been actively involved 
> > with for many years since the licensing on the project was changed to 
> > MIT/BSD style licensing and incorporated into the XFree86 project.
> 
> > So what we would like to find out is how much interest there might be in 
> > both an updated VESA framebuffer console driver as well as the code for 
> > the Video card BOOT process being contributed to the maintstream kernel. 
> 
> It certainly would be nice to have that.  Not nessesarely in the
> kernel through, people tend not to like such complex stuff like
> cpu emulation in the kernel for good reasons.  

Well think about it as an x86 p-code interpreter then ;-) Kind of like a 
forth interpreter for Open Firmware but we use an x86 image instead.

> The kernel can run userspace apps (modprobe, hotplug), that
> mechanism could be used to invoke a userspace tool which does the
> boot / mode switching. Having it in userspace likely also makes it
> easier to share code with X11. 

I agree entirely, provided we can find a way to get this to run really 
early in the boot sequence. We need this for non-x86 embedded machines 
such as PowerPC and MIPS, not for x86 platforms where the BIOS can be 
called from the boot loader easily.

> Have you talked to the powermanagement guys btw.?  One of the
> major issues with suspend-to-ram is to get the graphics card back
> online, and SNAPBoot might help to fix this too.  I'm not sure a
> userspace solution would work for *that* through. 

That is a good point. Another good reason to have the code in there ;-)

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~
