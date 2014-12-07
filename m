From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Date: Sun, 07 Dec 2014 06:08:30 +0000
Subject: Re: [PATCH] video: ocfb: Fix data type warning
Message-Id: <20141207060829.GA18983@chokladfabriken.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1417767510-31462-1-git-send-email-qiang2.chen@sonymobile.com>
In-Reply-To: <1417767510-31462-1-git-send-email-qiang2.chen@sonymobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Qiang Chen <qiang2.chen@sonymobile.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Qiang Chen <qcwj.lk@gmail.com>

On Fri, Dec 05, 2014 at 04:18:30PM +0800, Qiang Chen wrote:
> When allocate framebuffer memory using dma_alloc_coherent(),
> we'd better use dma_addr_t instead of phys_addr_t. Because the
> address we got in fact is DMA or bus address for the platform.
> 
> This patch also fixes below build warning:
> drivers/video/fbdev/ocfb.c:335:2:
> 	warning: passing argument 3 of ‘dma_alloc_attrs’
> 	from incompatible pointer type [enabled by default]
> 
> Signed-off-by: Qiang Chen <qiang2.chen@sonymobile.com>

Acked-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
