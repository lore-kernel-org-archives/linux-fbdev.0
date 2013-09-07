From: Tom Gundersen <teg@jklm.no>
Date: Sat, 07 Sep 2013 11:47:25 +0000
Subject: Re: [BUG] simplefb not showing any output
Message-Id: <CAG-2HqVqwbcHXVLcMrrRDyVNnzJLkuGXh6TaqABS+d8YmOKbyQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAG-2HqXhLcRX-oi4JchD=m7tZpDYyePKhWvkFU1ZZPEuqJ2JqQ@mail.gmail.com>
In-Reply-To: <CAG-2HqXhLcRX-oi4JchD=m7tZpDYyePKhWvkFU1ZZPEuqJ2JqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sat, Sep 7, 2013 at 1:18 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
> On Sat, Sep 7, 2013 at 11:26 AM, Tom Gundersen <teg@jklm.no> wrote:
>> On Fri, Sep 6, 2013 at 6:11 PM, Tom Gundersen <teg@jklm.no> wrote:
>>> The driver seems to load ok, but sadly it does not give any output. If
>>> I boot via the gummiboot menu the screen remains black, and if I don't
>>> enter the gummiboot menu the screen remains grey (it is a Mac).
>>
>> My apologies, this was a config error (I somehow ended up with
>> FRAMEBUFFER_CONSOLE=m, which works fine with inteldrmfb, but obviously
>> not with any of the compiled in ones).
>
> Good, I almost went crazy looking for an error. Does that mean
> simplefb works for you?

Sorry about that! Yes, it now works.

> I guess the x86-sysfb patch is still needed?

Yes, that is still needed.

> Now I only wonder why the i915 issue showed up. Is it also solved with
> a built-in fbcon?

Sadly, no, that problem persists.

A related question: is it expected that simplefb should be
significantly slower than efifb, or is that something worth looking
into? My boot with simplefb is roughly five seconds slower than with
efifb. Coincidentally, I notice the same (or similar slowdown) with
inteldrmfb when I see the oops (but not otherwise).

Cheers,

Tom
