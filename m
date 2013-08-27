From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 27 Aug 2013 01:16:02 +0000
Subject: Re: [patch] tgafb: potential NULL dereference in init
Message-Id: <20130827011602.GH6329@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130826145610.GA12428@elgon.mountain>
In-Reply-To: <20130826145610.GA12428@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Aug 26, 2013 at 07:51:04PM +0200, Geert Uytterhoeven wrote:
> On Mon, Aug 26, 2013 at 4:56 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > --- a/drivers/video/tgafb.c
> > +++ b/drivers/video/tgafb.c
> > @@ -1475,7 +1475,7 @@ tgafb_init_fix(struct fb_info *info)
> >         int tga_bus_pci = TGA_BUS_PCI(par->dev);
> >         int tga_bus_tc = TGA_BUS_TC(par->dev);
> >         u8 tga_type = par->tga_type;
> > -       const char *tga_type_name = NULL;
> > +       const char *tga_type_name;
> 
> Now the real compiler (at least some versions of gcc) will complain
> about an uninitialized variable...

Oh crap!  The compiler is totally correct here.  I don't know what I was
thinking.  I've just double checked now and my compiler does not catch
this (GCC 4.7.2).

Sorry about that.

regards,
dan carpenter

