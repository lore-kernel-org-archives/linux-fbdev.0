From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 31 May 2020 20:58:19 +0000
Subject: Re: [PATCH 0/2] video: fbdev: fix error handling, convert to pin_user_pages*()
Message-Id: <20200531205819.GC138722@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200522041506.39638-1-jhubbard@nvidia.com>
In-Reply-To: <20200522041506.39638-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Hubbard <jhubbard@nvidia.com>
Cc: linux-fbdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, "Gustavo A . R . Silva" <gustavo@embeddedor.com>, Jani Nikula <jani.nikula@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org

Hi John.
On Thu, May 21, 2020 at 09:15:04PM -0700, John Hubbard wrote:
> Hi,
> 
> Note that I have only compile-tested this series, although that does
> also include cross-compiling for a few other arches. I'm hoping that
> this posting will lead to some run-time testing.
> 
> Also: the proposed fix does not have a "Fixes:" tag, nor does it
> Cc stable. That's because the issue has been there since the dawn of
> git history for the kernel. If it's gone unnoticed this long, then
> there is clearly no need for the relatively fast track of putting it
> into stable, IMHO. But please correct me if that's wrong.
> 
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org

Thanks, patches are now applied to drm-misc-next.
They will hit -next soon, but you will have to wait
until next (not the upcoming) merge window before they hit
mainline linux.

	Sam

> 
> John Hubbard (2):
>   video: fbdev: fix error handling for get_user_pages_fast()
>   video: fbdev: convert get_user_pages() --> pin_user_pages()
> 
>  drivers/video/fbdev/pvr2fb.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> 
> base-commit: 051143e1602d90ea71887d92363edd539d411de5
> -- 
> 2.26.2
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
