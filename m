From: Anatolij Gustschin <agust@denx.de>
Date: Wed, 22 Jun 2011 20:11:43 +0000
Subject: Re: [PATCH] fsl-diu-fb: remove the ioctl interface
Message-Id: <20110622221143.503add74@wker>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308691655-3416-1-git-send-email-timur@freescale.com>
	<20110622003853.1041385c@wker> <4E012586.7050808@freescale.com>
In-Reply-To: <4E012586.7050808@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "lethal@linux-sh.org" <lethal@linux-sh.org>, sun york-R58495 <R58495@freescale.com>

On Tue, 21 Jun 2011 23:13:11 +0000
Tabi Timur-B04825 <B04825@freescale.com> wrote:

> Anatolij Gustschin wrote:
> > No! We are using ioctl interface of this driver in many video
> > rendering applications on overlay planes on huge number of boards.
> > So, please don't remove it.
> 
> Ok, I had no idea anyone was using it.
> 
> Can you email me details about how you use the ioctl interface?  If I can't 
> remove it, maybe I can clean it up.

Following DIU specific ioctls are used:

MFB_SET_CHROMA_KEY
MFB_SET_PIXFMT
MFB_GET_PIXFMT
MFB_SET_AOID
MFB_GET_AOID
MFB_GET_ALPHA
MFB_SET_ALPHA

Other ioctls can be removed. I'm not sure if someone
uses FBIOGET_GWINFO. If there are no objections from
other people, it can also be dropped.
