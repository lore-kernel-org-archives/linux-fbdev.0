From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 12 Sep 2013 10:46:50 +0000
Subject: Re: [PATCH 3/3] video: xilinxfb: Simplify error path
Message-Id: <001301ceafa5$630798f0$2916cad0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <7016a90750626ba866dddc6f85cfdd71943f6891.1378965270.git.michal.simek@xilinx.com>
 <940bbdfc5c67282ab461b9c82b55f18fc34c959d.1378965270.git.michal.simek@xilinx.com>
In-Reply-To: <940bbdfc5c67282ab461b9c82b55f18fc34c959d.1378965270.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Michal Simek' <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

On Thursday, September 12, 2013 2:55 PM, Michal Simek wrote:
> 
> devm_iounmap is called automatically that's why remove it from the code
> dev_set_drvdata(dev, NULL) is called by generic code
> after device_release or on probe failure.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

> ---
>  drivers/video/xilinxfb.c | 28 ++++++----------------------
>  1 file changed, 6 insertions(+), 22 deletions(-)

