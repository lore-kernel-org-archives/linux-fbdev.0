From: syzbot <syzbot+f11cda116c57db68c227@syzkaller.appspotmail.com>
Date: Wed, 25 Dec 2019 15:26:00 +0000
Subject: Re: KASAN: use-after-free Read in fb_mode_is_equal
Message-Id: <000000000000c6e365059a88e032@google.com>
List-Id: <linux-fbdev.vger.kernel.org>
In-Reply-To: <0000000000001b2f4605991a4cc0@google.com>
References: <0000000000001b2f4605991a4cc0@google.com>
In-Reply-To: <0000000000001b2f4605991a4cc0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch, daniel.vetter@intel.com, dri-devel@lists.freedesktop.org, hdanton@sina.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, mojha@codeaurora.org, sam@ravnborg.org, shile.zhang@linux.alibaba.com, syzkaller-bugs@googlegroups.com

syzbot has bisected this bug to:

commit 13ff178ccd6d3b8074c542a911300b79c4eec255
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue May 28 09:02:53 2019 +0000

     fbcon: Call fbcon_mode_deleted/new_modelist directly

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1737c63ee00000
start commit:   46cf053e Linux 5.5-rc3
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14b7c63ee00000
console output: https://syzkaller.appspot.com/x/log.txt?x=10b7c63ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ED9d672709340e35
dashboard link: https://syzkaller.appspot.com/bug?extid=F11cda116c57db68c227
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12bf72c6e00000

Reported-by: syzbot+f11cda116c57db68c227@syzkaller.appspotmail.com
Fixes: 13ff178ccd6d ("fbcon: Call fbcon_mode_deleted/new_modelist directly")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
