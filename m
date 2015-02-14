From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sat, 14 Feb 2015 10:20:58 +0000
Subject: Re: [PATCH 2/2]Trivial patch: to solve indentation warnings in amba-clcd.c driver
Message-Id: <20150214100858.GB8946@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150213112125.GA25078@linuxteamdev.amer.dell.com>
 <20150213113515.GW8656@n2100.arm.linux.org.uk>
 <1423828796.2795.7.camel@perches.com>
 <20150213132805.GA1296@linuxteamdev.amer.dell.com>
 <20150213133618.GZ8656@n2100.arm.linux.org.uk>
In-Reply-To: <20150213133618.GZ8656@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Parmeshwr Prasad <parmeshwr_prasad@dell.com>, Joe Perches <joe@perches.com>, "plagnioj@jcrosoft.com" <plagnioj@jcrosoft.com>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, "trivial@kernel.org" <trivial@kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Feb 13, 2015 at 01:36:18PM +0000, Russell King - ARM Linux wrote:
> On Fri, Feb 13, 2015 at 08:28:10AM -0500, Parmeshwr Prasad wrote:
> > 
> > This is second patch in series.
> > In driver in_atomic we should not use to check if code is unning in IRQ.
> > clcdfb_sleep() function is used to give some delay between operation.
> > I have used schedule_timeout() function for same amount of delay.
> 
> Frankly, this patch is a mess.  It seems to contain unrelated changes.
and this patch is corrupted. your commit message is a mess and the maintainer has to edit it by hand before applying.
if i remember correctly you have been told multiple times by many people to fix your commit message.
and try to use git send-email to send your patches.

regards
sudip


> 
> Please always review your own patches before you send them - this will
> allow you to catch such errors before you post them publically.
> 
> The change to clcdfb_sleep() is wrong in any case - you will end up
> calling schedule_timeout() from illegal contexts (eg, when the
> framebuffer gets blanked/unblanked.)
> 
> -- 
