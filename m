From: Alexander Holler <holler@ahsoftware.de>
Date: Fri, 04 Jan 2013 13:36:09 +0000
Subject: Re: [PATCH] fb: Rework locking to fix lock ordering on takeover
Message-Id: <50E6DAC9.802@ahsoftware.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20121116192606.11799.35711.stgit@localhost.localdomain> <CA+5PVA6nKNZY70UoeDUhQo9Rj4Ck+k+XTHL++gwErgzqAdy6Aw@mail.gmail.com> <20121121125310.00625f55@pyramind.ukuu.org.uk> <CA+5PVA5iQwYOcoSYtLOoRBHaTNJANdv+X-C78474n3SzZg_m9w@mail.gmail.com> <CA+1xoqe0G4rha5bDcoQQUcACYbQ8BCO7AE_JE8z5VjJLeNUdyA@mail.gmail.com> <CAM_iQpWLgnxQR+oYD+Dnh9NprR1-QLjXa6T+dtHUs3A-_N2wmQ@mail.gmail.com> <CA+1xoqf0d5ckDZ3o1-Y+qd61nvVA7EECeH20U+WjDpNVb4E=pw@mail.gmail.com> <20121227045301.GB17472@x1.alien8.de> <20121228115022.GA28009@S2101-09.ap.freescale.net> <20121228124026.GB12918@x1.alien8.de> <50E6D01D.6040304@ahsoftware.de> <20130104132557.70e0c527@pyramind.ukuu.org.uk>
In-Reply-To: <20130104132557.70e0c527@pyramind.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Borislav Petkov <bp@alien8.de>, Shawn Guo <shawn.guo@linaro.org>, Sasha Levin <levinsasha928@gmail.com>, Cong Wang <xiyou.wangcong@gmail.com>, Josh Boyer <jwboyer@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Florian Tobias Schandinat <florianSchandinat@gmx.de>, Linus Torvalds <torvalds@linux-foundation.org>, linux-fbdev@vger.kernel.org, Bernie Thompson <bernie@plugable.com>, Steve Glendinning <steve.glendinning@shawell.net>, Dave Airlie <airlied@redhat.com>

Am 04.01.2013 14:25, schrieb Alan Cox:
> On Fri, 04 Jan 2013 13:50:37 +0100
> Alexander Holler <holler@ahsoftware.de> wrote:
>
>> Am 28.12.2012 13:40, schrieb Borislav Petkov:
>>> On Fri, Dec 28, 2012 at 07:50:27PM +0800, Shawn Guo wrote:
>>>> +1
>>>>
>>>> http://thread.gmane.org/gmane.linux.kernel/1413953/focus15070
>>>
>>> Cool, works fine here too. Is Linus on CC? (/me checks.. ) Yes he is,
>>> good.
>>>
>>> Linus, Alan's patch works at least in 2 cases, you might consider
>>> picking it up directly since the fb maintainer is absent, reportedly.
>>
>>
>> Btw. I think all the usb-fb's (udlfb, smscufx and udl) are broken, at
>> least on ARM(v5). When I have linked in udlfb the following happens on
>> boot (with an attached USB-LCD and with or without the "Rework locking
>> patch):
>
> They are broken if used as the system console (has been known for years).

Ah. Thats why I didn't see it before. Usually I've used the serial as 
system console. So thats why it worked before. ;)

> Perhaps your x86 test has the system console still on another device ?

Exactly thats the case. Thanks for pointing it out.

> For the udl layer it shouldn't matter as Dave Airlie wrote a DRM driver
> for udl which obsoletes the old fb layer one and works much better
> (although the error handling is still totally broken and leaks like a
> sieve if it fails)
>
> Fixing the console isn't that difficult - you just need to make your
> device queue the console I/O to a worker thread of some kind. We don't

That is what I wanted to try next. ;)

> want to do that by default because we want to get the messages out
> reliably and immediately on saner hardware. Given there are several
> such cases a general helper and a console "I am crap" flag might be better
> than hacking each driver.

All those drivers look very similiar. I will see if I'm successfull in 
writing such an IamCrapHelper. Might need some time, but I will post a 
patch for review, if I've done and tested it. I'm only using the USB-LCD 
on occasion, so it doesn't have high priority for me because I don't 
really need it.

Thanks for the hints.

Regards,

Alexander
