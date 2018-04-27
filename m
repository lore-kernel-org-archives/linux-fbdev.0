From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 27 Apr 2018 17:58:28 +0000
Subject: Re: [PATCH] video: fbdev: omap2: remove rfbi
Message-Id: <2055912.iuafLNK0IC@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180427150914eucas1p14dd8df4a215014ddac990b0ccdb1805c@eucas1p1.samsung.com>
 <2238944.jilJcacc6d@amdc3058>
 <20180427174714.bdvvlljk3txwu2bo@darkstar.musicnaut.iki.fi>
In-Reply-To: <20180427174714.bdvvlljk3txwu2bo@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org

On Friday, April 27, 2018 08:47:14 PM Aaro Koskinen wrote:
> Hi,
> 
> On Fri, Apr 27, 2018 at 05:09:14PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > omapfb equivalent of drm's commit aa61321d4c08 ("drm/omap: remove rfbi"):
> > 
> > The RFBI driver has not worked nor compiled for many years. There are
> > very few boards out there that use RFBI, and no one has stepped up to
> > fix it.
> >
> > So let's remove the RFBI code that doesn't even compile.
> 
> NACK. I'm just about to start fixing this and hoping to get display
> working on N8x0 boards.
> 
> See the other thread: https://marc.info/?l=linux-omap&m2469100217934&w=2

You should be targeting omapdrm driver instead, fbdev subsystem is closed
for the new hardware support.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

