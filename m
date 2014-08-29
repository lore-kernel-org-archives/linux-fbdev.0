From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Date: Fri, 29 Aug 2014 01:40:48 +0000
Subject: Re: EARLY_PRINTK equivalent for framebuffers.
Message-Id: <CAKON4OzS+Lkhc_=DcYT5es+vy2weDe11pT15069rNogD9O1yzA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAKON4Owx5wQS29qj9Ks2CzP-Q9Kos6=6MbPRxS+4n9WkdbWegQ@mail.gmail.com>
In-Reply-To: <CAKON4Owx5wQS29qj9Ks2CzP-Q9Kos6=6MbPRxS+4n9WkdbWegQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Aug 28, 2014 at 9:36 PM, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Thu, Aug 28, 2014 at 12:19 PM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
>> Is there some existing way to do early printk type output to a
>> framebuffer that has been set up by the bootloader?  early printk is
>> before any device drivers are loaded.
>>
>> If not, what would it take to create a way to do this? Something along
>> the lines of build in the fbdev library and give it an address plus
>> x/y layout of the buffer. Assume that everything else is set up and
>> anything written to the buffer will appear on the display. Then hook
>> into where the kernel does early printk on uarts and add in support
>> for this buffer. The core fbdev library implements scrolling and
>> graphical characters.
>
> simplefb does something like this (implement a console on top of a
> framebuffer set up by the bootloader), but I don't think you can use
> it for earlyprintk. It would be a very interesting option though (and

simplefb is a device driver so it doesn't process the early output.
This would need to be some custom code that gets the framebuffer
address  and x/y setup very early in the boot process. I'm fairly sure
nothing like it current exists.


> even better if it could be used by the kernel decompression code), but
> I suspect this is more involved than good old UART as you need to
> manage fonts, pixel format, screen geometry, etc.
>
> OTOH it would be very useful for some retail devices that come without
> an accessible serial line, but have a framebuffer set up by the
> bootloader.
>
> Alex.



-- 
Jon Smirl
jonsmirl@gmail.com
