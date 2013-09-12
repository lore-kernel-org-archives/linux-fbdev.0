From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 12 Sep 2013 10:42:00 +0000
Subject: Re: [PATCH 2/3] video: xilinxfb: Use devm_kzalloc instead of kzalloc
Message-Id: <000c01ceafa4$b6294b60$227be220$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <7016a90750626ba866dddc6f85cfdd71943f6891.1378965270.git.michal.simek@xilinx.com>
 <f9868e54718ba467691085ff78061a447eef3635.1378965270.git.michal.simek@xilinx.com>
In-Reply-To: <f9868e54718ba467691085ff78061a447eef3635.1378965270.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Michal Simek' <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

On Thursday, September 12, 2013 2:55 PM, Michal Simek wrote:
> 
> Simplify driver probe and release function.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

> ---
>  drivers/video/xilinxfb.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)


