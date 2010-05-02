From: Jonathan Corbet <corbet@lwn.net>
Date: Sun, 02 May 2010 01:52:51 +0000
Subject: Re: [PATCH 24/30] viafb: Add a driver for the video capture engine
Message-Id: <20100501195251.50093ddb@bike.lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272493051-25380-1-git-send-email-corbet@lwn.net>
	<1272493051-25380-25-git-send-email-corbet@lwn.net>
	<4BDCD2FD.8090104@gmx.de>
In-Reply-To: <4BDCD2FD.8090104@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn

On Sun, 02 May 2010 03:18:53 +0200
Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:

> > +config FB_VIA_CAMERA
> > +	tristate "VIAFB camera controller support"
> > +	depends on FB_VIA
> > +	select VIDEOBUF_DMA_SG
> > +	help
> > +	   Driver support for the integrated camera controller in VIA
> > +	   Chrome9 chipsets.  Currently only tested on OLPC xo-1.5 systems
> > +	   with ov7670 sensors.
> > +  
> 
> Probably this is not the right place for this config option. Even if it 
> currently depends on the framebuffer having it there is just confusing. 

It's the wrong place for the driver as a whole; it needs to move to
drivers/media/video, and the configuration option with it.  As noted,
the camera driver isn't ready for submission yet; that's on a list of
about a half-dozen things that need fixing.  There's just a bit more
stuff to separate to make that move possible.

One other thing to consider is moving via-core, i2c, and gpio to
drivers/mfd.  It's perhaps a more logical place for it, but I'm not
sure there's a lot of value in making that move.

> Additionally you should depend/select some V4L stuff to make the 
> following compile errors go away:

OK.  A half-dozen plus one things to fix.

> Otherwise you can count this patch series as
> Acked-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> Although it is still far away from destination and has its issues but 
> it's a step forward and delaying it would be probably just frustrating 
> for both of us.

Thanks for reviewing it!

There are definitely things to fix, and I expect some of them to last
past the merge window.  But, hopefully, it's progress, and it's very
much my intention to continue to make things better.

jon
