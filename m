From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 14 Feb 2020 18:08:21 +0000
Subject: Re: [PATCH v1] fbdev: simplefb: Platform data shan't include kernel.h
Message-Id: <20200214180821.GO10400@smile.fi.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200204162114.28937-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200204162114.28937-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, Feb 14, 2020 at 04:21:57PM +0100, Hans de Goede wrote:
> On 2/14/20 3:25 PM, Andy Shevchenko wrote:
> > On Tue, Feb 04, 2020 at 06:21:14PM +0200, Andy Shevchenko wrote:
> > > Replace with appropriate types.h.
> > 
> > Hans, any comment on this?
> 
> Not really, I've not touched that code in a while.
> 
> But I see I'm still listed as the maintainer, the change looks sensible
> to me, so:
> 
> Acked-by: Hans de Goede <hdegoede@redhat.com>

Thanks!
Seems get_maintainer does not list Bart, so, Cc him here.

> 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >   include/linux/platform_data/simplefb.h | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/platform_data/simplefb.h b/include/linux/platform_data/simplefb.h
> > > index 4f733a411d18..ca8337695c2a 100644
> > > --- a/include/linux/platform_data/simplefb.h
> > > +++ b/include/linux/platform_data/simplefb.h
> > > @@ -10,7 +10,7 @@
> > >   #include <drm/drm_fourcc.h>
> > >   #include <linux/fb.h>
> > > -#include <linux/kernel.h>
> > > +#include <linux/types.h>
> > >   /* format array, use it to initialize a "struct simplefb_format" array */
> > >   #define SIMPLEFB_FORMATS \
> > > -- 
> > > 2.24.1
> > > 
> > 
> 

-- 
With Best Regards,
Andy Shevchenko
