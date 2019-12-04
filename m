From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Date: Wed, 04 Dec 2019 20:49:42 +0000
Subject: Re: KASAN: slab-out-of-bounds Read in fbcon_get_font
Message-Id: <6632ddb6-37bf-dc42-e355-2443c17e6da0@virtuozzo.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <0000000000002cfc3a0598d42b70@google.com>
 <CAKMK7uFAfw4M6B8WaHx6FBkYDmUBTQ6t3D8RE5BbMt=_5vyp9A@mail.gmail.com>
 <CACT4Y+aV9vzJ6gs9r2RAQP+dQ_vkOc5H6hWu-prF1ECruAE_5w@mail.gmail.com>
In-Reply-To: <CACT4Y+aV9vzJ6gs9r2RAQP+dQ_vkOc5H6hWu-prF1ECruAE_5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Dmitry Vyukov <dvyukov@google.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, kasan-dev <kasan-dev@googlegroups.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, syzbot <syzbot+4455ca3b3291de891abc@syzkaller.appspotmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, James Morris <jmorris@namei.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, linux-security-module <linux-security-module@vger.kernel.org>, ghalat@redhat.com, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, Sam Ravnborg <sam@ravnborg.org>, "Serge E. Hallyn" <serge@hallyn.com>



On 12/4/19 9:33 AM, Dmitry Vyukov wrote:
> On Tue, Dec 3, 2019 at 11:37 PM Daniel Vetter <daniel.vetter@ffwll.ch> wr=
ote:
>>
>> On Tue, Dec 3, 2019 at 11:25 PM syzbot
>> <syzbot+4455ca3b3291de891abc@syzkaller.appspotmail.com> wrote:
>>>
>>> Hello,
>>>
>>> syzbot found the following crash on:
>>>
>>> HEAD commit:    76bb8b05 Merge tag 'kbuild-v5.5' of git://git.kernel.or=
g/p..
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=10bfe282e00000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=DD226651cb0f3=
64b
>>> dashboard link: https://syzkaller.appspot.com/bug?extidD55ca3b3291de891=
abc
>>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11181edae00=
000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105cbb7ae00000
>>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the comm=
it:
>>> Reported-by: syzbot+4455ca3b3291de891abc@syzkaller.appspotmail.com
>>>
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> BUG: KASAN: slab-out-of-bounds in memcpy include/linux/string.h:380 [in=
line]
>>> BUG: KASAN: slab-out-of-bounds in fbcon_get_font+0x2b2/0x5e0
>>> drivers/video/fbdev/core/fbcon.c:2465
>>> Read of size 16 at addr ffff888094b0aa10 by task syz-executor414/9999
>>
>> So fbcon allocates some memory, security/tomoyo goes around and frees
>> it, fbcon goes boom because the memory is gone. I'm kinda leaning
>> towards "not an fbcon bug". Adding relevant security folks and mailing
>> lists.
>>
>> But from a very quick look in tomoyo it loosk more like "machine on
>> fire, random corruption all over". No idea what's going on here.
>=20
> Hi Daniel,
>=20
> This is an out-of-bounds access, not use-after-free.
> I don't know why we print the free stack at all (maybe +Andrey knows),
> but that's what KASAN did from day one. I filed
> https://bugzilla.kernel.org/show_bug.cgi?id=198425 which I think is a
> good idea, I will add your confusion as a data point :)

Because we have that information (free stack) and it usually better to prov=
ide
all the information we have rather than hide it. You never known what infor=
mation
might be needed to fix the bug.
Free memory might be reused and what we report as OOB might be an UAF and f=
ree stack
could be useful in such case.
