From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 20 Apr 2010 22:54:45 +0000
Subject: Re: [PATCH] fbdev: move FBIO_WAITFORVSYNC to linux/fb.h
Message-Id: <20100420155445.11776163.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1271429829-23577-1-git-send-email-notasas@gmail.com>
In-Reply-To: <1271429829-23577-1-git-send-email-notasas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, 20 Apr 2010 14:35:10 +0530
"Hiremath, Vaibhav" <hvaibhav@ti.com> wrote:

> ...
>
> > --- a/include/linux/fb.h
> > +++ b/include/linux/fb.h
> > @@ -23,6 +23,8 @@ struct dentry;
> >  #else
> >  #define FBIO_CURSOR            _IOWR('F', 0x08, struct fb_cursor)
> >  #endif
> > +#define FBIO_WAITFORVSYNC	_IOW('F', 0x20, __u32)
> > +
> [Hiremath, Vaibhav] Do not insert it in middle, lets follow the sequence and append it at last. Otherwise looks ok to me.

Confused.  That definition appears to be in the appropriate place to me.

> We should merge this patch.
> 
> There are some other drivers (like OMAP) which define WAITFORVSYNC ioctl with custom (OMAPFB_WAITFORVSYNC) way needs to be changed for this. 
> 
> I will change them and submit it to list.

Please cc myself...
