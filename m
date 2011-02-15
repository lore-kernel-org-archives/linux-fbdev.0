From: David Miller <davem@davemloft.net>
Date: Tue, 15 Feb 2011 18:53:28 +0000
Subject: Re: [PATCH] video: add missing framebuffer_release in error path
Message-Id: <20110215.105328.71128043.davem@davemloft.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297762502.4049.2.camel@phoenix>
In-Reply-To: <1297762502.4049.2.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: axel.lin@gmail.com
Cc: linux-kernel@vger.kernel.org, lethal@linux-sh.org, linux-fbdev@vger.kernel.org

From: Axel Lin <axel.lin@gmail.com>
Date: Tue, 15 Feb 2011 17:35:02 +0800

> This patch fixes a memory leak in the error path.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-by: David S. Miller <davem@davemloft.net>
