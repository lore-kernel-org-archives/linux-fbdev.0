From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 18 Mar 2015 10:17:17 +0000
Subject: Re: [PATCH RESEND 1/5] staging: sm750fb: Use memset_io instead of memset
Message-Id: <20150318101717.GN10964@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426669046-29935-1-git-send-email-lstoakes@gmail.com>
In-Reply-To: <1426669046-29935-1-git-send-email-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Why is there a RESEND in the subject.

On Wed, Mar 18, 2015 at 08:57:22AM +0000, Lorenzo Stoakes wrote:
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

This changelog still sucks.  It doesn't describe the effect of this
behavior change for the user.  It doesn't even make it clear that you
are aware that this is a behavior change.

regards,
dan carpenter
