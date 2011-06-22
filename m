From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
Date: Wed, 22 Jun 2011 10:39:49 +0000
Subject: RE: [PATCH] fsl-diu-fb: remove the ioctl interface
Message-Id: <929D3CED81F34E43887A393170D66FB90484A280@GBRSUN01MS002.eu.xerox.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308691655-3416-1-git-send-email-timur@freescale.com>
	<20110622003853.1041385c@wker>
In-Reply-To: <20110622003853.1041385c@wker>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anatolij Gustschin <agust@denx.de>, Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-fbdev@vger.kernel.org, lethal@linux-sh.org, yorksun@freescale.com

> > The ioctl interface in the Freescale DIU framebuffer driver is just
a
> > collection of miscellaneous functions which were only used in a
one-time
> > demo application that was never distributed.  Plus, the ioctls were
spread
> > across two types (both conflicting), and the demo app didn't even
use all
> > of them.
> > 
> > Removing the ioctl interface also allows us to clean up the header
file and
> > remove other unusued stuff.
> 
> No! We are using ioctl interface of this driver in many video
> rendering applications on overlay planes on huge number of boards.
> So, please don't remove it.
> 
> Anatolij

Can you make available your application code by posting a link to it?

Thanks,
Clive
