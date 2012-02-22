From: Tony Lindgren <tony@atomide.com>
Date: Wed, 22 Feb 2012 18:09:02 +0000
Subject: Re: [PATCH 08/16] OMAPFB: remove early mem alloc from old omapfb
Message-Id: <20120222180902.GC18185@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
 <1327399231-20826-9-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1327399231-20826-9-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120124 01:30]:
> arch/arm/plat-omap/fb.c contains code to alloc omapfb buffers at early
> boot time according to information given from the bootloader or board
> file.
> 
> This code isn't currently used by any board, and is anyway something
> that the newer vram.c could handle. So remove the alloc code and in
> later patches make old omapfb driver use vram.c.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
