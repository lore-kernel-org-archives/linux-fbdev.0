From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 05 Dec 2019 11:29:20 +0000
Subject: Re: KASAN: slab-out-of-bounds Read in fbcon_get_font
Message-Id: <bf93410c-7e59-a679-c00d-5333a9879128@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <0000000000003e640e0598e7abc3@google.com>
 <41c082f5-5d22-d398-3bdd-3f4bf69d7ea3@redhat.com>
 <CACT4Y+bCHOCLYF+TW062n8+tqfK9vizaRvyjUXNPdneciq0Ahg@mail.gmail.com>
 <f4db22f2-53a3-68ed-0f85-9f4541530f5d@redhat.com>
 <CACT4Y+ZHCmTu4tdfP+iCswU3r6+_NBM9M-pAZEypVSZ9DEq3TQ@mail.gmail.com>
 <e03140c6-8ff5-9abb-1af6-17a5f68d1829@redhat.com>
 <CACT4Y+YopHoCFDRHCE6brnWfHb5YUsTJS1Mc+58GgO8CDEcgHQ@mail.gmail.com>
In-Reply-To: <CACT4Y+YopHoCFDRHCE6brnWfHb5YUsTJS1Mc+58GgO8CDEcgHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Daniel Vetter <daniel.vetter@ffwll.ch>, "H. Peter Anvin" <hpa@zytor.com>, DRI <dri-devel@lists.freedesktop.org>, ghalat@redhat.com, Russell Currey <ruscur@russell.cc>, Sam Ravnborg <sam@ravnborg.org>, syzbot <syzbot+4455ca3b3291de891abc@syzkaller.appspotmail.com>, Kentaro Takeda <takedakn@nttdata.co.jp>, stewart@linux.vnet.ibm.com, Daniel Thompson <daniel.thompson@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, the arch/x86 maintainers <x86@kernel.org>, James Morris <jmorris@namei.org>, kasan-dev <kasan-dev@googlegroups.com>, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, "Serge E. Hallyn" <serge@hallyn.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Gleb Natapov <gleb@kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, gwshan@linux.vnet.ibm.com, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, linux-security-module <linux-security-module@vger.kernel.org>

On 05/12/19 12:27, Dmitry Vyukov wrote:
> Oh, you mean the final bisection crash. Indeed it contains a kvm frame
> and it turns out to be a bug in syzkaller code that indeed
> misattributed it to kvm instead of netfilter.
> Should be fixed now, you may read the commit message for details:
> https://github.com/google/syzkaller/commit/4fb74474cf0af2126be3a8989d770c3947ae9478
> 
> Overall this "making sense out of kernel output" task is the ultimate
> insanity, you may skim through this file to get a taste of amount of
> hardcoding and special corner cases that need to be handled:
> https://github.com/google/syzkaller/blob/master/pkg/report/linux.go
> And this is never done, such "exception from exception corner case"
> things pop up every week. There is always something to shuffle and
> tune. It only keeps functioning due to 500+ test cases for all
> possible insane kernel outputs:
> https://github.com/google/syzkaller/tree/master/pkg/report/testdata/linux/report
> https://github.com/google/syzkaller/tree/master/pkg/report/testdata/linux/guilty
> 
> So thanks for persisting and questioning! We are getting better with
> each new test.

Thanks to you!  I "complain" because I know you're so responsive. :)

Paolo
