From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 29 Apr 2013 22:04:20 +0000
Subject: Re: [PATCH V2] video: implement a simple framebuffer driver
Message-Id: <201304300004.20320.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1365043183-28905-1-git-send-email-swarren@wwwdotorg.org>
 <1556968.7tR6KuEIWb@flatron> <6607610.omg016OAvj@avalon>
In-Reply-To: <6607610.omg016OAvj@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Monday 29 April 2013, Laurent Pinchart wrote:
> On Monday 29 April 2013 23:31:30 Tomasz Figa wrote:
>
> > Good point. Stephen, would it be a problem to make this a KMS driver
> > instead? Old fbdev API could be emulated on top of it, until it goes out
> > of use, couldn't it?
> 
> There's already an fbdev emulation layer in KMS, for such a simple use case it 
> will work fine.

I suggested the same to Stephen when he first brought up this driver.
Unfortunately his attempt to create a simple KMS driver resulted in a
significantly larger driver than the one he did for the framebuffer
interface. This means that either Stephen did something really wrong
in his attempt, or the KMS interface isn't as good as it should be
if we want to move people away from frame buffer drivers.

	Arnd
