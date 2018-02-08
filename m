From: Tony Lindgren <tony@atomide.com>
Date: Thu, 08 Feb 2018 15:38:58 +0000
Subject: Re: [PATCH] video: omapfb: fix missing #includes
Message-Id: <20180208153858.GA4383@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1518096294-14427-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1518096294-14427-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [180208 13:25]:
> Something has changed with the include files and omapfb no longer
> compiles as it is not explicitly including linux/pinctrl/consumer.h and
> linux/seq_file.h.
> 
> Add the missing #includes.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
> 
> This is on top of today's Linus' master branch.

Can you guys please send this ASAP to Linus so we'll have
a v4.16-rc1 that actually compiles and boots?

Otherwise testing and bisecting various topic branches for v4.17
will suck :( Many of them will be based on v4.16-rc1.

Thanks and feel free to add:

Tested-by: Tony Lindgren <tony@atomide.com>
