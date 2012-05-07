From: Tony Lindgren <tony@atomide.com>
Date: Mon, 07 May 2012 17:46:58 +0000
Subject: Re: [PATCH 00/25] OMAPDSS: DT preparation patches v2
Message-Id: <20120507174657.GF5088@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

Hi,

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120503 07:01]:
> Hi,
> 
> I started cleaning up and restructuring omapdss for device tree, and here's the
> first set of patches from that ordeal. There's nothing DT specific in these
> patches, but they are mostly generic cleanups that make sense even without DT.
> 
> This is the second version of these patches, the previous version can be found
> from: http://www.spinics.net/lists/linux-fbdev/msg05667.html
> 
> The first 21 patches, which were in the previous version, have only gotten
> minor cleanups (and, of course, more testing). The last 4 patches are new. The
> most important of those patches is the DSI pin config patch, which makes it
> possible for the panel driver to configure the DSI pins it needs.
> 
> This series can also be found from:
> git://gitorious.org/linux-omap-dss2/linux.git work/devtree-base

Nice clean up. Can you please put the first 12 arch/arm/*omap*/* touching
patches (and the drivers/video dependencies needed) into a separate branch
and send me a pull request. That is assuming those patches are now immutable.

Then I can pull it into cleanup-dss branch that we both can merge as
needed.

Regards,

Tony
