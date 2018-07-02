From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 02 Jul 2018 07:30:28 +0000
Subject: Re: [PATCH] fbcon: introduce for_each_registered_fb() helper
Message-Id: <20180702073028.GZ13978@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1530202809-24105-1-git-send-email-ysxie@foxmail.com>
 <ffe03b382ee84dbef8567b7377b929e4a8d6c23c.camel@linux.intel.com>
In-Reply-To: <ffe03b382ee84dbef8567b7377b929e4a8d6c23c.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-fbdev@vger.kernel.org, j.w.r.degoede@gmail.com, david@lechnology.com, b.zolnierkie@samsung.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Yisheng Xie <ysxie@foxmail.com>, keescook@chromium.org

On Fri, Jun 29, 2018 at 07:20:13PM +0300, Andy Shevchenko wrote:
> On Fri, 2018-06-29 at 00:20 +0800, Yisheng Xie wrote:
> > Following pattern is often used:
> > 
> >  for (i = 0; i < FB_MAX; i++) {
> >         if (registered_fb[i]) {
> >                 ...
> >         }
> >  }
> > 
> > Therefore, as Andy's suggestion, for_each_registered_fb() helper can
> 
> Suggested-by then ?
> 
> > be introduced to make the code easier to read and write by reducing
> > indentation level. It also saves few lines of code in each occurrence.
> > 
> > This patch convert all part here at the same time.
> 
> LGTM except macro implementation. That's why I have mentioned
> for_each_pci_bridge() to look at.
> 
> > +#define for_each_registered_fb(i)		\
> > +	for (i = 0; i < FB_MAX; i++)		\
> > +		if (registered_fb[i])
> > +
> 
> This needs to be protected against nested conditionals.
> Otherwise compiler issues a warning and even may generate wrong code.

See for_each_if() in include/drm/drmP.h ... we should probably lift that
into a general header. The for_each_if() is used all over drm in iterator
macros, exactly to avoid surprises.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
