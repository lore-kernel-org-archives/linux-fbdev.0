From: "Kendall Bennett" <KendallB@scitechsoft.com>
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Date: Fri, 15 Oct 2004 11:36:04 -0700
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <416FB624.17156.1D23C23@localhost>
References: <416E6ADC.3007.294DF20D@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268295AbUJOShL@vger.kernel.org>
In-reply-to: <200410150827.38943.adaplas@hotpop.com>
Content-description: Mail message body
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: "Antonino A. Daplas" <adaplas@hotpop.com>, linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net, penguinppc-team@lists.penguinppc.org

"Antonino A. Daplas" <adaplas@hotpop.com> wrote:

> On Friday 15 October 2004 03:02, Kendall Bennett wrote:
> > So what we would like to find out is how much interest there might be in
> > both an updated VESA framebuffer console driver as well as the code for
> > the Video card BOOT process being contributed to the maintstream kernel.
> > If there is interest, we would start out by first contributing the core
> > emulator and Video BOOT code, and then work on building a better VESA
> > framebuffer console driver.
> >
> > So what do you guys think?
> 
> I'm for it, if you can get the code in the kernel.  If not, what
> are the arguments against doing this in userspace? 

At least for the 2.4 kernels it is not possible to run code from user 
space early enough in the boot sequence to bring up the video card when 
the framebuffer console driver starts. Alan Cox said there is work under 
way for 2.6 that might allow this, but it would have to be done very 
early in the boot sequence.

Remember this project is for non-x86 platforms such as PowerPC and MIPS 
embedded machines where there is no way to set a graphics mode using the 
BIOS before the kernel starts loading (well, you can do something using U-
Boot but a lot of projects don't always use U-Boot).

> If you remember about 2 years ago, there was a thread which you
> started about vesafbd.  From that, I've worked on vm86d which is a
> generic approach to running BIOS code in user space. I stopped
> development on this though, but it should be easy to revive. 

Yes, I am aware of this project. It is a great project for x86 platforms, 
but falls short for non-x86 due to the inability to set a basic display 
mode prior to user space access becoming available.

> There is also vesafb-tng. I think it runs BIOS code in kernel
> space. 

I am not familiar with that. Can you point me to a URL?

> The video BOOT code is also nice, especially for non-primary
> graphics cards. 

Yep.

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~
