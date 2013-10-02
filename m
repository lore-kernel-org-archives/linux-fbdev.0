From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Wed, 02 Oct 2013 20:25:21 +0000
Subject: Re: [PATCH] amba: Ensure drvdata is NULL
Message-Id: <20131002202521.GU12758@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1b2479137287fa8dfda3089ca0cb9fba8c4b1f1d.1380524337.git.michal.simek@xilinx.com>
In-Reply-To: <1b2479137287fa8dfda3089ca0cb9fba8c4b1f1d.1380524337.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Sep 30, 2013 at 08:59:06AM +0200, Michal Simek wrote:
> This patch is inpired by the patch for drvdata
> "device-core: Ensure drvdata = NULL when no driver is bound"
> (sha1: 0998d0631001288a5974afc0b2a5f568bcdecb4d)
> 
> Also it fixes all occurences in drivers.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> This patch has been sent as RFC in this thread.
> http://lkml.org/lkml/2013/9/4/393

Why not have the driver core do this?  Then it gets applied to all bus
types uniformly.

Thanks.
