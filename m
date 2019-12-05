From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 05 Dec 2019 11:36:56 +0000
Subject: Re: KASAN: slab-out-of-bounds Read in fbcon_get_font
Message-Id: <CACT4Y+bUkzJAezH9Pk=c1amtzO0-r1Hcn3WmDuS+Drn-R3GAQA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <0000000000003e640e0598e7abc3@google.com>
 <41c082f5-5d22-d398-3bdd-3f4bf69d7ea3@redhat.com>
 <CACT4Y+bCHOCLYF+TW062n8+tqfK9vizaRvyjUXNPdneciq0Ahg@mail.gmail.com>
 <f4db22f2-53a3-68ed-0f85-9f4541530f5d@redhat.com>
 <397ad276-ee2b-3883-9ed4-b5b1a2f8cf67@i-love.sakura.ne.jp>
In-Reply-To: <397ad276-ee2b-3883-9ed4-b5b1a2f8cf67@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Russell Currey <ruscur@russell.cc>, DRI <dri-devel@lists.freedesktop.org>, ghalat@redhat.com, "H. Peter Anvin" <hpa@zytor.com>, Sam Ravnborg <sam@ravnborg.org>, syzbot <syzbot+4455ca3b3291de891abc@syzkaller.appspotmail.com>, Kentaro Takeda <takedakn@nttdata.co.jp>, stewart@linux.vnet.ibm.com, Daniel Thompson <daniel.thompson@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, the arch/x86 maintainers <x86@kernel.org>, James Morris <jmorris@namei.org>, kasan-dev <kasan-dev@googlegroups.com>, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, "Serge E. Hallyn" <serge@hallyn.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Gleb Natapov <gleb@kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, gwshan@linux.vnet.ibm.com, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, linux-security-module <linux-security-module@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Dec 5, 2019 at 11:41 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/12/05 19:22, Paolo Bonzini wrote:
> > Ah, and because the machine is a KVM guest, kvm_wait appears in a lot of
> > backtrace and I get to share syzkaller's joy every time. :)
> >
> > This bisect result is bogus, though Tetsuo found the bug anyway.
> > Perhaps you can exclude commits that only touch architectures other than
> > x86?
> >
>
> It would be nice if coverage functionality can extract filenames in the source
> code and supply the list of filenames as arguments for bisect operation.
>
> Also, (unrelated but) it would be nice if we can have "make yes2modconfig"
> target which converts CONFIG_FOO=y to CONFIG_FOO=m if FOO is tristate.
> syzbot is testing kernel configs close to "make allyesconfig" but I want to
> save kernel rebuild time by disabling unrelated functionality when manually
> "debug printk()ing" kernels.

I thought that maybe sed "s#=y#=m#g" && make olddefconfig will do, but
unfortunately, it turns off non-tristate configs...

$ egrep "CONFIG_MEMORY_HOTPLUG|CONFIG_TCP_CONG_DCTCP" .config
CONFIG_MEMORY_HOTPLUG=y
CONFIG_TCP_CONG_DCTCP=y
# sed -i "s/CONFIG_MEMORY_HOTPLUG=y/CONFIG_MEMORY_HOTPLUG=m/g" .config
# sed -i "s/CONFIG_TCP_CONG_DCTCP=y/CONFIG_TCP_CONG_DCTCP=m/g" .config
# egrep "CONFIG_MEMORY_HOTPLUG|CONFIG_TCP_CONG_DCTCP" .config
CONFIG_MEMORY_HOTPLUG=m
CONFIG_TCP_CONG_DCTCP=m
# make olddefconfig
# egrep "CONFIG_MEMORY_HOTPLUG|CONFIG_TCP_CONG_DCTCP" .config
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_TCP_CONG_DCTCP=m
