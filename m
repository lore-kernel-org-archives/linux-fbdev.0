From: Anatolij Gustschin <agust@denx.de>
Date: Tue, 21 Jun 2011 22:38:53 +0000
Subject: Re: [PATCH] fsl-diu-fb: remove the ioctl interface
Message-Id: <20110622003853.1041385c@wker>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308691655-3416-1-git-send-email-timur@freescale.com>
In-Reply-To: <1308691655-3416-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-fbdev@vger.kernel.org, lethal@linux-sh.org, yorksun@freescale.com

On Tue, 21 Jun 2011 16:27:35 -0500
Timur Tabi <timur@freescale.com> wrote:

> The ioctl interface in the Freescale DIU framebuffer driver is just a
> collection of miscellaneous functions which were only used in a one-time
> demo application that was never distributed.  Plus, the ioctls were spread
> across two types (both conflicting), and the demo app didn't even use all
> of them.
> 
> Removing the ioctl interface also allows us to clean up the header file and
> remove other unusued stuff.

No! We are using ioctl interface of this driver in many video
rendering applications on overlay planes on huge number of boards.
So, please don't remove it.

Anatolij
