From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 19 Nov 2012 15:43:51 +0000
Subject: Re: [PATCH v3] video: Versatile Express DVI output driver
Message-Id: <201211191543.51923.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1350405036-17997-1-git-send-email-pawel.moll@arm.com>
 <1351612732.6199.4.camel@hornet> <1353333377.3303.7.camel@hornet>
In-Reply-To: <1353333377.3303.7.camel@hornet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Monday 19 November 2012, Pawel Moll wrote:
> I've asked the framebuffer people 3 times about this but got no comment
> whatsoever:
> 
> https://patchwork.kernel.org/patch/1473091/
> https://patchwork.kernel.org/patch/1601781/
> 
> so I assume there is no problem with merging this code ;-) Therefore,
> would you be so kind to pull this single patch? Without it the 3.8
> kernel will not be able to show anything on VE's display...

Hi Pawel,

I have two comments for the patch that need to be fixed:

* vexpress_dvi_fb_select uses the 'fb' argument as an index into
  the registered_fb array, but does not check for overflow against
  FB_MAX. I think you need to use get_fb_info().

* There is no documentation for the newly introduced sysfs interface.

	Arnd
