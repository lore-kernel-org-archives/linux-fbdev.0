From: Qiujun Huang <hqjagain@gmail.com>
Date: Sat, 28 Mar 2020 16:57:29 +0000
Subject: Re: [PATCH] fbcon: fix null-ptr-deref in fbcon_switch
Message-Id: <CAJRQjocxe+KfSBX3uFv+_ajcY6agF9oXWvkon_kPM+3dk6Pz2Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200328151511.22932-1-hqjagain@gmail.com>
 <CAKMK7uF2mipUSr-XRESrRJ8JdOZCekNTCVsDPW5hNp-mWwPj6Q@mail.gmail.com>
In-Reply-To: <CAKMK7uF2mipUSr-XRESrRJ8JdOZCekNTCVsDPW5hNp-mWwPj6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ghalat@redhat.com, Sam Ravnborg <sam@ravnborg.org>

On Sun, Mar 29, 2020 at 12:31 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> On Sat, Mar 28, 2020 at 4:15 PM Qiujun Huang <hqjagain@gmail.com> wrote:
> > Add check for vc_cons[logo_shown].d, as it can be released by
> > vt_ioctl(VT_DISALLOCATE).
>
> Can you pls link to the syzbot report and distill the essence of the
> crash/issue here in the commit message? As-is a bit unclear what's
> going on. Patch itself looks correct.

https://lkml.org/lkml/2020/3/27/403
Thanks.

>
> Thanks, Daniel
>
> > Reported-by: syzbot+732528bae351682f1f27@syzkaller.appspotmail.com
> > Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> > ---
> >  drivers/video/fbdev/core/fbcon.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> > index bb6ae995c2e5..7ee0f7b55829 100644
> > --- a/drivers/video/fbdev/core/fbcon.c
> > +++ b/drivers/video/fbdev/core/fbcon.c
> > @@ -2254,7 +2254,7 @@ static int fbcon_switch(struct vc_data *vc)
> >                 fbcon_update_softback(vc);
> >         }
> >
> > -       if (logo_shown >= 0) {
> > +       if (logo_shown >= 0 && vc_cons_allocated(logo_shown)) {
> >                 struct vc_data *conp2 = vc_cons[logo_shown].d;
> >
> >                 if (conp2->vc_top = logo_lines
> > @@ -2852,7 +2852,7 @@ static void fbcon_scrolldelta(struct vc_data *vc, int lines)
> >                         return;
> >                 if (vc->vc_mode != KD_TEXT || !lines)
> >                         return;
> > -               if (logo_shown >= 0) {
> > +               if (logo_shown >= 0 && vc_cons_allocated(logo_shown)) {
> >                         struct vc_data *conp2 = vc_cons[logo_shown].d;
> >
> >                         if (conp2->vc_top = logo_lines
> > --
> > 2.17.1
> >
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
