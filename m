From: "Kendall Bennett" <KendallB@scitechsoft.com>
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Fri, 15 Oct 2004 11:36:04 -0700
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <416FB624.31033.1D23BE5@localhost>
References: <416E6ADC.3007.294DF20D@localhost> (from	KendallB@scitechsoft.com on Thu Oct 14 21:02:36 2004)
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268296AbUJOSjJ@vger.kernel.org>
In-reply-to: <1097848107l.20759l.0l@hh>
Content-description: Mail message body
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, penguinppc-team@lists.penguinppc.org

Helge Hafting <helgehaf@aitel.hist.no> wrote:

> On 14-10-2004 21:02:36, Kendall Bennett wrote:
> > Hello All,
> [...]
> > So what we would like to find out is how much interest there might be
> > in
> > both an updated VESA framebuffer console driver as well as the code
> > for
> > the Video card BOOT process being contributed to the maintstream
> > kernel.
> 
> The BOOT stuff is very interesting.  Currently, both my videocards
> (in the same pc) have nice hw-specific framebuffer drivers, but
> they require that the card is initialized by the bios first and
> this only ever happens to one of the cards.  Xfree _can_ do the
> job, but way too late for setting up the framebuffer device. 

Exactly.

> > If there is interest, we would start out by first contributing the
> > core
> > emulator and Video BOOT code, and then work on building a better VESA
> > framebuffer console driver.
> 
> Having video BOOT would be great, and please make it independent of
> the framebuffer drivers.  

Right now it is independent but I added a single line of code to the 
Radeon driver to init the card prior to initing the rest of the driver. 
It can be done earlier than that inside fbmem.c, but I wasn't sure how to 
set up the code so it would only POST each card as it is needed as I 
don't want to bring up secondary controllers unless the user actually 
wants this.

How does the framebuffer console system handle secondary controllers 
right now? It seems from my look at the code that it only brings up the 
primary and not the secondary?

> I might want to try your vesa driver, but I might also want to use
> the hw-accelerated chip specific driver that happens to need an
> initialized video card. 

Yep, you could use either. In fact you could even use the VGA text 
console driver on PowerPC and MIPS platforms provided the kernel 
correctly sets up the proper VGA resource mappings (which many embedded 
kernels do not do).

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~
