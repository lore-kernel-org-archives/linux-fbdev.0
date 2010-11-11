From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 11 Nov 2010 12:58:47 +0000
Subject: Re: [PATCH 2/4 v2] fbdev: export fb_edid_add_monspecs() for modules,
Message-Id: <Pine.LNX.4.64.1011111352200.15747@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1011021140390.4552@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1011021140390.4552@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, 10 Nov 2010, Paul Mundt wrote:

> On Tue, Nov 02, 2010 at 11:47:36AM +0100, Guennadi Liakhovetski wrote:
> > diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
> > index a0b5a93..38b3c30 100644
> > --- a/drivers/video/fbmon.c
> > +++ b/drivers/video/fbmon.c
> > @@ -973,58 +973,56 @@ void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *specs)
> >  	DPRINTK("====================\n");
> >  }
> >  
> > +/**
> > + * fb_edid_add_monspecs() - add monitor video modes from E-EDID data
> > + * @edid:	128 byte array with an E-EDID block
> > + * @spacs:	monitor specs to be extended
> > + */
> >  void fb_edid_add_monspecs(unsigned char *edid, struct fb_monspecs *specs)
> >  {
> [snip]
> >  	m = kzalloc((specs->modedb_len + num) *
> >  		       sizeof(struct fb_videomode), GFP_KERNEL);
> >  
> > -	if (!m) {
> > -		kfree(mode);
> > +	if (!m)
> >  		return;
> > +
> This can obviously fail, and should be returning the error value instead
> of simply quashing it.

Yes, this can fail, just as well as one of the other tests in the 
beginning of this function:

	if (!edid)
		return;

	if (!edid_checksum(edid))
		return;

	if (edid[0] != 0x2 ||
	    edid[2] < 4 || edid[2] > 128 - DETAILED_TIMING_DESCRIPTION_SIZE)
		return;

The idea behind the present behaviour is: the function is trying to add 
more modes to the existing modedb, but it can also fail for a number of 
reasons (e.g., no modes found in the new EDID block), in which case you 
just keep your existing modedb. So, in principle, you are not very much 
interested in whether this function managed to add any new modes or not - 
you just use whatever is there. Would you really prefer to change this?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
