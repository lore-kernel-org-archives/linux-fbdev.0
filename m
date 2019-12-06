From: syzbot <syzbot+cf43fb300aa142fb024b@syzkaller.appspotmail.com>
Date: Fri, 06 Dec 2019 16:34:01 +0000
Subject: Re: KASAN: use-after-free Read in soft_cursor
Message-Id: <000000000000fdd04105990b9c93@google.com>
List-Id: <linux-fbdev.vger.kernel.org>
In-Reply-To: <000000000000e1d639059908223b@google.com>
References: <000000000000e1d639059908223b@google.com>
In-Reply-To: <000000000000e1d639059908223b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: b.zolnierkie@samsung.com, coreteam@netfilter.org, davem@davemloft.net, dri-devel@lists.freedesktop.org, gwshan@linux.vnet.ibm.com, kaber@trash.net, kadlec@blackhole.kfki.hu, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, mpe@ellerman.id.au, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pablo@netfilter.org, ruscur@russell.cc, stewart@linux.vnet.ibm.com, syzkaller-bugs@googlegroups.com

syzbot has bisected this bug to:

commit 2de50e9674fc4ca3c6174b04477f69eb26b4ee31
Author: Russell Currey <ruscur@russell.cc>
Date:   Mon Feb 8 04:08:20 2016 +0000

     powerpc/powernv: Remove support for p5ioc2

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1512d1bce00000
start commit:   b0d4beaa Merge branch 'next.autofs' of git://git.kernel.or..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1712d1bce00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1312d1bce00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=F07a23020fd7d21a
dashboard link: https://syzkaller.appspot.com/bug?extid=CF43fb300aa142fb024b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1745a90ee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1361042ae00000

Reported-by: syzbot+cf43fb300aa142fb024b@syzkaller.appspotmail.com
Fixes: 2de50e9674fc ("powerpc/powernv: Remove support for p5ioc2")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
