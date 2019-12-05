From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 05 Dec 2019 10:16:08 +0000
Subject: Re: KASAN: slab-out-of-bounds Read in fbcon_get_font
Message-Id: <CACT4Y+bCHOCLYF+TW062n8+tqfK9vizaRvyjUXNPdneciq0Ahg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <0000000000003e640e0598e7abc3@google.com>
 <41c082f5-5d22-d398-3bdd-3f4bf69d7ea3@redhat.com>
In-Reply-To: <41c082f5-5d22-d398-3bdd-3f4bf69d7ea3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Daniel Vetter <daniel.vetter@ffwll.ch>, "H. Peter Anvin" <hpa@zytor.com>, DRI <dri-devel@lists.freedesktop.org>, ghalat@redhat.com, Russell Currey <ruscur@russell.cc>, Sam Ravnborg <sam@ravnborg.org>, syzbot <syzbot+4455ca3b3291de891abc@syzkaller.appspotmail.com>, Kentaro Takeda <takedakn@nttdata.co.jp>, stewart@linux.vnet.ibm.com, Daniel Thompson <daniel.thompson@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, the arch/x86 maintainers <x86@kernel.org>, James Morris <jmorris@namei.org>, kasan-dev <kasan-dev@googlegroups.com>, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, "Serge E. Hallyn" <serge@hallyn.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Gleb Natapov <gleb@kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, gwshan@linux.vnet.ibm.com, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, linux-security-module <linux-security-module@vger.kernel.org>

On Thu, Dec 5, 2019 at 11:13 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 04/12/19 22:41, syzbot wrote:
> > syzbot has bisected this bug to:
> >
> > commit 2de50e9674fc4ca3c6174b04477f69eb26b4ee31
> > Author: Russell Currey <ruscur@russell.cc>
> > Date:   Mon Feb 8 04:08:20 2016 +0000
> >
> >     powerpc/powernv: Remove support for p5ioc2
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=127a042ae0=
0000
> > start commit:   76bb8b05 Merge tag 'kbuild-v5.5' of
> > git://git.kernel.org/p..
> > git tree:       upstream
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=117a042ae0=
0000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=167a042ae00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=DD226651cb0f3=
64b
> > dashboard link:
> > https://syzkaller.appspot.com/bug?extidD55ca3b3291de891abc
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11181edae00=
000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105cbb7ae00000
> >
> > Reported-by: syzbot+4455ca3b3291de891abc@syzkaller.appspotmail.com
> > Fixes: 2de50e9674fc ("powerpc/powernv: Remove support for p5ioc2")
> >
> > For information about bisection process see:
> > https://goo.gl/tpsmEJ#bisection
> >
>
> Why is everybody being CC'd, even if the bug has nothing to do with the
> person's subsystem?

The To list should be intersection of 2 groups of emails: result of
get_maintainers.pl on the file identified as culprit in the crash
message + emails extracted from the bisected to commit.
