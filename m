From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: RFC: disallow modular framebuffers
Date: Mon, 28 Feb 2005 22:46:37 -0500
Message-ID: <4223E59D.3060902@pobox.com>
References: <20050301024118.GF4021@stusta.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050301024118.GF4021@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Adrian Bunk <bunk@stusta.de>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> Hi,
> 
> while looking how to fix modular FB_SAVAGE_* (both FB_SAVAGE_I2C=m and 
> FB_SAVAGE_ACCEL=m are currently broken) I asked myself:
> 
> Do modular framebuffers really make sense?
> 
> OK, distributions like to make everything modular, but all the 
> framebuffer drivers I've looked at parse driver specific options in 
> their *_setup function only in the non-modular case.
> 
> And most framebuffer drivers contain a module_exit function.
> Is there really any case where this is both reasonable and working?


It depends on the driver's level of hardware support, and the likely 
configuration of the hardware at boot time.

It is a case-by-case basis.

	Jeff
