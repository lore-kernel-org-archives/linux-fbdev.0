From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Sun, 17 May 2020 21:08:43 +0000
Subject: Re: [PATCH] fbdev: annotate rivafb/nvidiafb as obsolete
Message-Id: <CACvgo53YRogMB_Xh+=+gNLQ28beNJdhyECR0550hVqqtD0J8Bg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200513215627eucas1p1c919a6175b210c13fe7b920c455ebb62@eucas1p1.samsung.com>
 <20200513215342.2145495-1-emil.l.velikov@gmail.com>
 <178a203a-fc3e-0027-60c9-786c3e907407@samsung.com>
In-Reply-To: <178a203a-fc3e-0027-60c9-786c3e907407@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>

On Thu, 14 May 2020 at 14:28, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:

> > diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> > index 1b2f5f31fb6f..cad3e4bc5e52 100644
> > --- a/drivers/video/fbdev/Kconfig
> > +++ b/drivers/video/fbdev/Kconfig
> > @@ -868,6 +868,7 @@ config FB_ATMEL
> >
> >  config FB_NVIDIA
> >       tristate "nVidia Framebuffer Support"
> > +     depends on BROKEN
>
> Please don't add new users of BROKEN config option.
>
> Either it is broken and should be removed right now (BROKEN config option
> predates git and with git nothing is ever lost), or it still works and
> should be left alone.
>
Seems like not everyone got that memo. BROKEN is still in use, with
dozen or so cases for last year.
See for example:

commit 9d60d93198c62ac3b3e59e8bba7079646c972a4c
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Mon Aug 26 10:28:58 2019 -0400

    Deprecate nfsd fault injection


That said, your suggestions are pretty good. v2 coming in a moment.

-Emil
