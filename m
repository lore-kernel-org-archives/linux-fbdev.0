From: "Kendall Bennett" <KendallB@scitechsoft.com>
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Fri, 15 Oct 2004 15:12:25 -0700
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <416FE8D9.18954.2984F7A@localhost>
References: <416FB624.31033.1D23BE5@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261724AbUJOWMv@vger.kernel.org>
In-reply-to: <20041015214451.GA4739@hh.idb.hist.no>
Content-description: Mail message body
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, penguinppc-team@lists.penguinppc.org, linuxconsole-dev@lists.sourceforge.net

Helge Hafting <helgehaf@aitel.hist.no> wrote:

> On Fri, Oct 15, 2004 at 11:36:04AM -0700, Kendall Bennett wrote:
> > Helge Hafting <helgehaf@aitel.hist.no> wrote:
> > 
> [...]
> > > Having video BOOT would be great, and please make it independent of
> > > the framebuffer drivers.  
> > 
> > Right now it is independent but I added a single line of code to the 
> > Radeon driver to init the card prior to initing the rest of the driver. 
> 
> That's fine.  What I meant, was please make it independent of the
> VESA framebuffer driver, because one might want to use an
> acellerated driver when one is available. 

Oh, it already is. The VESA driver is not actually done yet so the only 
drivers using VideoBoot right now are the accelerated ones ;-)

> > It can be done earlier than that inside fbmem.c, but I wasn't sure how to 
> > set up the code so it would only POST each card as it is needed as I 
> > don't want to bring up secondary controllers unless the user actually 
> > wants this.
> 
> Selecting which cards to "boot" can probably be done with a kernel
> parameter?  The default could be to bring up all cards except the
> one the bios brought up already.  Wanting to _not_ bring up some
> cards seems to be the unusual case to me. 

Not really. In many cases there may be a secondary controller on the 
system that is not wanted, such as when the user has an i915G or other 
chipset with integrated video but has plugged a different video card into 
the system. The integrated video can still be active so trying to bring 
it up may be problematic unless it is really wanted.

> > How does the framebuffer console system handle secondary controllers 
> > right now? It seems from my look at the code that it only brings up the 
> > primary and not the secondary?
> 
> The stock 2.6.x fbcon only use one framebuffer console.  I use the
> ruby patch which supports multiple consoles.  The ruby patch for
> 2.6.7 support multiple fbcons so you can have several keyboards
> attached to separate framebuffers thus supporting several users.
> (VT1-VT16 is the first kbd on the first fbcon, VT17-VT32 is the
> second kbd on the second fbcon, and so on.) 
> 
> The ruby patch for 2.6.8.1 is somewhat broken, and doesn't work
> with fbcon. It still support multiple keyboards and multiple
> framebuffers, so I can support several users with separate xservers
> but currently not gettys on separate fbcons. 

Cool. So this stuff is not yet in the official kernel trees. Is that 
going to happen or is the project to move the video out of the kernel 
going to happen first?

> Note that soft-booting the "extra" video card in order to support a
> framebuffer driver is nice even if it doesn't attach to the
> console, because there is other software that can utilize a
> framebuffer.  X is the most well-known of them. 

Yes, but if you don't need a framebuffer console on the card then X or 
whatever can bring up the secondary controller from user space once the 
kernel has booted.

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~
