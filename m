From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 26 Sep 2013 09:53:44 +0000
Subject: Re: [patch 1/2] backlight: lm3630: signedness bug in lm3630a_chip_init()
Message-Id: <20130926095344.GA6247@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130925085451.GA6661@elgon.mountain>
In-Reply-To: <20130925085451.GA6661@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Sep 26, 2013 at 12:43:43PM +0300, Tomi Valkeinen wrote:
> On 25/09/13 11:54, Dan Carpenter wrote:
> > "rval" needs to be signed for the error handling to work.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
> > index c63f918..65392f9 100644
> > --- a/drivers/video/backlight/lm3630a_bl.c
> > +++ b/drivers/video/backlight/lm3630a_bl.c
> > @@ -105,7 +105,7 @@ static int lm3630a_chip_init(struct lm3630a_chip *pchip)
> >  /* interrupt handling */
> >  static void lm3630a_delayed_func(struct work_struct *work)
> >  {
> > -	unsigned int rval;
> > +	int rval;
> >  	struct lm3630a_chip *pchip;
> >  
> >  	pchip = container_of(work, struct lm3630a_chip, work.work);
> > 
> 
> There's no drivers/video/backlight/lm3630a_bl.c in v3.12. Which kernel
> is this for?
> 

The story is that this driver wasn't submitted to you or to linux-fbdev
but only to lkml.

Andrew Morton (the only person who reads LKML) picked it up in his tree.
Probably at some point he will prod you into taking it through your
tree.  Anyway, I resent the patches so they're in -mm now.

regards,
dan carpenter

