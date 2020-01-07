From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 07 Jan 2020 15:47:55 +0000
Subject: Re: INFO: task hung in fb_release
Message-Id: <20200107154755.GB43062@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <00000000000082b80f059a56da1f@google.com>
 <0000000000002074ef059a5c86e2@google.com>
In-Reply-To: <0000000000002074ef059a5c86e2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: syzbot <syzbot+d130c4a0890561cfac5b@syzkaller.appspotmail.com>
Cc: david1.zhou@amd.com, linux-fbdev@vger.kernel.org, sam@ravnborg.org, b.zolnierkie@samsung.com, airlied@linux.ie, daniel.vetter@ffwll.ch, maarten.lankhorst@linux.intel.com, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, syzkaller-bugs@googlegroups.com, dri-devel@lists.freedesktop.org, alexander.deucher@amd.com, Rex.Zhu@amd.com, christian.koenig@amd.com

On Mon, Dec 23, 2019 at 02:31:01AM -0800, syzbot wrote:
> syzbot has bisected this bug to:
>=20
> commit e3933f26b657c341055443103bad331f4537b113
> Author: Rex Zhu <Rex.Zhu@amd.com>
> Date:   Tue Jan 16 10:35:15 2018 +0000
>=20
>     drm/amd/pp: Add edit/commit/show OD clock/voltage support in sysfs

Pretty sure you don't even have that driver loaded ... from the config:

# CONFIG_DRM_AMDGPU is not set

:-)

Cheers, Daniel
>=20
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12b5a799e000=
00
> start commit:   c6017471 Merge tag 'xfs-5.5-fixes-2' of git://git.kernel.=
o..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=11b5a799e000=
00
> console output: https://syzkaller.appspot.com/x/log.txt?x=16b5a799e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7F6119e2e3675a73
> dashboard link: https://syzkaller.appspot.com/bug?extid=D130c4a0890561cfa=
c5b
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169b1925e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b9623ee00000
>=20
> Reported-by: syzbot+d130c4a0890561cfac5b@syzkaller.appspotmail.com
> Fixes: e3933f26b657 ("drm/amd/pp: Add edit/commit/show OD clock/voltage
> support in sysfs")
>=20
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion

--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
