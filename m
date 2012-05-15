From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 15 May 2012 07:29:11 +0000
Subject: Re: [patch] fb: handle NULL pointers in framebuffer release
Message-Id: <20120515072911.GF16999@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120514205837.GE20836@elgon.mountain>
In-Reply-To: <20120514205837.GE20836@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, May 15, 2012 at 03:20:14PM +0800, Hein Tibosch wrote:
> On 5/15/2012 4:58 AM, Dan Carpenter wrote:
> > This function is called with a potential NULL pointer in
> > picolcd_init_framebuffer() and it causes a static checker warning.  This
> > used to handle NULL pointers when the picolcd code was written, but a
> > couple months later we added the "info->apertures" dereference.
> >
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> > diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
> > index 67afa9c..a55e366 100644
> > --- a/drivers/video/fbsysfs.c
> > +++ b/drivers/video/fbsysfs.c
> > @@ -80,6 +80,8 @@ EXPORT_SYMBOL(framebuffer_alloc);
> >   */
> >  void framebuffer_release(struct fb_info *info)
> >  {
> > +	if (!info)
> > +		return;
> >  	kfree(info->apertures);
> >  	kfree(info);
> >  }
> And not like this:
> 
> +	if (info) {
> +		if (info->apertures)
> +			kfree(info->apertures);
> +		kfree(info);
> +	}
> 

Nah.  kfree() has a NULL check built in.  I think it would trigger
a checkpatch.pl warning?

regards,
dan carpenter

