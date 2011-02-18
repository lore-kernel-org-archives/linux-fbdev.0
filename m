From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Fri, 18 Feb 2011 10:07:01 +0000
Subject: Re: [PATCH] ARM: PXA: Make PXA27x/PXA3xx overlay actually work
Message-Id: <20110218100701.GA24655@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1296679619-32666-1-git-send-email-anarsoul@gmail.com>
In-Reply-To: <1296679619-32666-1-git-send-email-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Vasily,

On Wed, Feb 02, 2011 at 10:46:59PM +0200, Vasily Khoruzhick wrote:
> From: "Russell King - ARM Linux" <linux@arm.linux.org.uk>
> 
> Release callback tries to free memory even if it was not allocated in
> map_video_memory. Fix PXA27x/3xx overlay memory management and make overlay
> actually work.

While at pxa overlay support you also might to fix that the xpos field
in var->nonstd is also used for ypos in two places:

ypos = NONSTD_TO_XPOS(var->nonstd);
                ^^^

I stumbled upon this but was not interested enough that moment to create
a patch.

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
