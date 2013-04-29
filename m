From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 29 Apr 2013 22:23:31 +0000
Subject: Re: [PATCH V2] video: implement a simple framebuffer driver
Message-Id: <2040099.REU8D4ds1g@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1365043183-28905-1-git-send-email-swarren@wwwdotorg.org>
 <6607610.omg016OAvj@avalon> <201304300004.20320.arnd@arndb.de>
In-Reply-To: <201304300004.20320.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Arnd,

On Tuesday 30 April 2013 00:04:20 Arnd Bergmann wrote:
> On Monday 29 April 2013, Laurent Pinchart wrote:
> > On Monday 29 April 2013 23:31:30 Tomasz Figa wrote:
> > > Good point. Stephen, would it be a problem to make this a KMS driver
> > > instead? Old fbdev API could be emulated on top of it, until it goes out
> > > of use, couldn't it?
> > 
> > There's already an fbdev emulation layer in KMS, for such a simple use
> > case it will work fine.
> 
> I suggested the same to Stephen when he first brought up this driver.
> Unfortunately his attempt to create a simple KMS driver resulted in a
> significantly larger driver than the one he did for the framebuffer
> interface. This means that either Stephen did something really wrong in his
> attempt, or the KMS interface isn't as good as it should be if we want to
> move people away from frame buffer drivers.

Implementing a KMS driver requires a fair amount of code. The DRM/KMS 
subsystem provides helpers that significantly reduce the driver size. Those 
helpers have been designed around common use cases found in existing KMS 
drivers.

I'm pretty sure we will be able to add useful helpers for existing fbdev 
drivers that will make porting them to KMS pretty easy, but that first 
requires starting to port drivers to find out what common code could be 
factored out.

-- 
Regards,

Laurent Pinchart

