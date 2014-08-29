From: Alexandre Courbot <gnurou@gmail.com>
Date: Fri, 29 Aug 2014 01:54:18 +0000
Subject: Re: EARLY_PRINTK equivalent for framebuffers.
Message-Id: <CAAVeFuKSiSA_sGGYY0-i96v6e1bSvdwkvvK8P--0M-9sA7eLUA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAKON4Owx5wQS29qj9Ks2CzP-Q9Kos6=6MbPRxS+4n9WkdbWegQ@mail.gmail.com>
In-Reply-To: <CAKON4Owx5wQS29qj9Ks2CzP-Q9Kos6=6MbPRxS+4n9WkdbWegQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Aug 28, 2014 at 6:40 PM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
> On Thu, Aug 28, 2014 at 9:36 PM, Alexandre Courbot <gnurou@gmail.com> wrote:
>> On Thu, Aug 28, 2014 at 12:19 PM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
>>> Is there some existing way to do early printk type output to a
>>> framebuffer that has been set up by the bootloader?  early printk is
>>> before any device drivers are loaded.
>>>
>>> If not, what would it take to create a way to do this? Something along
>>> the lines of build in the fbdev library and give it an address plus
>>> x/y layout of the buffer. Assume that everything else is set up and
>>> anything written to the buffer will appear on the display. Then hook
>>> into where the kernel does early printk on uarts and add in support
>>> for this buffer. The core fbdev library implements scrolling and
>>> graphical characters.
>>
>> simplefb does something like this (implement a console on top of a
>> framebuffer set up by the bootloader), but I don't think you can use
>> it for earlyprintk. It would be a very interesting option though (and
>
> simplefb is a device driver so it doesn't process the early output.
> This would need to be some custom code that gets the framebuffer
> address  and x/y setup very early in the boot process. I'm fairly sure
> nothing like it current exists.

You're right AFAICT. And although simplefb shares part of of idea it
also doesn't operate at the required level. Also contrary to what I
said it also does not implement a console, but just a framebuffer
device on top of which you need some more logic before you can think
about displaying strings.

It seems like what would be needed is an early platform driver that
would operate like earlyprintk, with some extra parameters to specify
the FB's location and properties. Such a driver would be very
simplistic though, and I don't think we could have things like a
smooth transition with the "real" console, although I guess that's not
the goal here.
