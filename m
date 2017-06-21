From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 21 Jun 2017 09:12:46 +0000
Subject: Re: [PATCH] staging: sm750fb: move common locking code to a macro
Message-Id: <20170621091246.sjhvzmuapupbzhyt@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170620165013.11013-1-mail@dbalan.in>
 <20170620200538.krwizqgsyk5rqe22@mwanda>
 <1498035541.4855.3.camel@dbalan.in>
In-Reply-To: <1498035541.4855.3.camel@dbalan.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Dhananjay Balan <mail@dbalan.in>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, sudipm.mukherjee@gmail.com

On Wed, Jun 21, 2017 at 10:59:01AM +0200, Dhananjay Balan wrote:
> Tue, 2017-06-20, 23:05 +0300-യ്ക്ക, Dan Carpenter എഴുതിയിരിക്കുന്നു:
> > On Tue, Jun 20, 2017 at 06:50:13PM +0200, Dhananjay Balan wrote:
> > > The locking and unlocking code used by copy routines is common, so
> > > moved it to a macro.
> > > 
> > > Signed-off-by: Dhananjay Balan <mail@dbalan.in>
> > > ---
> > >  drivers/staging/sm750fb/sm750.c | 81 ++++++++++++++++-------------
> > > ------------
> > >  1 file changed, 31 insertions(+), 50 deletions(-)
> > > 
> > > diff --git a/drivers/staging/sm750fb/sm750.c
> > > b/drivers/staging/sm750fb/sm750.c
> > > index 386d4adcd91d..d8ab83aea46d 100644
> > > --- a/drivers/staging/sm750fb/sm750.c
> > > +++ b/drivers/staging/sm750fb/sm750.c
> > > @@ -156,12 +156,25 @@ static int lynxfb_ops_cursor(struct fb_info
> > > *info, struct fb_cursor *fbcursor)
> > >  	return 0;
> > >  }
> > >  
> > > +/*
> > > + * If not using spin_lock, system will die if user frequently
> > > loads and
> > > + * immediately unloads driver (dual)
> > > + */
> > > +#define dual_safe_call(func, ...)					
> > > \
> > > +	do {							
> > > 	\
> > > +		if (sm750_dev->fb_count > 1)			
> > > 	\
> > > +			spin_lock(&sm750_dev->slock);		
> > > 	\
> > > +		func(__VA_ARGS__);					
> > > \
> > > +		if (sm750_dev->fb_count > 1)			
> > > 	\
> > > +			spin_unlock(&sm750_dev->slock);		
> > > 	\
> > > +	} while (0)
> > > +
> > 
> > I feel like this is the wrong approach.  You could just make a small
> > lock function and a small unlock function.  Except that if statement
> > seems kind of bogus.  What happens if ->fb_count is 0 when we lock
> > and
> > 1 when we unlock?  Why not lock unconditionally?  It is not likely to
> > be
> > contested if there are no other users.
> I've to admit that I don't have much info, but is fb_count supposed to
> change during this execution?

It could change, yes.

regards,
dan carpenter

