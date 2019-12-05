From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 05 Dec 2019 16:45:22 +0000
Subject: Re: INFO: task hung in fb_open
Message-Id: <CACT4Y+ZjQSvpZAnLkp6w8erqtraZGkXB2O84BFmcRN_Rm6fs3Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <0000000000006dff110598d25a9b@google.com>
 <000000000000bcf3bc0598f5090d@google.com>
 <CAKMK7uF4AR_tRxt5wBKxzz6gTPJmub3A=xyuh1HjgvfYy7RCBg@mail.gmail.com>
In-Reply-To: <CAKMK7uF4AR_tRxt5wBKxzz6gTPJmub3A=xyuh1HjgvfYy7RCBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dave Airlie <airlied@linux.ie>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Gerd Hoffmann <kraxel@redhat.com>, Ayan Kumar Halder <ayan.halder@arm.com>, Sam Ravnborg <sam@ravnborg.org>, Peter Rosin <peda@axentia.se>, Linux ARM <linux-arm-kernel@lists.infradead.org>, syzbot <syzbot+a4ae1442ccc637162dc1@syzkaller.appspotmail.com>

On Thu, Dec 5, 2019 at 3:05 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> On Thu, Dec 5, 2019 at 2:38 PM syzbot
> <syzbot+a4ae1442ccc637162dc1@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has bisected this bug to:
> >
> > commit 979c11ef39cee79d6f556091a357890962be2580
> > Author: Ayan Kumar Halder <ayan.halder@arm.com>
> > Date:   Tue Jul 17 17:13:46 2018 +0000
> >
> >      drm/sun4i: Substitute sun4i_backend_format_is_yuv() with format->i=
s_yuv
>
> Pretty sure your GCD machine is not using the sun4i driver. It's also
> very far away from the code that's blowing up. bisect gone wrong?
> -Daniel

Yes, this driver is not even enabled in the config.
I see 2 issues with kernel in the bisect log:
1. Unrelated machine hangs get in the way of bisection process (or
that "no output" another manifestation of this bug?).
2. Somehow this change to not compiled file changed vmlinux thus
detection of unrelated changes failed. Non-deterministic kernel builds
issue is tracked here:
https://github.com/google/syzkaller/issues/1271#issuecomment-559093018
but so far I don't have any glues/ideas.


> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15d2f97ee0=
0000
> > start commit:   596cf45c Merge branch 'akpm' (patches from Andrew)
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13d2f97ee00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x}8ab2e0e09c2a82
> > dashboard link: https://syzkaller.appspot.com/bug?extid=A4ae1442ccc6371=
62dc1
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14273edae00=
000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e7677ae00000
> >
> > Reported-by: syzbot+a4ae1442ccc637162dc1@syzkaller.appspotmail.com
> > Fixes: 979c11ef39ce ("drm/sun4i: Substitute sun4i_backend_format_is_yuv=
()
> > with format->is_yuv")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bise=
ction
>
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/CAKMK7uF4AR_tRxt5wBKxzz6gTPJmub3A%3Dxyuh1HjgvfYy7RCBg%40ma=
il.gmail.com.
