From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Date: Sat, 16 Oct 2004 05:51:38 +0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200410160551.40635.adaplas@hotpop.com>
References: <416E6ADC.3007.294DF20D@localhost> <416FB624.17156.1D23C23@localhost>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268496AbUJOVxt@vger.kernel.org>
In-Reply-To: <416FB624.17156.1D23C23@localhost>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Kendall Bennett <KendallB@scitechsoft.com>, linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net, penguinppc-team@lists.penguinppc.org

On Saturday 16 October 2004 02:36, Kendall Bennett wrote:
> "Antonino A. Daplas" <adaplas@hotpop.com> wrote:
> > > So what do you guys think?
> >
> > I'm for it, if you can get the code in the kernel.  If not, what
> > are the arguments against doing this in userspace?
>
> At least for the 2.4 kernels it is not possible to run code from user
> space early enough in the boot sequence to bring up the video card when
> the framebuffer console driver starts. Alan Cox said there is work under
> way for 2.6 that might allow this, but it would have to be done very
> early in the boot sequence.
>

For 2.6,  the framebuffer console can activate as early or as late as one
wants because fbcon will wait until a framebuffer driver becomes active. In
contrast, in 2.4, at least one fb driver needs to be active for the
framebuffer console to become active.
 
> Remember this project is for non-x86 platforms such as PowerPC and MIPS
> embedded machines where there is no way to set a graphics mode using the
> BIOS before the kernel starts loading (well, you can do something using U-
> Boot but a lot of projects don't always use U-Boot).
>
> > If you remember about 2 years ago, there was a thread which you
> > started about vesafbd.  From that, I've worked on vm86d which is a
> > generic approach to running BIOS code in user space. I stopped
> > development on this though, but it should be easy to revive.
>
> Yes, I am aware of this project. It is a great project for x86 platforms,
> but falls short for non-x86 due to the inability to set a basic display
> mode prior to user space access becoming available.
>

Yes, that is the downside to a userspace solution. How bad will that be?
Note that Jon Smirl is proposing a temporary console driver for early
boot messages until the primary console driver activates. 

> > There is also vesafb-tng. I think it runs BIOS code in kernel
> > space.
>
> I am not familiar with that. Can you point me to a URL?
>

http://dev.gentoo.org/~spock/projects/vesafb-tng/

Tony
