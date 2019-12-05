From: syzbot <syzbot+a4ae1442ccc637162dc1@syzkaller.appspotmail.com>
Date: Thu, 05 Dec 2019 13:38:01 +0000
Subject: Re: INFO: task hung in fb_open
Message-Id: <000000000000bcf3bc0598f5090d@google.com>
List-Id: <linux-fbdev.vger.kernel.org>
In-Reply-To: <0000000000006dff110598d25a9b@google.com>
References: <0000000000006dff110598d25a9b@google.com>
In-Reply-To: <0000000000006dff110598d25a9b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: airlied@linux.ie, ayan.halder@arm.com, b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org, kraxel@redhat.com, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com, peda@axentia.se, sam@ravnborg.org, syzkaller-bugs@googlegroups.com, ville.syrjala@linux.intel.com, wens@csie.org

syzbot has bisected this bug to:

commit 979c11ef39cee79d6f556091a357890962be2580
Author: Ayan Kumar Halder <ayan.halder@arm.com>
Date:   Tue Jul 17 17:13:46 2018 +0000

     drm/sun4i: Substitute sun4i_backend_format_is_yuv() with format->is_yuv

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15d2f97ee00000
start commit:   596cf45c Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13d2f97ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x}8ab2e0e09c2a82
dashboard link: https://syzkaller.appspot.com/bug?extid=A4ae1442ccc637162dc1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14273edae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e7677ae00000

Reported-by: syzbot+a4ae1442ccc637162dc1@syzkaller.appspotmail.com
Fixes: 979c11ef39ce ("drm/sun4i: Substitute sun4i_backend_format_is_yuv()  =

with format->is_yuv")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
