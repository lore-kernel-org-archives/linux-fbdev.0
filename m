From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Date: Fri, 15 Oct 2004 08:27:38 +0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200410150827.38943.adaplas@hotpop.com>
References: <416E6ADC.3007.294DF20D@localhost>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267324AbUJOAad@vger.kernel.org>
In-Reply-To: <416E6ADC.3007.294DF20D@localhost>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Kendall Bennett <KendallB@scitechsoft.com>, linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net, penguinppc-team@lists.penguinppc.org

On Friday 15 October 2004 03:02, Kendall Bennett wrote:
> So what we would like to find out is how much interest there might be in
> both an updated VESA framebuffer console driver as well as the code for
> the Video card BOOT process being contributed to the maintstream kernel.
> If there is interest, we would start out by first contributing the core
> emulator and Video BOOT code, and then work on building a better VESA
> framebuffer console driver.
>
> So what do you guys think?
>

I'm for it, if you can get the code in the kernel.  If not, what are the 
arguments against doing this in userspace?

If you remember about 2 years ago, there was a thread which you started
about vesafbd.  From that, I've worked on vm86d which is a generic approach
to running BIOS code in user space. I stopped development on this though,
but it should be easy to revive. There is also vesafb-tng. I think it runs
BIOS code in kernel space.

The video BOOT code is also nice, especially for non-primary graphics cards.

Tony
