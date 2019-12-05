From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Thu, 05 Dec 2019 14:04:55 +0000
Subject: Re: INFO: task hung in fb_open
Message-Id: <CAKMK7uF4AR_tRxt5wBKxzz6gTPJmub3A=xyuh1HjgvfYy7RCBg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <0000000000006dff110598d25a9b@google.com>
 <000000000000bcf3bc0598f5090d@google.com>
In-Reply-To: <000000000000bcf3bc0598f5090d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: syzbot <syzbot+a4ae1442ccc637162dc1@syzkaller.appspotmail.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dave Airlie <airlied@linux.ie>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Gerd Hoffmann <kraxel@redhat.com>, Ayan Kumar Halder <ayan.halder@arm.com>, Sam Ravnborg <sam@ravnborg.org>, Peter Rosin <peda@axentia.se>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Thu, Dec 5, 2019 at 2:38 PM syzbot
<syzbot+a4ae1442ccc637162dc1@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit 979c11ef39cee79d6f556091a357890962be2580
> Author: Ayan Kumar Halder <ayan.halder@arm.com>
> Date:   Tue Jul 17 17:13:46 2018 +0000
>
>      drm/sun4i: Substitute sun4i_backend_format_is_yuv() with format->is_=
yuv

Pretty sure your GCD machine is not using the sun4i driver. It's also
very far away from the code that's blowing up. bisect gone wrong?
-Daniel

>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15d2f97ee000=
00
> start commit:   596cf45c Merge branch 'akpm' (patches from Andrew)
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13d2f97ee00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x}8ab2e0e09c2a82
> dashboard link: https://syzkaller.appspot.com/bug?extid=A4ae1442ccc637162=
dc1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14273edae00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e7677ae00000
>
> Reported-by: syzbot+a4ae1442ccc637162dc1@syzkaller.appspotmail.com
> Fixes: 979c11ef39ce ("drm/sun4i: Substitute sun4i_backend_format_is_yuv()
> with format->is_yuv")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
