From: syzbot <syzbot+0568d05e486eee0a1ba2@syzkaller.appspotmail.com>
Date: Mon, 09 Dec 2019 15:58:01 +0000
Subject: Re: KASAN: global-out-of-bounds Read in fb_pad_aligned_buffer
Message-Id: <000000000000d1c7150599477511@google.com>
List-Id: <linux-fbdev.vger.kernel.org>
In-Reply-To: <00000000000000ffab05992442a7@google.com>
References: <00000000000000ffab05992442a7@google.com>
In-Reply-To: <00000000000000ffab05992442a7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, coreteam@netfilter.org, daniel.vetter@ffwll.ch, davem@davemloft.net, dri-devel@lists.freedesktop.org, gwshan@linux.vnet.ibm.com, kaber@trash.net, kadlec@blackhole.kfki.hu, kraxel@redhat.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, mpe@ellerman.id.au, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pablo@netfilter.org, peda@axentia.se, ruscur@russell.cc, sam@ravnborg.org, stewart@linux.vnet.ibm.com, syzkaller-bugs@googlegroups.com

syzbot has bisected this bug to:

commit 2de50e9674fc4ca3c6174b04477f69eb26b4ee31
Author: Russell Currey <ruscur@russell.cc>
Date:   Mon Feb 8 04:08:20 2016 +0000

     powerpc/powernv: Remove support for p5ioc2

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?xea0aeae00000
start commit:   9455d25f Merge tag 'ntb-5.5' of git://github.com/jonmason/..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x1a0aeae00000
console output: https://syzkaller.appspot.com/x/log.txt?xea0aeae00000
kernel config:  https://syzkaller.appspot.com/x/.config?xz3b8f5088d4043a
dashboard link: https://syzkaller.appspot.com/bug?extid68d05e486eee0a1ba2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?xddeca6e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?xdf9e41e00000

Reported-by: syzbot+0568d05e486eee0a1ba2@syzkaller.appspotmail.com
Fixes: 2de50e9674fc ("powerpc/powernv: Remove support for p5ioc2")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
