From: Tom Gundersen <teg@jklm.no>
Date: Fri, 06 Sep 2013 17:12:51 +0000
Subject: Re: [BUG] simplefb not showing any output
Message-Id: <CAG-2HqXbjMFRtRWvB4awGO2f_iJwAg6ZKHga7dcYuQPyO9b=YA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAG-2HqXhLcRX-oi4JchD=m7tZpDYyePKhWvkFU1ZZPEuqJ2JqQ@mail.gmail.com>
In-Reply-To: <CAG-2HqXhLcRX-oi4JchD=m7tZpDYyePKhWvkFU1ZZPEuqJ2JqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, Sep 6, 2013 at 6:57 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
> ( 2 more mails and you might get the fbdev ML right ;) )

Modern technology...

> - Is CONFIG_FB_EFI enabled? If not, please enable it and try again
> (hint: CONFIG_FB_VESA doesn't hurt either)

FB_EFI was enabled, FB_VESA was not, but I'll enable it. Out of
interest, how could this affect the situation? If I understand
correctly these drivers won't be loaded as long as simple-framebuffer
is created, or am I missing something?

> - Could you try the _same_ kernel config but disable CONFIG_X86_SYSFB.
> This will avoid creating simple-fb devices and instead load efifb
> again. Does efifb work? Does efifb print the same offsets as your
> simplefb printk()?

Yeah, efifb works fine, I'll double-check everything and note down the offsets.

> - Are you sure that it's an simplefb problem? Please make sure fbcon
> is enabled (could you attach your dmesg output?). You could also try
> SSH'ing into the machine and starting some fbdev program (like X with
> xf86-video-fbdev installed). Or does fbcon with efifb work?

fbcon with efifb works fine (so I guess trying X is not necessary?).

Cheers,

Tom
