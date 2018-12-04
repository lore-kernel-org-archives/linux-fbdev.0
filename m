From: Nishad Kamdar <nishadkamdar@gmail.com>
Date: Tue, 04 Dec 2018 15:56:54 +0000
Subject: Re: [PATCH 04/26] Staging: fbtft: flexfb: Switch to the gpio descriptor interface
Message-Id: <20181204155634.GA16146@nishad>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1543142440.git.nishadkamdar@gmail.com>
 <0bc27a5c4f06e50f9cc2d568c6ce5f983dc84925.1543142440.git.nishadkamdar@gmail.com>
 <20181126101308.GI3088@unbuntlaptop>
In-Reply-To: <20181126101308.GI3088@unbuntlaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Mon, Nov 26, 2018 at 01:13:08PM +0300, Dan Carpenter wrote:
> On Sun, Nov 25, 2018 at 04:56:29PM +0530, Nishad Kamdar wrote:
> > This switches the flexfb.c to use GPIO descriptors
> > rather than numerical gpios.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> >  drivers/staging/fbtft/flexfb.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/staging/fbtft/flexfb.c b/drivers/staging/fbtft/flexfb.c
> > index 2af474469e7d..c5fa59105a43 100644
> > --- a/drivers/staging/fbtft/flexfb.c
> > +++ b/drivers/staging/fbtft/flexfb.c
> > @@ -9,7 +9,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/init.h>
> >  #include <linux/vmalloc.h>
> > -#include <linux/gpio.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/spi/spi.h>
> >  #include <linux/delay.h>
> >  
> > @@ -521,7 +521,7 @@ static int flexfb_verify_gpios_dc(struct fbtft_par *par)
> >  {
> >  	fbtft_par_dbg(DEBUG_VERIFY_GPIOS, par, "%s()\n", __func__);
> >  
> > -	if (par->gpio.dc < 0) {
> > +	if (!par->gpio.dc) {
> >  		dev_err(par->info->device,
> >  			"Missing info about 'dc' gpio. Aborting.\n");
> >  		return -EINVAL;
> 
> We changed par->gpio.c from an int to a pointer in patch 1 so we have
> to update all the checks as well in the same patch.  Otherwise it breaks
> `git bisect`.
> 
> (I don't know this code well.  But it just feels like it has to be
> breaking git bisect just from from glancing at the patches.  Perhaps I
> have misunderstood).
> 
> regards,
> dan carpenter
> 
Ok. I'll merge them into one patch.

Thanks for the review and the pointer.

Regards,
Nishad
