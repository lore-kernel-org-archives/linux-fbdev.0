From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 04 Aug 2020 12:58:31 +0000
Subject: Re: [PATCH] vt: defer kfree() of vc_screenbuf in vc_do_resize()
Message-Id: <20200804125831.GA221149@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1596034621-4714-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <0c9d8003-ba3f-8f2d-7c5a-56c5ca7db750@i-love.sakura.ne.jp>
In-Reply-To: <0c9d8003-ba3f-8f2d-7c5a-56c5ca7db750@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, syzbot <syzbot+9116ecc1978ca3a12f43@syzkaller.appspotmail.com>, Jiri Slaby <jslaby@suse.com>

On Tue, Aug 04, 2020 at 08:15:43PM +0900, Tetsuo Handa wrote:
> Do you think this approach is acceptable? Or, do we need to modify set_origin() ?
> 
> On 2020/07/29 23:57, Tetsuo Handa wrote:
> > syzbot is reporting UAF bug in set_origin() from vc_do_resize() [1], for
> > vc_do_resize() calls kfree(vc->vc_screenbuf) before calling set_origin().
> > 
> > Unfortunately, in set_origin(), vc->vc_sw->con_set_origin() might access
> > vc->vc_pos when scroll is involved in order to manipulate cursor, but
> > vc->vc_pos refers already released vc->vc_screenbuf until vc->vc_pos gets
> > updated based on the result of vc->vc_sw->con_set_origin().
> > 
> > Preserving old buffer and tolerating outdated vc members until set_origin()
> > completes would be easier than preventing vc->vc_sw->con_set_origin() from
> > accessing outdated vc members.
> > 
> > [1] https://syzkaller.appspot.com/bug?idf49da2081e2ebdc65c0642c214b27fe91099db3
> > 
> > Reported-by: syzbot <syzbot+9116ecc1978ca3a12f43@syzkaller.appspotmail.com>
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > ---
> >  drivers/tty/vt/vt.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> > index 42d8c67..c9ee8e9 100644
> > --- a/drivers/tty/vt/vt.c
> > +++ b/drivers/tty/vt/vt.c
> > @@ -1196,7 +1196,7 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
> >  	unsigned int old_rows, old_row_size, first_copied_row;
> >  	unsigned int new_cols, new_rows, new_row_size, new_screen_size;
> >  	unsigned int user;
> > -	unsigned short *newscreen;
> > +	unsigned short *oldscreen, *newscreen;
> >  	struct uni_screen *new_uniscr = NULL;
> >  
> >  	WARN_CONSOLE_UNLOCKED();
> > @@ -1294,10 +1294,11 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
> >  	if (new_scr_end > new_origin)
> >  		scr_memsetw((void *)new_origin, vc->vc_video_erase_char,
> >  			    new_scr_end - new_origin);
> > -	kfree(vc->vc_screenbuf);
> > +	oldscreen = vc->vc_screenbuf;
> >  	vc->vc_screenbuf = newscreen;
> >  	vc->vc_screenbuf_size = new_screen_size;
> >  	set_origin(vc);
> > +	kfree(oldscreen);
> >  
> >  	/* do part of a reset_terminal() */
> >  	vc->vc_top = 0;

I think what you have here is fine, as cleaning up set_orgin() might be
hard to do at this point in time.

thanks,

greg k-h
