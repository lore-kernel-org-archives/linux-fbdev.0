From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 05 Aug 2015 22:34:55 +0000
Subject: Re: [PATCH] staging: sm750fb: fix sparse warning for lock
Message-Id: <20150805223455.GD5180@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438781204-13283-1-git-send-email-van.freenix@gmail.com>
In-Reply-To: <1438781204-13283-1-git-send-email-van.freenix@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peng Fan <van.freenix@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Aug 05, 2015 at 09:26:44PM +0800, Peng Fan wrote:
> Use __acquire() and __release() in the right place to silence the sparse
> lock checking warning.
> 
> drivers/staging/sm750fb/sm750.c:177:13: warning: context imbalance in 'lynxfb_ops_fillrect' - different lock contexts for basic block
> drivers/staging/sm750fb/sm750.c:243:9: warning: context imbalance in 'lynxfb_ops_copyarea' - different lock contexts for basic block
> drivers/staging/sm750fb/sm750.c:247:13: warning: context imbalance in 'lynxfb_ops_imageblit' - different lock contexts for basic block
> 

Sparse is really bad at locking stuff.  Smatch is also really bad for
locking and I have been promising to re-write that check for years, but
I take comfort always in the fact that at least it's not as bad as
Sparse.

You should pretty much ignore Sparse locking warnings.

regards,
dan carpenter

