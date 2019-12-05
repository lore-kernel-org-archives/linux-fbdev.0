From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 05 Dec 2019 10:53:02 +0000
Subject: Re: KASAN: slab-out-of-bounds Read in fbcon_get_font
Message-Id: <e03140c6-8ff5-9abb-1af6-17a5f68d1829@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <0000000000003e640e0598e7abc3@google.com>
 <41c082f5-5d22-d398-3bdd-3f4bf69d7ea3@redhat.com>
 <CACT4Y+bCHOCLYF+TW062n8+tqfK9vizaRvyjUXNPdneciq0Ahg@mail.gmail.com>
 <f4db22f2-53a3-68ed-0f85-9f4541530f5d@redhat.com>
 <CACT4Y+ZHCmTu4tdfP+iCswU3r6+_NBM9M-pAZEypVSZ9DEq3TQ@mail.gmail.com>
In-Reply-To: <CACT4Y+ZHCmTu4tdfP+iCswU3r6+_NBM9M-pAZEypVSZ9DEq3TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Daniel Vetter <daniel.vetter@ffwll.ch>, "H. Peter Anvin" <hpa@zytor.com>, DRI <dri-devel@lists.freedesktop.org>, ghalat@redhat.com, Russell Currey <ruscur@russell.cc>, Sam Ravnborg <sam@ravnborg.org>, syzbot <syzbot+4455ca3b3291de891abc@syzkaller.appspotmail.com>, Kentaro Takeda <takedakn@nttdata.co.jp>, stewart@linux.vnet.ibm.com, Daniel Thompson <daniel.thompson@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, the arch/x86 maintainers <x86@kernel.org>, James Morris <jmorris@namei.org>, kasan-dev <kasan-dev@googlegroups.com>, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, "Serge E. Hallyn" <serge@hallyn.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Gleb Natapov <gleb@kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, gwshan@linux.vnet.ibm.com, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, linux-security-module <linux-security-module@vger.kernel.org>

On 05/12/19 11:31, Dmitry Vyukov wrote:
>> Ah, and because the machine is a KVM guest, kvm_wait appears in a lot of
>> backtrace and I get to share syzkaller's joy every time. :)
> I don't see any mention of "kvm" in the crash report.

It's there in the stack trace, not sure if this is what triggered my Cc:

 [<ffffffff810c7c3a>] kvm_wait+0xca/0xe0 arch/x86/kernel/kvm.c:612

Paolo
