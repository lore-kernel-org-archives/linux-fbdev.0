From: Tomasz Figa <tomasz.figa@gmail.com>
Date: Mon, 29 Apr 2013 21:15:13 +0000
Subject: Re: [PATCH V2] video: implement a simple framebuffer driver
Message-Id: <2863648.BDvrAG5uPk@flatron>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1365043183-28905-1-git-send-email-swarren@wwwdotorg.org>
 <20130408171637.98b5ad1f867bcbda883af68b@linux-foundation.org>
 <2569832.XQDrhUGNaI@avalon>
In-Reply-To: <2569832.XQDrhUGNaI@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Laurent,

On Thursday 11 of April 2013 11:56:31 Laurent Pinchart wrote:
> On Monday 08 April 2013 17:16:37 Andrew Morton wrote:
> > On Wed,  3 Apr 2013 20:39:43 -0600 Stephen Warren wrote:
> > > A simple frame-buffer describes a raw memory region that may be
> > > rendered to, with the assumption that the display hardware has
> > > already been set up to scan out from that buffer.
> > > 
> > > This is useful in cases where a bootloader exists and has set up the
> > > display hardware, but a Linux driver doesn't yet exist for the
> > > display
> > > hardware.
> > > 
> > > ...
> > > 
> > > +config FB_SIMPLE
> > > +	bool "Simple framebuffer support"
> > > +	depends on (FB = y) && OF
> > 
> > It's sad that this simple little thing requires Open Firmware.  Could
> > it be generalised in some way so that the small amount of setup info
> > could be provided by other means (eg, module_param) or does the
> > dependency go deeper than that?
> 
> I second that request. I like the idea of a simple framebuffer driver if
> it helps deprecating fbdev in the long term, but I don't want it to
> offer an excuse not to implement a DRM/KMS driver. In particular adding
> DT bindings would force us to keep supporting the ABI for a (too) long
> time.

Well, there is also at least one legitimate use case for this driver.

I believe there exist embedded devices on which there is no need to 
dynamically control the framebuffer. It needs one time initialization, 
usually in bootloader, and then it is used as is, using constant 
parameters as long as the system is running.

I doubt there is a need for any KMS (or any other control) driver for such 
devices - dumb framebuffer driver would be everything needed in such case.

Best regards,
Tomasz

