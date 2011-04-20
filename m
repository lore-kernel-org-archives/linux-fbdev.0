From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 20 Apr 2011 06:08:38 +0000
Subject: Re: [PATCH 00/19] OMAP: DSS2: ULPS support
Message-Id: <1303279718.2102.10.camel@deskari>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
	 <4DAE7270.2010306@ti.com>
In-Reply-To: <4DAE7270.2010306@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Archit Taneja <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Wed, 2011-04-20 at 11:13 +0530, Archit Taneja wrote:
> On Tuesday 19 April 2011 02:52 PM, Valkeinen, Tomi wrote:
> > ULPS (Ultra-Low Power State) is a power saving method for DSI bus. When the
> > ULPS is entered, the host sends an ULPS entry sequence and pulls the DSI lines
> > down. On ULPS exit, the host sends an exit sequence and continues normal
> > operation. This allows both the host and the DSI peripheral to save some power
> > while in ULPS.
> >
> > This patch set implements ULPS support for DSS2. ULPS can be used with DSI
> > command mode displays, and as command mode displays can refresh the panel
> > independently using its own framebuffer, entering ULPS allows OMAP DSS HW to be
> > totally turned off while the image on the display stays. This in turn may allow
> > OMAP to enter deep sleep.
> >
> > Taal panel driver implements an inactivity timer which is used to enter ULPS
> > after a certain period. The period can configured via sysfs, "ulps_timeout"
> > file. A good value for the ulps_timeout depends on the use case and board, but
> > is most likely around 100-500ms.
> >
> > The patch set does not enable the ULPS timeout, but it has to be enabled either
> > manually via sysfs or from the board file.
> >
> > Tested on OMAP 4430 Blaze board. The patches are based on the current DSS2
> > master branch.
> 
> Tested on 4430sdp and 3430sdp with Taal Panel.

Thanks. I've applied the ULPS patch set to my master branch.

 Tomi


