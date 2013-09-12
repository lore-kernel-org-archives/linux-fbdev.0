From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Thu, 12 Sep 2013 15:41:20 +0000
Subject: Re: [PATCH v2 1/2] video: ARM CLCD: Add DT support
Message-Id: <20130912154120.GN12758@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1378808726-32535-1-git-send-email-pawel.moll@arm.com>
 <522F57B9.5000001@wwwdotorg.org> <1378899931.4082.75.camel@hornet>
 <5230AAEB.2030607@wwwdotorg.org>
In-Reply-To: <5230AAEB.2030607@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Sep 11, 2013 at 11:39:55AM -0600, Stephen Warren wrote:
> I don't know how constrained of a system CLCD is, but I do know that
> mode validation is a very complex process in some real-life graphics
> drivers.

Apart from maximum memory bus bandwidth, probably maximum output
bandwidth, maximum resolution (determined by what will fit in the
registers and RAM) there aren't that much constraints.  The hardware
block is quite simple in that regard.

More the problem is to deal with two situations:
1. you have a particular panel connected to it which requires a certain
   fixed timing regime.
2. you have the CLCD connected to a VGA or HDMI connector where the
   timing is dependent on the connected display.

The former would be the subject of some kind of *common* DT
representation of the timing requirements of the connected panel.
For the latter, DT needs to specify how the EDID data is retrieved,
or if there is no mechanism for that, being able to provide a set
of allowable timing parameters (such as min/max vsync, min/max
hsync, max dotclock - in other words, the data which used to be
provided to X11 in the past.)

None of that is specific to CLCD though: it's the same problem as
the SA11x0 LCD controller or any other scanned video controller.
