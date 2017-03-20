From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 20 Mar 2017 13:06:00 +0000
Subject: Re: [PATCH v4] staging: sm750fb: Code readability is improved
Message-Id: <20170320130600.GF4343@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170319154920.GA12736@arushi-HP-Pavilion-Notebook>
 <20170320122817.GG4395@mwanda>
 <CA+XqjF-5cp0erq34KSdWexLaaumbWO9p2iA-CFiCsaF8uXsCZg@mail.gmail.com>
In-Reply-To: <CA+XqjF-5cp0erq34KSdWexLaaumbWO9p2iA-CFiCsaF8uXsCZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, driverdevel <devel@driverdev.osuosl.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com

On Mon, Mar 20, 2017 at 06:25:19PM +0530, Arushi Singhal wrote:
> On Mon, Mar 20, 2017 at 5:58 PM, Dan Carpenter <dan.carpenter@oracle.com>
> wrote:
> 
> > On Sun, Mar 19, 2017 at 09:19:20PM +0530, Arushi Singhal wrote:
> > > New variables are added to make the code more readable.
> > >
> > > Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> > > ---
> > >  changes in v4
> > >  -try to make the code much more readable.
> > >  - defined the variable at the top of a block.
> > > ---
> > >  drivers/staging/sm750fb/ddk750_mode.c | 57
> > +++++++++++++++++++----------------
> > >  1 file changed, 31 insertions(+), 26 deletions(-)
> > >
> > > diff --git a/drivers/staging/sm750fb/ddk750_mode.c
> > b/drivers/staging/sm750fb/ddk750_mode.c
> > > index eea5aef2956f..6517e770e0a7 100644
> > > --- a/drivers/staging/sm750fb/ddk750_mode.c
> > > +++ b/drivers/staging/sm750fb/ddk750_mode.c
> > > @@ -76,38 +76,43 @@ static int programModeRegisters(mode_parameter_t
> > *pModeParam, struct pll_value *
> > >  {
> > >       int ret = 0;
> > >       int cnt = 0;
> > > -     unsigned int tmp, reg;
> > > +     unsigned int tmp, reg, temp;
> >
> > Let's not have "tmp" and "temp" both.  Generally "tmp" is better because
> > you can't confuse it with temperature.
> >
> 
> Hi Dan
> I have not added the tmp variable.
> So is it good to use any other variable like "a" instead of temp.

Just re-use "tmp".  No need to add "temp".

regards,
dan carpenter

