From: Timur Tabi <timur@freescale.com>
Date: Fri, 16 Dec 2011 23:00:53 +0000
Subject: Re: [PATCH v4 3/5] powerpc/mpc5121: shared DIU framebuffer support
Message-Id: <4EEBCDA5.5080105@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1279893639-24333-4-git-send-email-agust@denx.de>
In-Reply-To: <1279893639-24333-4-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Anatolij Gustschin wrote:
> Will DIU splash screen functionality be preserved?

That's the idea.  The root cause is that the drive initializes the DIU during the probe, which is too early.  It shouldn't touch the hardware until the open.  At that point, Linux (X, console, whatever) wants to draw something.

-- 
Timur Tabi
Linux kernel developer at Freescale

