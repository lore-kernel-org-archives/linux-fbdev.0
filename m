From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Date: 15 Oct 2004 14:05:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <87d5zkqj8h.fsf@bytesex.org>
References: <416E6ADC.3007.294DF20D@localhost>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267700AbUJOMU0@vger.kernel.org>
In-Reply-To: <416E6ADC.3007.294DF20D@localhost>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, penguinppc-team@lists.penguinppc.org

"Kendall Bennett" <KendallB@scitechsoft.com> writes:

> Note that the SNAPBoot code uses the x86emu BIOS emulator project as the 
> core CPU emulation technology, and project we have been actively involved 
> with for many years since the licensing on the project was changed to 
> MIT/BSD style licensing and incorporated into the XFree86 project.

> So what we would like to find out is how much interest there might be in 
> both an updated VESA framebuffer console driver as well as the code for 
> the Video card BOOT process being contributed to the maintstream kernel. 

It certainly would be nice to have that.  Not nessesarely in the
kernel through, people tend not to like such complex stuff like cpu
emulation in the kernel for good reasons.  The kernel can run
userspace apps (modprobe, hotplug), that mechanism could be used to
invoke a userspace tool which does the boot / mode switching.  Having
it in userspace likely also makes it easier to share code with X11.

Have you talked to the powermanagement guys btw.?  One of the major
issues with suspend-to-ram is to get the graphics card back online,
and SNAPBoot might help to fix this too.  I'm not sure a userspace
solution would work for *that* through.

  Gerd

-- 
return -ENOSIG;
