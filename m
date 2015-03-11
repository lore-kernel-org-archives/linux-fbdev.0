From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 11 Mar 2015 08:54:33 +0000
Subject: Re: [PATCH 1/6] staging: sm750fb: Use memset_io instead of memset
Message-Id: <20150311085433.GU10964@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426037325-8392-1-git-send-email-lstoakes@gmail.com>
In-Reply-To: <1426037325-8392-1-git-send-email-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Mar 11, 2015 at 01:28:40AM +0000, Lorenzo Stoakes wrote:
> This patch uses memset_io instead of memset when using memset on __iomem
> qualified pointers. This fixes the following sparse warnings:-
> 
> drivers/staging/sm750fb/sm750.c:489:17: warning: incorrect type in argument 1 (different address spaces)
> drivers/staging/sm750fb/sm750.c:490:17: warning: incorrect type in argument 1 (different address spaces)
> drivers/staging/sm750fb/sm750.c:501:17: warning: incorrect type in argument 1 (different address spaces)
> drivers/staging/sm750fb/sm750.c:502:17: warning: incorrect type in argument 1 (different address spaces)
> drivers/staging/sm750fb/sm750.c:833:5: warning: incorrect type in argument 1 (different address spaces)
> drivers/staging/sm750fb/sm750.c:1154:9: warning: incorrect type in argument 1 (different address spaces)
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

When I see a patch like this, then I worry, "What if the Sparse
annotations are wrong?  The patch description doesn't say anything about
that."  After review then I think the annotations are correct so that's
fine.

Btw, do you have this hardware?  Are you able to test these changes?

regards,
dan carpenter

