From: syzbot <syzbot+d130c4a0890561cfac5b@syzkaller.appspotmail.com>
Date: Mon, 23 Dec 2019 10:31:01 +0000
Subject: Re: INFO: task hung in fb_release
Message-Id: <0000000000002074ef059a5c86e2@google.com>
List-Id: <linux-fbdev.vger.kernel.org>
In-Reply-To: <00000000000082b80f059a56da1f@google.com>
References: <00000000000082b80f059a56da1f@google.com>
In-Reply-To: <00000000000082b80f059a56da1f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Rex.Zhu@amd.com, airlied@linux.ie, alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, b.zolnierkie@samsung.com, christian.koenig@amd.com, daniel.vetter@ffwll.ch, david1.zhou@amd.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, rex.zhu@amd.com, sam@ravnborg.org, syzkaller-bugs@googlegroups.com

syzbot has bisected this bug to:

commit e3933f26b657c341055443103bad331f4537b113
Author: Rex Zhu <Rex.Zhu@amd.com>
Date:   Tue Jan 16 10:35:15 2018 +0000

     drm/amd/pp: Add edit/commit/show OD clock/voltage support in sysfs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12b5a799e00000
start commit:   c6017471 Merge tag 'xfs-5.5-fixes-2' of git://git.kernel.o..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11b5a799e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=16b5a799e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7F6119e2e3675a73
dashboard link: https://syzkaller.appspot.com/bug?extid=D130c4a0890561cfac5b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169b1925e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b9623ee00000

Reported-by: syzbot+d130c4a0890561cfac5b@syzkaller.appspotmail.com
Fixes: e3933f26b657 ("drm/amd/pp: Add edit/commit/show OD clock/voltage =20
support in sysfs")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
