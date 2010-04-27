From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] added S6E63M0 AMOLED LCD Panel driver.
Date: Tue, 27 Apr 2010 12:05:16 -0700
Message-ID: <20100427120516.c18b3bbb.akpm@linux-foundation.org>
References: <90b950fc1003252024i5ba8989bg95f0a81e8e5e708e@mail.gmail.com>
	<20100330160257.e5f978a9.akpm@linux-foundation.org>
	<90b950fc1003301941r69dc5ce1ida64b590646049a7@mail.gmail.com>
	<20100330195501.747515e9.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100330195501.747515e9.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: InKi Dae <daeinki@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kyungmin.park@samsung.com

On Tue, 30 Mar 2010 19:55:01 -0400
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 31 Mar 2010 11:41:54 +0900 InKi Dae <daeinki@gmail.com> wrote:
> 
> > Hi Andrew,
> > 
> > all the calls to s6e63m0_panel_send_sequence() would return -EINVAL.
> > by api_async() of driver/spi/spi.c
> 
> No, spi_async() does
> 
> 	master->transfer(spi, message);
> 
> which can return at least EIO, EINPROGRESS, EINVAL or ETIMEDOUT.
> 
> > so I think that those return values aren't changed to other.
> > 
> > and final step is to check only whether the return value is 0 or not.
> > if you still think that this code has minor problem or you want it to
> > be corrected
> > then I will patch this code to be corrected anytime.
> 
> It's a bug.
> 
> Also s6e63m0_power_on() is sloppy.  It again or's together disparate
> errnos.  Then if _anything_ failed it returns hardwired -EIO, but it
> should instead propagate the callee's errno back up to the caller.
> 
> And s6e63m0_power_on() can return -EFAULT in several places, which is
> nonsensical.
> 
> None of this is very critical, just ... sloppy.
> 

ping?
