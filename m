From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 02 Jul 2018 10:06:38 +0000
Subject: Re: [PATCH] fbcon: introduce for_each_registered_fb() helper
Message-Id: <048c10a3acb3dec624d1064e84ffd4957648949b.camel@linux.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1530202809-24105-1-git-send-email-ysxie@foxmail.com>
         <ffe03b382ee84dbef8567b7377b929e4a8d6c23c.camel@linux.intel.com>
         <20180702073028.GZ13978@phenom.ffwll.local>
In-Reply-To: <20180702073028.GZ13978@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Yisheng Xie <ysxie@foxmail.com>, b.zolnierkie@samsung.com, keescook@chromium.org, j.w.r.degoede@gmail.com, david@lechnology.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Mon, 2018-07-02 at 09:30 +0200, Daniel Vetter wrote:
> On Fri, Jun 29, 2018 at 07:20:13PM +0300, Andy Shevchenko wrote:
> > On Fri, 2018-06-29 at 00:20 +0800, Yisheng Xie wrote:

> > LGTM except macro implementation. That's why I have mentioned
> > for_each_pci_bridge() to look at.
> > 
> > > +#define for_each_registered_fb(i)		\
> > > +	for (i = 0; i < FB_MAX; i++)		\
> > > +		if (registered_fb[i])
> > > +
> > 
> > This needs to be protected against nested conditionals.
> > Otherwise compiler issues a warning and even may generate wrong
> > code.
> 
> See for_each_if() in include/drm/drmP.h ... we should probably lift
> that
> into a general header. The for_each_if() is used all over drm in
> iterator
> macros, exactly to avoid surprises.

Wow, didn't know we have a such. It's a good idea to forelift it for
wider use.

Yisheng, it seems you may use it in your patch directly.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
