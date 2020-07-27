From: syzbot <syzbot+13013adc4a234406c29e@syzkaller.appspotmail.com>
Date: Mon, 27 Jul 2020 16:45:08 +0000
Subject: Re: divide error in fbcon_switch
Message-Id: <0000000000009c18f005ab6f0bc0@google.com>
List-Id: <linux-fbdev.vger.kernel.org>
In-Reply-To: <00000000000072cb4c0598d25a69@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: b.zolnierkie@samsung.com, daniel.thompson@linaro.org, daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org, ghalat@redhat.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, penguin-kernel@I-love.SAKURA.ne.jp, penguin-kernel@i-love.sakura.ne.jp, sam@ravnborg.org, syzkaller-bugs@googlegroups.com

syzbot suspects this issue was fixed by commit:

commit ce684552a266cb1c7cc2f7e623f38567adec6653
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Sun Jul 12 11:10:12 2020 +0000

    vt: Reject zero-sized screen buffer size.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=155549c4900000
start commit:   76bb8b05 Merge tag 'kbuild-v5.5' of git://git.kernel.org/p..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=DD226651cb0f364b
dashboard link: https://syzkaller.appspot.com/bug?extid=13013adc4a234406c29e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d69aeae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13fdcc2ae00000

If the result looks correct, please mark the issue as fixed by replying wit=
h:

#syz fix: vt: Reject zero-sized screen buffer size.

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
