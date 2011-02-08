From: David Miller <davem@davemloft.net>
Date: Tue, 08 Feb 2011 19:41:49 +0000
Subject: Re: [PATCH] video: ffb: fix ffb_probe error path
Message-Id: <20110208.114149.104062266.davem@davemloft.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297177125.2343.3.camel@phoenix>
In-Reply-To: <1297177125.2343.3.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: axel.lin@gmail.com
Cc: linux-kernel@vger.kernel.org, lethal@linux-sh.org, linux-fbdev@vger.kernel.org

From: Axel Lin <axel.lin@gmail.com>
Date: Tue, 08 Feb 2011 22:58:45 +0800

> Current implementation calls of_iounmap for par->fbc twice in error path.
> In the case of goto out_unmap_dac, we should call of_iounmap for par->dac.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Good spotting:

Acked-by: David S. Miller <davem@davemloft.net>
