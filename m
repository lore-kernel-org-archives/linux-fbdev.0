From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 01 Jun 2020 17:25:43 +0000
Subject: Re: [PATCH 0/2] video: fbdev: fix error handling, convert to pin_user_pages*()
Message-Id: <CAHp75VfHnLz56jyR5PNgpxWGtO_u0bss45+iHhQ03c_4L3jH5g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200522041506.39638-1-jhubbard@nvidia.com>
 <20200531205819.GC138722@ravnborg.org>
 <854fae07-3cb4-dbcf-fa93-35b447f9d084@nvidia.com>
 <CAHp75Vf6=UuC2Sef3m3CpRmjAOWt8ZgBW+OPf0-_53P3F__CWw@mail.gmail.com>
 <e7f95207-1b30-17a8-4667-ca58b77ec0a3@nvidia.com>
 <CAHp75VcaXTM86K9vzyxTQJP_oNnzJ8mMHzgm7ybEioVhG6DHDQ@mail.gmail.com>
 <8fa07f59-6d77-f76b-7539-c88bf85c5036@nvidia.com>
In-Reply-To: <8fa07f59-6d77-f76b-7539-c88bf85c5036@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Hubbard <jhubbard@nvidia.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Gustavo A . R . Silva" <gustavo@embeddedor.com>, Jani Nikula <jani.nikula@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, LKML <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Paul Mundt <lethal@linux-sh.org>, Sam Ravnborg <sam@ravnborg.org>

On Mon, Jun 1, 2020 at 8:10 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 2020-06-01 03:35, Andy Shevchenko wrote:
> > On Mon, Jun 1, 2020 at 1:00 AM John Hubbard <jhubbard@nvidia.com> wrote:
> >> On 2020-05-31 14:11, Andy Shevchenko wrote:
> >>>      ...
> >>> JFYI, we have history.git starting from v0.01.
> >>>
> >> OK, thanks for that note. According to that history.git [1],
> >> then: drivers/video/pvr2fb.c had get_user_pages_fast() support added to
> >> pvr2fb_write() back in 2004, but only for CONFIG_SH_DMA, as part of
> >>
> >>       commit 434502754f2 ("[PATCH] SH Merge")
> >>
> >> ...and that commit created the minor bug that patch 0001 here
> >> addresses. (+Cc Paul just for the sake of completeness.)
> >>
> >>
> >> [1] git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
> >
> > I mentioned this one, but I guess content should be the same.
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/
> >
>
> Actually, that history.git *starts* at Linux 2.6.12-rc2,

It's not true.

> while
> tglx/history.git *ends* at Linux 2.6.12-rc2 (which is in April, 2005).
> And the commit I was looking for is in 2004. So that's why I needed a
> different stretch of history.

Actually history/history.git contains all of them starting from v0.01.
But it ends, indeed, on 2.6.33.

-- 
With Best Regards,
Andy Shevchenko
