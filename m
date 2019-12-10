From: syzbot <syzbot+998dec6452146bd7a90c@syzkaller.appspotmail.com>
Date: Tue, 10 Dec 2019 12:59:01 +0000
Subject: Re: KASAN: slab-out-of-bounds Read in bit_putcs
Message-Id: <0000000000007598ae0599591335@google.com>
List-Id: <linux-fbdev.vger.kernel.org>
In-Reply-To: <0000000000007f075c0598f7aa38@google.com>
References: <0000000000007f075c0598f7aa38@google.com>
In-Reply-To: <0000000000007f075c0598f7aa38@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: b.zolnierkie@samsung.com, coreteam@netfilter.org, davem@davemloft.net, dri-devel@lists.freedesktop.org, gwshan@linux.vnet.ibm.com, kaber@trash.net, kadlec@blackhole.kfki.hu, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, mpe@ellerman.id.au, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pablo@netfilter.org, ruscur@russell.cc, stewart@linux.vnet.ibm.com, syzkaller-bugs@googlegroups.com

syzbot has bisected this bug to:

commit 2de50e9674fc4ca3c6174b04477f69eb26b4ee31
Author: Russell Currey <ruscur@russell.cc>
Date:   Mon Feb 8 04:08:20 2016 +0000

     powerpc/powernv: Remove support for p5ioc2

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16af042ae00000
start commit:   9455d25f Merge tag 'ntb-5.5' of git://github.com/jonmason/..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15af042ae00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11af042ae00000
kernel config:  https://syzkaller.appspot.com/x/.config?xz3b8f5088d4043a
dashboard link: https://syzkaller.appspot.com/bug?extid=998dec6452146bd7a90c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12fa5c2ee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e327f2e00000

Reported-by: syzbot+998dec6452146bd7a90c@syzkaller.appspotmail.com
Fixes: 2de50e9674fc ("powerpc/powernv: Remove support for p5ioc2")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
