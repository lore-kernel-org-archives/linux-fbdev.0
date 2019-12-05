From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 05 Dec 2019 10:13:17 +0000
Subject: Re: KASAN: slab-out-of-bounds Read in fbcon_get_font
Message-Id: <41c082f5-5d22-d398-3bdd-3f4bf69d7ea3@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <0000000000003e640e0598e7abc3@google.com>
In-Reply-To: <0000000000003e640e0598e7abc3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: syzbot <syzbot+4455ca3b3291de891abc@syzkaller.appspotmail.com>, aryabinin@virtuozzo.com, b.zolnierkie@samsung.com, daniel.thompson@linaro.org, daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org, dvyukov@google.com, ghalat@redhat.com, gleb@kernel.org, gwshan@linux.vnet.ibm.com, hpa@zytor.com, jmorris@namei.org, kasan-dev@googlegroups.com, kvm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, maarten.lankhorst@linux.intel.com, mingo@redhat.com, mpe@ellerman.id.au, penguin-kernel@i-love.sakura.ne.jp, ruscur@russell.cc, sam@ravnborg.org, serge@hallyn.com, stewart@linux.vnet.ibm.com, syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp, tglx@linutronix.de, x86@kernel.org

On 04/12/19 22:41, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 2de50e9674fc4ca3c6174b04477f69eb26b4ee31
> Author: Russell Currey <ruscur@russell.cc>
> Date:   Mon Feb 8 04:08:20 2016 +0000
> 
>     powerpc/powernv: Remove support for p5ioc2
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=127a042ae00000
> start commit:   76bb8b05 Merge tag 'kbuild-v5.5' of
> git://git.kernel.org/p..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=117a042ae00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=167a042ae00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=dd226651cb0f364b
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=4455ca3b3291de891abc
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11181edae00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105cbb7ae00000
> 
> Reported-by: syzbot+4455ca3b3291de891abc@syzkaller.appspotmail.com
> Fixes: 2de50e9674fc ("powerpc/powernv: Remove support for p5ioc2")
> 
> For information about bisection process see:
> https://goo.gl/tpsmEJ#bisection
> 

Why is everybody being CC'd, even if the bug has nothing to do with the
person's subsystem?

Thanks,

Paolo
