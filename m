From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 26 Mar 2015 15:50:02 +0000
Subject: Re: [PATCH 02/13] staging: sm750: add missing spaces after ','
Message-Id: <20150326155002.GX10964@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150322231131.GA17080@x230-arch.club.entropia.de>
In-Reply-To: <20150322231131.GA17080@x230-arch.club.entropia.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Mar 26, 2015 at 04:28:12PM +0100, Michel von Czettritz wrote:
> >> ---
> >>  drivers/staging/sm750fb/sm750.c | 264 ++++++++++++++++++++--------------------
> >>  1 file changed, 132 insertions(+), 132 deletions(-)
> > 
> > As I didn't take your first patch, the rest of the patches in this
> > series do not apply.
> > 
> > Please fix them up, rebase on my latest staging-testing branch of
> > staging.git, and resend so that I can apply them.
> > 
> > thanks,
> > 
> > greg k-h
> 
> I am, as a newbie, a bit confused. 
> Should i resend my fixes with RESEND or with a v2 flag?

Send a v2 and under the --- cut off write:
---
v2: rebased on top of latest staging-testing branch.


> As Sudip i applied Lorenzos conflicting patches on statging-testing and rebased my patches on them. 

I don't understand this sentence.

> Should i wait until Lorenzos patches are applied?

If your patch doesn't apply when Greg gets to it, then you'll have to
redo it.  Figure out how to make it work.

regards,
dan carpenter

