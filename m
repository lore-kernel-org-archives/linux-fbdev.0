From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] Help re Frame Buffer/Console Problems
Date: Tue, 2 Nov 2004 07:46:24 +0800
Message-ID: <200411020746.27871.adaplas@hotpop.com>
References: <Pine.LNX.4.10.10411011719270.2438-100000@mtfhpc.demon.co.uk>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10411011719270.2438-100000@mtfhpc.demon.co.uk>
Content-Disposition: inline
Sender: sparclinux-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>, adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org, geert@linux-m68k.org, sparclinux@vger.kernel.org, ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org, wli@holomorphy.com

On Tuesday 02 November 2004 01:32, Mark Fortescue wrote:
> Hi all,
>
> Thanks for the info Antonino. I see you spotted my typing error. Yes it is
> the 2.6.10-rc1-bk6 kernel. The oter error is the 2.2.8.1. It should be
> 2.6.8.1.
>
> The cgthree driver does not currently set up the all->info.var.red,
> all->info.var.green or all->info.var.blue structures. Putting a value of 8
> in the length field of these structures (correct for the cgthree) does get
> me my logo back but I am still getting black on black text. It makes it
> very difficult to read. It is begining to look like there is something
> werid going on with the colour pallet stuf for PSEUDO_COLOUR.
>

I doubt that the problem is at the driver layer since you were able to
see the logo. It's probably higher up.

Try this mod, hardwire the foreground color to 0x07.

Edit drivers/video/console/bitblit.c:bit_putcs() and change this line:

image.fg_color = fg;
image.bg_color = bg;

to

image.fg_color = 0x07070707;
image.bg_color = 0x0;

You can also try the reverse:

image.fg_color = 0x0;
image.bg_color = 0x07070707

If you get visible text, the problem is either in fbcon.c or vt.c.

Tony


