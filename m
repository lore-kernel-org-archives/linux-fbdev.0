From: Tom Gundersen <teg@jklm.no>
Date: Fri, 06 Sep 2013 17:46:17 +0000
Subject: Re: [BUG] simplefb not showing any output
Message-Id: <CAG-2HqWmmhZB51zFK=NuSbsJieRzmhwaaVievWa+bziHBhPWPQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAG-2HqXhLcRX-oi4JchD=m7tZpDYyePKhWvkFU1ZZPEuqJ2JqQ@mail.gmail.com>
In-Reply-To: <CAG-2HqXhLcRX-oi4JchD=m7tZpDYyePKhWvkFU1ZZPEuqJ2JqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Fri, Sep 6, 2013 at 7:19 PM, David Herrmann <dh.herrmann@gmail.com> wrot=
e:
> On Fri, Sep 6, 2013 at 7:12 PM, Tom Gundersen <teg@jklm.no> wrote:
>> On Fri, Sep 6, 2013 at 6:57 PM, David Herrmann <dh.herrmann@gmail.com> w=
rote:
>>> ( 2 more mails and you might get the fbdev ML right ;) )
>>
>> Modern technology...
>>
>>> - Is CONFIG_FB_EFI enabled? If not, please enable it and try again
>>> (hint: CONFIG_FB_VESA doesn't hurt either)
>>
>> FB_EFI was enabled, FB_VESA was not, but I'll enable it. Out of
>> interest, how could this affect the situation? If I understand
>> correctly these drivers won't be loaded as long as simple-framebuffer
>> is created, or am I missing something?
>
> In case you disable X86_SYSFB vesafb might still be used (I wasn't
> sure you used efifb). And there might be some nasty Kconfig-select
> logic that I overlooked (like FB_BOOT_VESA_SUPPORT).. Just to be sure.

Ok. All is now enabled and the behavior is the same.

>>> - Could you try the _same_ kernel config but disable CONFIG_X86_SYSFB.
>>> This will avoid creating simple-fb devices and instead load efifb
>>> again. Does efifb work? Does efifb print the same offsets as your
>>> simplefb printk()?
>>
>> Yeah, efifb works fine, I'll double-check everything and note down the o=
ffsets.
>
> Just to be clear, efifb still with the new x86-sysfb infrastructure
> works? Because I moved some efifb quirks from efifb.c to
> x86/kernel/sysfb_efi.c. So even with CONFIG_X86_SYSFB=3Dn the situation
> is still different from pre-3.12.

Turns out I must have messed up my initial testing (maybe I only
tested with an old kernel on efifb). With the current kernel both
X86_SYSFB=3Dy (i.e., simplefb) and X86_SYSFB=3Dn (i.e., efifb) are broken.
Only when I log in and "modprobe i915" do I get an fbcon, before that
the screen is black.

For the record here is the relevant dmesg outputs (they appear to be ok):

efifb: probing for efifb
efifb: framebuffer at 0x90000000, mapped to 0xffffc90009b00000, using
4224k, total 4224k
efifb: mode is 1366x768x32, linelengthV32, pages=3D1
efifb: scrolling: redraw
efifb: Truecolor: size=3D8:8:8:8, shift$:16:8:0

simple-framebuffer simple-framebuffer.0: framebuffer at 0x90000000,
mapped to 0xffffc90009b00000
simple-framebuffer simple-framebuffer.0: format=A8r8g8b8,
mode=1366x768x32, linelengthV32
simple-framebuffer simple-framebuffer.0: fb0: simplefb registered!

>>> - Are you sure that it's an simplefb problem? Please make sure fbcon
>>> is enabled (could you attach your dmesg output?). You could also try
>>> SSH'ing into the machine and starting some fbdev program (like X with
>>> xf86-video-fbdev installed). Or does fbcon with efifb work?
>>
>> fbcon with efifb works fine (so I guess trying X is not necessary?).
>
> Yeah, if fbcon+efifb works, no need to test X.

Scratch this, I'll have to do some more testing. I'll get back to you.

-t
