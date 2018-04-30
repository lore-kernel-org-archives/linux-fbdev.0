From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Mon, 30 Apr 2018 19:43:46 +0000
Subject: Re: [PATCH] video: fbdev: omap2: remove rfbi
Message-Id: <20180430194346.GB2456@t60.musicnaut.iki.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180427150914eucas1p14dd8df4a215014ddac990b0ccdb1805c@eucas1p1.samsung.com>
 <2238944.jilJcacc6d@amdc3058>
 <20180427182536.skryxiih5lekqoze@darkstar.musicnaut.iki.fi>
 <2928032.Lxc8GNNcDF@amdc3058>
In-Reply-To: <2928032.Lxc8GNNcDF@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 30, 2018 at 05:34:59PM +0200, Bartlomiej Zolnierkiewicz wrote:
> BROKEN is not an user selectable config option so without modifying
> drivers/video/fbdev/omap2/omapfb/dss/Kconfig the RFBI driver is not
> even included in the kernel build..

Yes, I know. It's still incorrect to state that the code "doesn't even
compile".

A.
