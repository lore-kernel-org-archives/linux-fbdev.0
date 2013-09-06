From: David Herrmann <dh.herrmann@gmail.com>
Date: Fri, 06 Sep 2013 16:57:21 +0000
Subject: Re: [BUG] simplefb not showing any output
Message-Id: <CANq1E4R98nfbYdOGnTa+-t3asd3A5OPhMKq9WmK_SigUacffTw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAG-2HqXhLcRX-oi4JchD=m7tZpDYyePKhWvkFU1ZZPEuqJ2JqQ@mail.gmail.com>
In-Reply-To: <CAG-2HqXhLcRX-oi4JchD=m7tZpDYyePKhWvkFU1ZZPEuqJ2JqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Tom

( 2 more mails and you might get the fbdev ML right ;) )

On Fri, Sep 6, 2013 at 6:14 PM, Tom Gundersen <teg@jklm.no> wrote:
> Hi guys,
>
> I have been trying simplefb from mainline (v3.11-5058-g57d7309), with
> a couple of patches on top (one to make simplefb actually load on my
> system, posted to x86 earlier today, and one to make it show some
> output posted to this list earlier today).
>
> The driver seems to load ok, but sadly it does not give any output. If
> I boot via the gummiboot menu the screen remains black, and if I don't
> enter the gummiboot menu the screen remains grey (it is a Mac).
>
> Except for that the machine works (I can log on blindly in order to reboot).
>
> Is this a known problem? Any suggestions on where to start debugging?
> Any more info I could provide?
>
> The output given during boot is
>
> calling  simplefb_driver_init+0x0/0x14 @ 1
> simple-framebuffer simple-framebuffer.0: simplefb: framebuffer at
> 0x90000000, mapped to 0xffffc90009b00000
> simple-framebuffer simple-framebuffer.0: simplefb: format a8r8g8b8,
> mode is 1366x768x32, linelengthV32
> simple-framebuffer simple-framebuffer.0: fb0: simplefb registered!
> initcall simplefb_driver_init+0x0/0x14 returned 0 after 1072 usecs

Ok, this looks all good. Few questions:

- Is CONFIG_FB_EFI enabled? If not, please enable it and try again
(hint: CONFIG_FB_VESA doesn't hurt either)

- Could you try the _same_ kernel config but disable CONFIG_X86_SYSFB.
This will avoid creating simple-fb devices and instead load efifb
again. Does efifb work? Does efifb print the same offsets as your
simplefb printk()?

- Are you sure that it's an simplefb problem? Please make sure fbcon
is enabled (could you attach your dmesg output?). You could also try
SSH'ing into the machine and starting some fbdev program (like X with
xf86-video-fbdev installed). Or does fbcon with efifb work?

Thanks
David
