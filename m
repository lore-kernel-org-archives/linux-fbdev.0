From: Thomas =?UTF-8?B?TmllZGVycHLDvG0=?= <niederp@physik.uni-kl.de>
Date: Wed, 25 Mar 2015 20:10:59 +0000
Subject: Re: [PATCHv5 09/11] fbdev: ssd1307fb: Add module parameter to set the initial contrast
Message-Id: <20150325211059.1ae68f8e@maestro.intranet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
	<1427232238-21099-1-git-send-email-niederp@physik.uni-kl.de>
	<1427232238-21099-10-git-send-email-niederp@physik.uni-kl.de>
	<20150324221636.GE23664@lukather>
In-Reply-To: <20150324221636.GE23664@lukather>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, kernel@pengutronix.de, shawn.guo@linaro.org, robh+dt@kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Am Tue, 24 Mar 2015 15:16:36 -0700
schrieb Maxime Ripard <maxime.ripard@free-electrons.com>:

> On Tue, Mar 24, 2015 at 10:23:56PM +0100, Thomas Niederprüm wrote:
> > This patch adds the module parameter "contrast" to determine the
> > contrast value that is used to initialize the display. This
> > setting applies to all instances of the driver.
> > 
> > Signed-off-by: Thomas Niederprüm <niederp@physik.uni-kl.de>
> 
> Do we still need this patch given that the next one is doing the exact
> same thing?
I was kind of expecting this objection. I added this module parameter
since it suits my use case where I always run the display at the lowest
possible contrast. With this module parameter I can specify this need
at module load time and I do not need udev or to touch the backlight
controls manually every time the driver is loaded. I see that this is
probably a (too) weak argument, so if nobody complains I will remove
this patch for the next round.

Thomas
