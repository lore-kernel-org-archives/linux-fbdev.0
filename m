From: John Hubbard <jhubbard@nvidia.com>
Date: Sun, 31 May 2020 22:00:12 +0000
Subject: Re: [PATCH 0/2] video: fbdev: fix error handling, convert to pin_user_pages*()
Message-Id: <e7f95207-1b30-17a8-4667-ca58b77ec0a3@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200522041506.39638-1-jhubbard@nvidia.com>
 <20200531205819.GC138722@ravnborg.org>
 <854fae07-3cb4-dbcf-fa93-35b447f9d084@nvidia.com>
 <CAHp75Vf6=UuC2Sef3m3CpRmjAOWt8ZgBW+OPf0-_53P3F__CWw@mail.gmail.com>
In-Reply-To: <CAHp75Vf6=UuC2Sef3m3CpRmjAOWt8ZgBW+OPf0-_53P3F__CWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Gustavo A . R . Silva" <gustavo@embeddedor.com>, Jani Nikula <jani.nikula@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, LKML <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Paul Mundt <lethal@linux-sh.org>, Sam Ravnborg <sam@ravnborg.org>

On 2020-05-31 14:11, Andy Shevchenko wrote:
>     ...
> JFYI, we have history.git starting from v0.01.
> 
OK, thanks for that note. According to that history.git [1],
then: drivers/video/pvr2fb.c had get_user_pages_fast() support added to
pvr2fb_write() back in 2004, but only for CONFIG_SH_DMA, as part of

     commit 434502754f2 ("[PATCH] SH Merge")

...and that commit created the minor bug that patch 0001 here
addresses. (+Cc Paul just for the sake of completeness.)


[1] git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git


thanks,
-- 
John Hubbard
NVIDIA
