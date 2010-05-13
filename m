From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 13 May 2010 19:24:36 +0000
Subject: Re: [PATCH] fb_defio: fix for non-dirty ptes
Message-Id: <20100513122436.e69af046.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1273697505-23421-1-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1273697505-23421-1-git-send-email-albert_herranz@yahoo.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, 13 May 2010 07:34:11 +0800
Jaya Kumar <jayakumar.lkml@gmail.com> wrote:

> On Thu, May 13, 2010 at 4:51 AM, Albert Herranz <albert_herranz@yahoo.es> wrote:
> > This patch fixes a problem observed while using fb_defio with a short
> > delay on a PowerPC platform.
> >
> > It is possible that page_mkclean() is invoked in the deferred io work
> > function _before_ a PTE has been marked dirty. In this case, the page
> > is removed from the defio pagelist but page_mkclean() does not
> > write-protect the page again. The end result is that defio ignores all
> > subsequent writes to the page and the corresponding portions of the
> > framebuffer never get updated.
> >
> > The fix consists in keeping track of the pages with non-dirty PTEs,
> > re-checking them again on the next deferred io work iteration.
> > Note that those pages are not passed to the defio callback as they are
> > not written by userspace yet.
> >
> > Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
> 
> Looks good to me. Thanks for the bugfix.
> 
> Acked-by: Jaya Kumar <jayakumar.lkml@gmail.com>

For some reason my linux-fbdev feed is being stupid and I don't have a
copy of the patch.  Resend, please?

