From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] Help re Frame Buffer/Console Problems
Date: Sat, 30 Oct 2004 08:25:47 +0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200410300825.47096.adaplas@hotpop.com>
References: <Pine.LNX.4.10.10410291849480.2831-100000@mtfhpc.demon.co.uk>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S263769AbUJ3A3C@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10410291849480.2831-100000@mtfhpc.demon.co.uk>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net, Mark Fortescue <mark@mtfhpc.demon.co.uk>, jsimmons@infradead.org, geert@linux-m68k.org
Cc: sparclinux@vger.kernel.org, ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org, wli@holomorphy.com

On Saturday 30 October 2004 02:22, Mark Fortescue wrote:
> Hi all,
>
> I have been trying to get a CG3 sparc clone up and running with linux.
> Under 2.2.26, the console is fine. During the development of the
> 2.5.x/2.6.x frame buffer system the CG3 support got broken. I have managed
> to track done one of the problems (the blanking code had some typing
> errors in it) and this gave me a logo + black screen and cursor using a
> linux-2.2.8.1 kernel. Still no console text.
>
> Given that 2.2.10-rc1-bk6 is available, I have downloaded and applied the
> appropriate patches and made some additional mods to keep the
> compiler/linker happy. Now I have a black console, no text, logo or cursor
> and if I redirect the console output to a serial port I get the following:

I'm assuming 2.6.10-rc1-bk6...

Make sure you correctly fill up the red, green, blue, and transp fields
in all->info.var.  You can do it in sbufsfb_fill_var, or somewhere
within cg3.c before the register_framebuffer() part.

As a reminder, info->var and info->fix must be valid prior to framebuffer
registration.

Tony
