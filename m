From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 29 Jul 2020 08:18:12 +0000
Subject: Re: [PATCH] vt: Handle recursion in vc_do_resize().
Message-Id: <CAKMK7uHeteS2+rKrZKrAM+zQO==hAX0XaVc9JfHPsdLTCtzKOw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1596000620-4075-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <1596000620-4075-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Jiri Slaby <jslaby@suse.com>, syzbot <syzbot+c37a14770d51a085a520@syzkaller.appspotmail.com>

On Wed, Jul 29, 2020 at 8:58 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> syzbot is reporting OOB read bug in vc_do_resize() [1] caused by memcpy()
> based on outdated old_{rows,row_size} values, for resize_screen() can
> recurse into vc_do_resize() which changes vc->vc_{cols,rows} that outdates
> old_{rows,row_size} values which were read before calling resize_screen().
>
> Minimal fix might be to read vc->vc_{rows,size_row} after resize_screen().
> A different fix might be to forbid recursive vc_do_resize() request.
> I can't tell which fix is the better.
>
> But since I guess that new_cols =3D vc->vc_cols && new_rows =3D vc->vc_ro=
ws
> check could become true after returning from resize_screen(), and I assume
> that not calling clear_selection() when resize_screen() will return error
> is harmless, let's redo the check by moving resize_screen() earlier.
>
> [1] https://syzkaller.appspot.com/bug?id=C70c88cfd16dcf6e1d3c7f0ab8648b31=
44b5b25e
>
> Reported-by: syzbot <syzbot+c37a14770d51a085a520@syzkaller.appspotmail.co=
m>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Ok, I have actual insight on this one here, and I'm pretty sure this
isn't the fix. Looking at the syzkaller splat we have a recursion of
the form

fb_ioctl -> fb_set_var -> fbcon_update_vcs -> fbcon_resize -> fb_set_var

Which isn't supposed to be happening. I've dug around recently in
fbcon code, and this is a fairly common issue: You can update fbcon
state both from fb_ioctl, but also from the vc side. To avoid the
above recursion problems the code is using FBINFO_MISC_USEREVENT, and
should only set that from fb_ioctl entry points. That's all fairly
fragile, so I've done a bit of reworking, e.g.

commit de29ae5c092bd9a5360cfabf174b0f783248d278
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue May 28 11:02:56 2019 +0200

    fbmem: pull fbcon_fb_blanked out of fb_blank

as an example.

I think doing the same for fb_set_var, i.e. only calling
fbcon_update_vcs for the 3 callers that want it, should fix this
recursion. I think that's the much more robust fix instead of trying
to paper over the fallout of this recursion here and everywhere else.

Can you look into reworking your patch like that?

Cheers, Daniel

> ---
>  drivers/tty/vt/vt.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 42d8c67..952a067 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -1217,7 +1217,24 @@ static int vc_do_resize(struct tty_struct *tty, st=
ruct vc_data *vc,
>
>         if (new_cols =3D vc->vc_cols && new_rows =3D vc->vc_rows)
>                 return 0;
> +       if (new_screen_size > KMALLOC_MAX_SIZE || !new_screen_size)
> +               return -EINVAL;
>
> +       /*
> +        * Since fbcon_resize() from resize_screen() can recurse into
> +        * this function via fb_set_var(), handle recursion now.
> +        */
> +       err =3D resize_screen(vc, new_cols, new_rows, user);
> +       if (err)
> +               return err;
> +       /* Reload values in case recursion changed vc->vc_{cols,rows}. */
> +       new_cols =3D (cols ? cols : vc->vc_cols);
> +       new_rows =3D (lines ? lines : vc->vc_rows);
> +       new_row_size =3D new_cols << 1;
> +       new_screen_size =3D new_row_size * new_rows;
> +
> +       if (new_cols =3D vc->vc_cols && new_rows =3D vc->vc_rows)
> +               return 0;
>         if (new_screen_size > KMALLOC_MAX_SIZE || !new_screen_size)
>                 return -EINVAL;
>         newscreen =3D kzalloc(new_screen_size, GFP_USER);
> @@ -1238,13 +1255,6 @@ static int vc_do_resize(struct tty_struct *tty, st=
ruct vc_data *vc,
>         old_rows =3D vc->vc_rows;
>         old_row_size =3D vc->vc_size_row;
>
> -       err =3D resize_screen(vc, new_cols, new_rows, user);
> -       if (err) {
> -               kfree(newscreen);
> -               vc_uniscr_free(new_uniscr);
> -               return err;
> -       }
> -
>         vc->vc_rows =3D new_rows;
>         vc->vc_cols =3D new_cols;
>         vc->vc_size_row =3D new_row_size;
> --
> 1.8.3.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
