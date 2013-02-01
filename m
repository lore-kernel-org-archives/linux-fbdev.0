From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 01 Feb 2013 23:37:34 +0000
Subject: Re: [RFC v2 0/5] Common Display Framework
Message-Id: <3769008.t1iWZpc9bc@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353620736-6517-1-git-send-email-laurent.pinchart@ideasonboard.com> <3584709.mPLC5exzRY@avalon> <50EBF10A.7080906@stericsson.com>
In-Reply-To: <50EBF10A.7080906@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marcus Lorentzon <marcus.xm.lorentzon@stericsson.com>
Cc: Tomasz Figa <t.figa@samsung.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Tom Gall <tom.gall@linaro.org>, Ragesh Radhakrishnan <Ragesh.R@linaro.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Rob Clark <rob.clark@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, sunil joshi <joshi@samsung.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Bryan Wu <bryan.wu@canonical.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Vikas Sajjan <vikas.sajjan@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Sebastien Guiriec <s-guiriec@ti.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>

Hi Marcus,

On Tuesday 08 January 2013 11:12:26 Marcus Lorentzon wrote:

[snip]

> I also looked at the video source in Tomi's git tree
> (http://gitorious.org/linux-omap-dss2/linux/blobs/work/dss-dev-model-cdf/inc
> lude/video/display.h). I think I would prefer a single "setup" op taking a
> "struct dsi_config" as argument. Then each DSI formatter/encoder driver
> could decide best way to set that up. We have something similar at
> http://www.igloocommunity.org/gitweb/?p=kernel/igloo-kernel.git;a=blob;f=inc
> lude/video/mcde.h;hI9ce5cfecc9ad77593e761cdcc1624502f28432;hb=HEAD#l118

A single setup function indeed seems easier, but I don't have enough 
experience with DSI to have a strong opinion on that. We'll have to compare 
implementations if there's a disagreement on this.

-- 
Regards,

Laurent Pinchart

