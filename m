From: David Herrmann <dh.herrmann@gmail.com>
Date: Fri, 06 Sep 2013 17:19:33 +0000
Subject: Re: [BUG] simplefb not showing any output
Message-Id: <CANq1E4S3Ja5AKGFX+VyLL=n-e5D0UcQOVqJ6ZwuwSpqSZhSkDA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAG-2HqXhLcRX-oi4JchD=m7tZpDYyePKhWvkFU1ZZPEuqJ2JqQ@mail.gmail.com>
In-Reply-To: <CAG-2HqXhLcRX-oi4JchD=m7tZpDYyePKhWvkFU1ZZPEuqJ2JqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi

On Fri, Sep 6, 2013 at 7:12 PM, Tom Gundersen <teg@jklm.no> wrote:
> On Fri, Sep 6, 2013 at 6:57 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
>> ( 2 more mails and you might get the fbdev ML right ;) )
>
> Modern technology...
>
>> - Is CONFIG_FB_EFI enabled? If not, please enable it and try again
>> (hint: CONFIG_FB_VESA doesn't hurt either)
>
> FB_EFI was enabled, FB_VESA was not, but I'll enable it. Out of
> interest, how could this affect the situation? If I understand
> correctly these drivers won't be loaded as long as simple-framebuffer
> is created, or am I missing something?

In case you disable X86_SYSFB vesafb might still be used (I wasn't
sure you used efifb). And there might be some nasty Kconfig-select
logic that I overlooked (like FB_BOOT_VESA_SUPPORT).. Just to be sure.

>> - Could you try the _same_ kernel config but disable CONFIG_X86_SYSFB.
>> This will avoid creating simple-fb devices and instead load efifb
>> again. Does efifb work? Does efifb print the same offsets as your
>> simplefb printk()?
>
> Yeah, efifb works fine, I'll double-check everything and note down the offsets.

Just to be clear, efifb still with the new x86-sysfb infrastructure
works? Because I moved some efifb quirks from efifb.c to
x86/kernel/sysfb_efi.c. So even with CONFIG_X86_SYSFB=n the situation
is still different from pre-3.12.

>> - Are you sure that it's an simplefb problem? Please make sure fbcon
>> is enabled (could you attach your dmesg output?). You could also try
>> SSH'ing into the machine and starting some fbdev program (like X with
>> xf86-video-fbdev installed). Or does fbcon with efifb work?
>
> fbcon with efifb works fine (so I guess trying X is not necessary?).

Yeah, if fbcon+efifb works, no need to test X.

Regards
David
