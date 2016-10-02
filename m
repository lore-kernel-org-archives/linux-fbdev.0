From: Moshe Green <mgmoshes@gmail.com>
Date: Sun, 02 Oct 2016 10:43:14 +0000
Subject: Re: [PATCH] staging: sm750fb: rename macro roundedDiv to rounded_div in ddk750_chip.c
Message-Id: <20161002104314.GA15142@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <bbdf9102afd4b72160d274a575a2f1eea5580afb.1475387062.git.mgmoshes@gmail.com>
 <20161002094747.GA27462@kroah.com>
In-Reply-To: <20161002094747.GA27462@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Sun, Oct 02, 2016 at 11:47:47AM +0200, Greg KH wrote:
> On Sun, Oct 02, 2016 at 08:48:32AM +0300, Moshe Green wrote:
> > Rename CamelCased macro roundedDiv to rounded_div.
> > 
> > This issue was found by checkpatch.pl
> > 
> > Signed-off-by: Moshe Green <mgmoshes@gmail.com>
> > ---
> >  drivers/staging/sm750fb/ddk750_chip.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
> > index 3a0afe1..e4efe91 100644
> > --- a/drivers/staging/sm750fb/ddk750_chip.c
> > +++ b/drivers/staging/sm750fb/ddk750_chip.c
> > @@ -7,7 +7,7 @@
> >  #include "ddk750_power.h"
> >  
> >  /* n / d + 1 / 2 = (2n + d) / 2d */
> > -#define roundedDiv(num, denom)	((2 * (num) + (denom)) / (2 * (denom)))
> > +#define rounded_div(num, denom)	((2 * (num) + (denom)) / (2 * (denom)))
> 
> Shouldn't you use the in-kernel function for this instead?

(I thought briefly of looking for an existing implementation but
then chose not to since I wanted to minimize the functional changes in my patches
for the time being. Additionally I was wary of using a different implementation for a
division operation.)

I'll submit a patch that will replace the local implemetaion of rounded
division with the in-kernel implementation (I'm assuming you're
referring to the DIV_ROUND_CLOSEST macro from include/linux/kernel.h).

Thanks
Moshe Green
