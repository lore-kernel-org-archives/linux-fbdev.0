From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 07 Jan 2020 16:01:56 +0000
Subject: Re: INFO: task hung in fb_release
Message-Id: <CACT4Y+arQyPjzHSFy1MkVF2jNPJbu262_FTL5ma9AnWkXosY1g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <00000000000082b80f059a56da1f@google.com>
 <0000000000002074ef059a5c86e2@google.com>
 <20200107154755.GB43062@phenom.ffwll.local>
In-Reply-To: <20200107154755.GB43062@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: syzbot <syzbot+d130c4a0890561cfac5b@syzkaller.appspotmail.com>, Rex.Zhu@amd.com, David Airlie <airlied@linux.ie>, alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, christian.koenig@amd.com, david1.zhou@amd.com, DRI <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Sam Ravnborg <sam@ravnborg.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>

On Tue, Jan 7, 2020 at 4:48 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Mon, Dec 23, 2019 at 02:31:01AM -0800, syzbot wrote:
> > syzbot has bisected this bug to:
> >
> > commit e3933f26b657c341055443103bad331f4537b113
> > Author: Rex Zhu <Rex.Zhu@amd.com>
> > Date:   Tue Jan 16 10:35:15 2018 +0000
> >
> >     drm/amd/pp: Add edit/commit/show OD clock/voltage support in sysfs
>
> Pretty sure you don't even have that driver loaded ... from the config:
>
> # CONFIG_DRM_AMDGPU is not set
>
> :-)

Yes, it seems the bug is very flaky and flakiness changes over time.
And this is combined with non-deterministic kernel build bug:
https://github.com/google/syzkaller/issues/1271#issuecomment-559093018
It builds the same kernel, but gets a different result, so it's like
"nope, this commit very much affects the kernel so could be the root
cause"...




> Cheers, Daniel
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12b5a799e0=
0000
> > start commit:   c6017471 Merge tag 'xfs-5.5-fixes-2' of git://git.kerne=
l.o..
> > git tree:       upstream
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=11b5a799e0=
0000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16b5a799e00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=7F6119e2e3675=
a73
> > dashboard link: https://syzkaller.appspot.com/bug?extid=D130c4a0890561c=
fac5b
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169b1925e00=
000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b9623ee00000
> >
> > Reported-by: syzbot+d130c4a0890561cfac5b@syzkaller.appspotmail.com
> > Fixes: e3933f26b657 ("drm/amd/pp: Add edit/commit/show OD clock/voltage
> > support in sysfs")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bise=
ction
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/20200107154755.GB43062%40phenom.ffwll.local.
