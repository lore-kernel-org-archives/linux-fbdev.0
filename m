From: Anca Emanuel <anca.emanuel@gmail.com>
Date: Wed, 23 Feb 2011 17:16:05 +0000
Subject: Re: Linux 2.6.38-rc6
Message-Id: <AANLkTinxHVDwSCouTaZEvR3yTJnSPAas9z6JauGDdS7=@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTi=TTZ57d1wUz1uH3R6igN8O77iDvSLMW=t86g9V@mail.gmail.com>
	<20110222140349.GA20708@kryptos.osrc.amd.com>
	<AANLkTikESHHfjBqoLFOno6qQz-NXEAo-wBY5JEeAW61N@mail.gmail.com>
	<AANLkTinh4pF7iaUGMcv_9gPy+VBD5POsTHbF_2zPJ17r@mail.gmail.com>
	<AANLkTi=Ys4mb4pc28cH4NMdtMgb2KewJbkXEGJmEP4J0@mail.gmail.com>
In-Reply-To: <AANLkTi=Ys4mb4pc28cH4NMdtMgb2KewJbkXEGJmEP4J0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Airlie <airlied@redhat.com>, linux-fbdev@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>, dri-devel@lists.freedesktop.org, Borislav Petkov <bp@amd64.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Feb 23, 2011 at 6:32 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Feb 22, 2011 at 9:42 PM, Anca Emanuel <anca.emanuel@gmail.com> wr=
ote:
>> General protection fault:
>> http://i.imgur.com/TBJ6y.jpg
>>
>> dmesg: http://pastebin.com/qD8pR8QH
>> config: http://pastebin.com/XEurtHWi
>
> That's drivers/video/fbmem.c: fb_release(), and the "Code:"
> disassembly shows that it is
>
> =A01b: =A0 e8 f7 c0 29 00 =A0 =A0 =A0 =A0 =A0callq =A0xyz
> =A020: =A0 48 8b 93 b8 03 00 00 =A0 =A0mov =A0 =A00x3b8(%rbx),%rdx
> =A027:* =A048 8b 42 10 =A0 =A0 =A0 =A0 =A0 =A0 mov =A0 =A00x10(%rdx),%rax=
 =A0 =A0 <-- trapping instruction
>
> which corresponds to
>
> =A0 =A0 =A0 =A0mutex_lock(&info->lock);
> =A0 =A0 =A0 =A0if (info->fbops->fb_release)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0info->fbops->fb_release(info,1);
>
> so it looks like 'info->fbops' is invalid. It's in %rdx, and is
> 0x00d000ae00b500c2, which is definitely not a valid pointer. Looks
> like some bad corruption (looks like a sequence of 16-bit numbers, but
> it could be anything).
>
> Looks like nouveafb took over from vesafb. Did you do anything special
> to trigger this?

No. Just boot the system.

>
> Also, you do seem to have some extra patches (yama at the least). Anythin=
g else?

I used git clone, nothing else.
First time 2.6.38-rc6 was working.
After an update from ubuntu I get that error at boot.

The dmesg is from Ubuntu 11.04 with their kernel and is working fine.

>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Linus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
