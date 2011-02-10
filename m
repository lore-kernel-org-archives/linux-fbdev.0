From: Robert Schwebel <r.schwebel@pengutronix.de>
Date: Thu, 10 Feb 2011 17:09:36 +0000
Subject: Re: [PATCH] i.MX23/28 framebuffer driver
Message-Id: <20110210170936.GI22009@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297257651-8002-1-git-send-email-s.hauer@pengutronix.de>
	<201102091547.12131.arnd@arndb.de>
	<20110209153716.GN9041@pengutronix.de>
	<201102091731.07794.arnd@arndb.de>
In-Reply-To: <201102091731.07794.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Feb 09, 2011 at 05:31:07PM +0100, Arnd Bergmann wrote:
> Ok. This sounds like a lot of upfront work indeed, to make KMS more
> generic, though I think a number of driver would benefit from it
> eventually. It could be something for the Linaro graphics working
> group to look at in the following 11.11 release, depending on how
> many other people are interested in getting there.

There is already a blueprint at linaro:
https://blueprints.launchpad.net/linaro-graphics-wg/+spec/multimedia-linaro-dri-1105

We have recently tested the state of Qt acceleration on the MX51, in
order to find out which is the best way to make use of the
possibilities. However, at least at the moment this requires highly
experimental Qt sceenegraph git branches, and even then it results in
lower perfomance than with software rendering ...

But for the long term, the linaro blueprint looks like the way to go.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
