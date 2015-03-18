From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 18 Mar 2015 10:18:57 +0000
Subject: Re: [PATCH RESEND 1/5] staging: sm750fb: Use memset_io instead of memset
Message-Id: <20150318101857.GO10964@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426669046-29935-1-git-send-email-lstoakes@gmail.com>
 <20150318101717.GN10964@mwanda>
In-Reply-To: <20150318101717.GN10964@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, sudipm.mukherjee@gmail.com

On Wed, Mar 18, 2015 at 01:17:17PM +0300, Dan Carpenter wrote:
> Why is there a RESEND in the subject.
> 
> On Wed, Mar 18, 2015 at 08:57:22AM +0000, Lorenzo Stoakes wrote:
> > This patch uses memset_io instead of memset when using memset on __iomem
> > qualified pointers. This fixes the following sparse warnings:-
> > 
> > drivers/staging/sm750fb/sm750.c:489:17: warning: incorrect type in argument 1 (different address spaces)
> > drivers/staging/sm750fb/sm750.c:490:17: warning: incorrect type in argument 1 (different address spaces)
> > drivers/staging/sm750fb/sm750.c:501:17: warning: incorrect type in argument 1 (different address spaces)
> > drivers/staging/sm750fb/sm750.c:502:17: warning: incorrect type in argument 1 (different address spaces)
> > drivers/staging/sm750fb/sm750.c:833:5: warning: incorrect type in argument 1 (different address spaces)
> > drivers/staging/sm750fb/sm750.c:1154:9: warning: incorrect type in argument 1 (different address spaces)
> > 
> 
> This changelog still sucks.  It doesn't describe the effect of this
> behavior change for the user.  It doesn't even make it clear that you
> are aware that this is a behavior change.

It doesn't say to me that you have asked yourself if the sparse
annotations are correct.  Many times they are wrong.

We have had this discussion before but you still sent the same exact
bad changelog.

regards,
dan carpenter

