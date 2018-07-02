From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 02 Jul 2018 10:15:09 +0000
Subject: Re: [PATCH] fbcon: introduce for_each_registered_fb() helper
Message-Id: <cc1b6c9efa197d7dcf3ebec69eebdb4c3ca90eef.camel@linux.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1530202809-24105-1-git-send-email-ysxie@foxmail.com>
         <00590669b886b4cc54548e6101912c3d4d1752f2.camel@petrovitsch.priv.at>
In-Reply-To: <00590669b886b4cc54548e6101912c3d4d1752f2.camel@petrovitsch.priv.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bernd Petrovitsch <bernd@petrovitsch.priv.at>, Yisheng Xie <ysxie@foxmail.com>, b.zolnierkie@samsung.com, keescook@chromium.org, j.w.r.degoede@gmail.com, david@lechnology.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2018-07-02 at 09:36 +0200, Bernd Petrovitsch wrote:


> > +#define for_each_registered_fb(i)		\
> > +	for (i = 0; i < FB_MAX; i++)		\
> > +		if (registered_fb[i])
> > +
> 
> That leaves the possibility of a dangling-else.
> ----  snip  ----
> #define for_each_registered_fb(i)		\
> 	for (i = 0; i < FB_MAX; i++)		\
> 		if (!registered_fb[i])		\
> 			continue;		\
> 		else
> ----  snip  ----
> avoids that.

Yes, you not alone :-)

AFAIU there is a v2 which fixes that, though Daniel pointed out that DRM
has a specific macro to make life easier.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
