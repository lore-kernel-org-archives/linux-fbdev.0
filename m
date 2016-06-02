From: Tony Lindgren <tony@atomide.com>
Date: Thu, 02 Jun 2016 15:23:06 +0000
Subject: Re: [PATCH v2 00/27] fb/drm: omapdss: Clean up the headers and separate the two stack
Message-Id: <20160602152305.GE5995@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160601083549.10549-1-peter.ujfalusi@ti.com>
 <575025DB.9020800@ti.com>
In-Reply-To: <575025DB.9020800@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com, jsarha@ti.com, dri-devel@lists.freedesktop.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [160602 05:28]:
> 
> Tony, can you have a look at the arch/arm parts here and give your ack
> if they're fine? They should be quite small and display specific, so I
> don't see much chance for conflict there.

Looks good to me, but these are going to conflict with the board-*.c
removal patches. And those we want to have easily revertable in case
of issues.

Peter, can you do an immutable minimal branch of just the pdata
changes affecting the board-*.c files? That way both Tomi and I
can merge that in.

Regards,

Tony





