From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Date: Wed, 21 Apr 2010 13:36:17 +0000
Subject: RE: [PATCH] fbdev: move FBIO_WAITFORVSYNC to linux/fb.h
Message-Id: <19F8576C6E063C45BE387C64729E7394044E1EB423@dbde02.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1271429829-23577-1-git-send-email-notasas@gmail.com>
In-Reply-To: <1271429829-23577-1-git-send-email-notasas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


> -----Original Message-----
> From: James Simmons [mailto:jsimmons@infradead.org]
> Sent: Wednesday, April 21, 2010 6:51 PM
> To: Hiremath, Vaibhav
> Cc: Andrew Morton; Grazvydas Ignotas; linux-fbdev@vger.kernel.org
> Subject: RE: [PATCH] fbdev: move FBIO_WAITFORVSYNC to linux/fb.h
> 
> 
> > > -----Original Message-----
> > > From: Andrew Morton [mailto:akpm@linux-foundation.org]
> > > Sent: Wednesday, April 21, 2010 4:25 AM
> > > To: Hiremath, Vaibhav
> > > Cc: Grazvydas Ignotas; linux-fbdev@vger.kernel.org
> > > Subject: Re: [PATCH] fbdev: move FBIO_WAITFORVSYNC to linux/fb.h
> > >
> > > On Tue, 20 Apr 2010 14:35:10 +0530
> > > "Hiremath, Vaibhav" <hvaibhav@ti.com> wrote:
> > >
> > > > ...
> > > >
> > > > > --- a/include/linux/fb.h
> > > > > +++ b/include/linux/fb.h
> > > > > @@ -23,6 +23,8 @@ struct dentry;
> > > > >  #else
> > > > >  #define FBIO_CURSOR            _IOWR('F', 0x08, struct fb_cursor)
> > > > >  #endif
> > > > > +#define FBIO_WAITFORVSYNC	_IOW('F', 0x20, __u32)
> > > > > +
> > > > [Hiremath, Vaibhav] Do not insert it in middle, lets follow the
> sequence
> > > and append it at last. Otherwise looks ok to me.
> > >
> > [Hiremath, Vaibhav] Andrew,
> > If I understand correctly, the previous patch was not following the IOCTL
> numbering sequence.
> >
> > Logically this IOCTL should get added as per their number sequence that is
> at the end after FBIOGET_DISPINFO (0x4618).
> 
> Changing the IOCTL number for WAITFORSYNC would break several apps like
> egl and directfb. I'm afraid we are stuff with that number.
[Hiremath, Vaibhav] Yeah, I understand this, and thinking on the same line, I am not asking to change the ioctl no, it's only placing the declaration/definition in logical sequence.

Thanks,
Vaibhav

