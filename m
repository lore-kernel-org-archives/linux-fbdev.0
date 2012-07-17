From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Jul 2012 12:57:03 +0000
Subject: Re: [PATCH v2 11/11] MAINTAINERS: add fblog entry
Message-Id: <CAMuHMdXFfMv-DV-89nueyDJ5AvFN3AXR_6ysWOfCMDFL46s-Cg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1341784614-2797-1-git-send-email-dh.herrmann@googlemail.com>
	<1341784614-2797-12-git-send-email-dh.herrmann@googlemail.com>
	<CAMuHMdX_aC1hzKf1eRqoSsQ4oALBev8p77v7++aoB2KrkOUaEw@mail.gmail.com>
	<CANq1E4RyFpqxH=uG+dDA1=kfc3r8rCoEesZ31op9rCLjxyk6mQ@mail.gmail.com>
In-Reply-To: <CANq1E4RyFpqxH=uG+dDA1=kfc3r8rCoEesZ31op9rCLjxyk6mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, florianschandinat@gmx.de, linux-fbdev@vger.kernel.org, gregkh@linuxfoundation.org, alan@lxorguk.ukuu.org.uk, bonbons@linux-vserver.org

On Mon, Jul 9, 2012 at 8:38 PM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index ae8fe46..249b02a 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -2854,6 +2854,12 @@ F:       drivers/video/
>>>  F:     include/video/
>>>  F:     include/linux/fb.h
>>>
>>> +FRAMEBUFFER LOG DRIVER
>>> +M:     David Herrmann <dh.herrmann@googlemail.com>
>>> +L:     linux-serial@vger.kernel.org
>>
>> Why linux-serial, and not linux-fbdev?
>
> I thought fbcon was maintained on linux-serial as it is very related

It has always been maintained on linux-fbdev.

> to the vt/tty layer. If linux-fbdev is the better place, I can move
> this. I CC'ed both lists, anyway.
> I have actually no idea where it fits in best.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
