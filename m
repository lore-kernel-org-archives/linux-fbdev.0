From: Tony Lindgren <tony@atomide.com>
Date: Wed, 22 Feb 2012 18:11:28 +0000
Subject: Re: [PATCH 15/16] OMAP1: Remove unused LCD devices from board files
Message-Id: <20120222181128.GG18185@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
 <1327399231-20826-16-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1327399231-20826-16-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120124 01:30]:
> Some OMAP1 board files define LCD platform_devices, but there are no
> corresponding LCD drivers for those in the kernel. Thus remove these LCD
> devices.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
