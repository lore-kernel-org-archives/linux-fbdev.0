From: Matt Mackall <mpm@selenic.com>
Subject: Re: Radeon framebuffer weirdness in -mm2
Date: Thu, 20 Jan 2005 15:48:44 -0800
Message-ID: <20050120234844.GF12076@waste.org>
References: <20050120232122.GF3867@waste.org> <20050120153921.11d7c4fa.akpm@osdl.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262219AbVATXtN@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050120153921.11d7c4fa.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ajoshi@shell.unixbox.com, linux-fbdev-devel@lists.sourceforge.net, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Thu, Jan 20, 2005 at 03:39:21PM -0800, Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> > I'm seeing radeonfb on my ThinkPad T30 go weird on reboot (lots of
> > horizontal lines) and require powercycling to fix. Worked fine with 2.6.10.
> 
> Which radeon driver? CONFIG_FB_RADEON_OLD or CONFIG_FB_RADEON?

FB_RADEON.

> (cc Ben, who is the likely cuprit ;)

Btw, ajoshi's address from MAINTAINERS is bouncing.
 
> Which -mm2, btw?  2.6.10-mm2 or 2.6.11-rc1-mm2?

2.6.11-rc1-mm2

> Did you try the corresponding -mm1?

Nothing between that and .10 yet. Building -mm1 now.

-- 
Mathematics is the supreme nostalgia of our time.
