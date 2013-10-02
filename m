From: David Herrmann <dh.herrmann@gmail.com>
Date: Wed, 02 Oct 2013 15:01:44 +0000
Subject: Re: [BUG] simplefb not showing any output
Message-Id: <CANq1E4R887T79Cd_YmzkpZWqvvUD4uiB_ga3Z2BUNYbtqEnLUw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAG-2HqXhLcRX-oi4JchD=m7tZpDYyePKhWvkFU1ZZPEuqJ2JqQ@mail.gmail.com>
In-Reply-To: <CAG-2HqXhLcRX-oi4JchD=m7tZpDYyePKhWvkFU1ZZPEuqJ2JqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi

On Tue, Sep 10, 2013 at 4:34 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 09/07/2013 06:25 AM, David Herrmann wrote:
>> On Sat, Sep 7, 2013 at 1:47 PM, Tom Gundersen <teg@jklm.no> wrote:
> ...
>>> A related question: is it expected that simplefb should be
>>> significantly slower than efifb, or is that something worth looking
>>> into? My boot with simplefb is roughly five seconds slower than with
>>> efifb. Coincidentally, I notice the same (or similar slowdown) with
>>> inteldrmfb when I see the oops (but not otherwise).
>>
>> That is probably related to the missing write-combine tag in ioremap.
>> Stephen, any objections to this attached patch?
>> Tom, if this solves the speed-issues, I will send it out once I get home.
>>
>> Thanks
>> David
>>
>> (Patch also attached in case of new-lines issues)
>>
>> From dbfb8e12166d494cd60823cbe84134d5d1a73ec8 Mon Sep 17 00:00:00 2001
>> From: David Herrmann <dh.herrmann@gmail.com>
>> Date: Sat, 7 Sep 2013 14:22:01 +0200
>> Subject: [PATCH] devm/simplefb: introduce and use devm_ioremap_wc()
>>
>> We want to use devm_ioremap_nocache() or even devm_ioremap_wc() to speed
>> up fbdev writes _a lot_. As devm_ioremap_wc() doesn't exist, yet,
>> introduce it along the way. Note that ioremap_wc() is aliases to
>> ioremap_nocache() in asm-generic/{io,iomem}.h so we can safely expect all
>> architectures to either provide it or use the same alias.
>
> OK, that works fine on the Raspberry Pi too, so,
> Tested-by: Stephen Warren <swarren@wwwdotorg.org>

Back from the US and all patches sent out. Sorry for the delay. If I
missed something, please let me know.

Thanks for your feedback!
David
