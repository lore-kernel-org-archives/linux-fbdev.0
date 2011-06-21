From: Tabi Timur-B04825 <B04825@freescale.com>
Date: Tue, 21 Jun 2011 23:13:11 +0000
Subject: Re: [PATCH] fsl-diu-fb: remove the ioctl interface
Message-Id: <4E012586.7050808@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308691655-3416-1-git-send-email-timur@freescale.com>
	<20110622003853.1041385c@wker>
In-Reply-To: <20110622003853.1041385c@wker>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anatolij Gustschin <agust@denx.de>
Cc: sun york-R58495 <R58495@freescale.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "lethal@linux-sh.org" <lethal@linux-sh.org>, Tabi Timur-B04825 <B04825@freescale.com>, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>

Anatolij Gustschin wrote:
> No! We are using ioctl interface of this driver in many video
> rendering applications on overlay planes on huge number of boards.
> So, please don't remove it.

Ok, I had no idea anyone was using it.

Can you email me details about how you use the ioctl interface?  If I can't 
remove it, maybe I can clean it up.

-- 
Timur Tabi
Linux kernel developer at Freescale
