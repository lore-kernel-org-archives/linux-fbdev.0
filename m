From: Dmitry Vyukov <dvyukov@google.com>
Date: Sat, 07 Dec 2019 07:22:55 +0000
Subject: Re: KASAN: use-after-free Read in soft_cursor
Message-Id: <CACT4Y+ahbULUDLhmNxqEffU1BbAiMuZ7Da6DurdX4XwUftROmg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000000000000e1d639059908223b@google.com>
 <000000000000fdd04105990b9c93@google.com>
In-Reply-To: <000000000000fdd04105990b9c93@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: syzbot <syzbot+cf43fb300aa142fb024b@syzkaller.appspotmail.com>
Cc: stewart@linux.vnet.ibm.com, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, LKML <linux-kernel@vger.kernel.org>, Russell Currey <ruscur@russell.cc>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, gwshan@linux.vnet.ibm.com, DRI <dri-devel@lists.freedesktop.org>, David Miller <davem@davemloft.net>, coreteam@netfilter.org, NetFilter <netfilter-devel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, netdev <netdev@vger.kernel.org>, Patrick McHardy <kaber@trash.net>, Pablo Neira Ayuso <pablo@netfilter.org>

On Fri, Dec 6, 2019 at 5:34 PM syzbot
<syzbot+cf43fb300aa142fb024b@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit 2de50e9674fc4ca3c6174b04477f69eb26b4ee31
> Author: Russell Currey <ruscur@russell.cc>
> Date:   Mon Feb 8 04:08:20 2016 +0000
>
>      powerpc/powernv: Remove support for p5ioc2

Another weird one, I must be missing something obvious about how git
bisect works... I keep adding these to:
https://github.com/google/syzkaller/issues/1527

> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1512d1bce000=
00
> start commit:   b0d4beaa Merge branch 'next.autofs' of git://git.kernel.o=
r..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=1712d1bce000=
00
> console output: https://syzkaller.appspot.com/x/log.txt?x=1312d1bce00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=F07a23020fd7d21a
> dashboard link: https://syzkaller.appspot.com/bug?extid=CF43fb300aa142fb0=
24b
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1745a90ee00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1361042ae00000
>
> Reported-by: syzbot+cf43fb300aa142fb024b@syzkaller.appspotmail.com
> Fixes: 2de50e9674fc ("powerpc/powernv: Remove support for p5ioc2")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/000000000000fdd04105990b9c93%40google.com.
