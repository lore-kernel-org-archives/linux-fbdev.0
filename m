From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Fri, 21 Sep 2012 12:19:03 +0000
Subject: Re: [RFC PATCH 1/3] amba-clcd: Add Device Tree support to amba-clcd driver
Message-Id: <20120921121903.GE15609@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348070666-9153-1-git-send-email-ryan.harkin@linaro.org>
 <1348070666-9153-2-git-send-email-ryan.harkin@linaro.org>
 <20120921114345.GE24458@pengutronix.de>
In-Reply-To: <20120921114345.GE24458@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Sep 21, 2012 at 01:43:45PM +0200, Sascha Hauer wrote:
> We are currently discussing a common panel description for the
> devicetree. You are invited to join in here:
> 
> http://comments.gmane.org/gmane.linux.drivers.devicetree/21386
> 
> We shouldn't add any more device specific panel descriptions.

Just make sure that you don't end up encoding in integers in the device
tree Linux kernel specific bitfields such as the 'sync' property above.

Also, look at how the AMBA CLCD driver handles the panels with its
capability bitmask for the colour formats - this allows the driver to
determine what colour formats are supported, and allows platform code
to work out how to program any MUXes for any particular panel and
requested colour depth setting.  It also allows figuring out whether
BGR or RGB format should be used.

This is necessary because of the beweildering array of panels, muxes
and other funky hardware which ARM Ltd like to put into their boards,
and the fact that the LCDs tend to be entirely separate entities to
the boards themselves.
