From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 25 Apr 2018 10:02:51 +0000
Subject: Re: [PATCH 5/7] omapfb: omapfb_dss.h: add stubs to build with COMPILE_TEST && DRM_OMAP
Message-Id: <10529104.rM2F4eJv5O@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1524245455.git.mchehab@s-opensource.com>
 <1818588.4EAHIaV2gL@avalon> <dce06ad8-0035-81e6-9ec9-15009d13e374@ti.com>
In-Reply-To: <dce06ad8-0035-81e6-9ec9-15009d13e374@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Media Mailing List <linux-media@vger.kernel.org>

Hi Tomi,

On Wednesday, 25 April 2018 12:33:53 EEST Tomi Valkeinen wrote:
> On 25/04/18 12:03, Laurent Pinchart wrote:
> > Could we trim down omapfb to remove support for the devices supported by
> > omapdrm ?
> 
> I was thinking about just that. But, of course, it's not quite
> straightforward either.
> 
> We've got DSI manual update functionality in OMAP3-OMAP5 SoCs, which
> covers a lot of devices.

Sebastian is working on getting that feature in omapdrm, isn't he ?

> And VRFB on OMAP2/3.

And that's something I'd really like to have in omapdrm too.

> Those need omapfb.

-- 
Regards,

Laurent Pinchart



