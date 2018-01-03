From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 03 Jan 2018 16:41:05 +0000
Subject: Re: [PATCH v3] Fix loading of module radeonfb on PowerMac
Message-Id: <CA+7wUsxW5Voi9rVFQFunXOog7gp38PoyETzCkWit6J+N=2W6XA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479153557-20849-1-git-send-email-malat@debian.org>
 <CGME20171221220824epcas3p1cd1ac40219c9b8bf7be52bc104e31918@epcas3p1.samsung.com>
 <20171221220757.24672-1-malat@debian.org> <1565457.zQ5DZdIQMY@amdc3058> <20180103152325.5qu52gc5g5edfp22@csclub.uwaterloo.ca>
In-Reply-To: <20180103152325.5qu52gc5g5edfp22@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-kernel@vger.kernel.org

Hi Bartlomiej,

On Wed, Jan 3, 2018 at 4:23 PM, Lennart Sorensen
<lsorense@csclub.uwaterloo.ca> wrote:
> On Wed, Jan 03, 2018 at 03:47:35PM +0100, Bartlomiej Zolnierkiewicz wrote:
>> On Thursday, December 21, 2017 11:07:56 PM Mathieu Malaterre wrote:
>> > When the linux kernel is build with (typical kernel ship with Debian
>> > installer):
>> >
>> > CONFIG_FB_OF=y
>> > CONFIG_VT_HW_CONSOLE_BINDING=y
>> > CONFIG_FB_RADEON=m
>> >
>> > The offb driver takes precedence over module radeonfb. It is then
>> > impossible to load the module, error reported is:
>> >
>> > [   96.551486] radeonfb 0000:00:10.0: enabling device (0006 -> 0007)
>> > [   96.551526] radeonfb 0000:00:10.0: BAR 0: can't reserve [mem 0x98000000-0x9fffffff pref]
>> > [   96.551531] radeonfb (0000:00:10.0): cannot request region 0.
>> > [   96.551545] radeonfb: probe of 0000:00:10.0 failed with error -16
>> >
>> > This patch reproduce the behavior of the module radeon, so as to make it
>> > possible to load radeonfb when offb is first loaded.
>> >
>> > It should be noticed that `offb_destroy` is never called which explain the
>> > need to skip error detection on the radeon side.
>>
>> This still needs to be explained more, from my last mail:
>>
>> "The last put_fb_info() on fb_info should call ->fb_destroy
>> (offb_destroy in our case) and remove_conflicting_framebuffers()
>> is calling put_fb_info() so there is some extra reference on
>> fb_info somewhere preventing it from going away.
>>
>> Please look into fixing this."
>
> My impression of that problem is that the offb driver is in use because
> it is running the console, and until the radeonfb driver is loaded and
> ready to take over, you can't stop using the offb driver, but you can't
> currently load the radeonfb because offb is holding resources it wants.
>
> Maybe I have misunderstood what the code is doing, but that seems to be
> the problem.
>
> On an x86 PC you could drop one fb and go to text mode then start another
> fb driver.  PPC doesn't have that option since there is no text mode.

For reference my patch was inspired by commit:

https://github.com/torvalds/linux/commit/a56f7428d7534f162fbb089c5c79012bf38a7c29

While doing the search, I discover my patch is incorrect, I need to
integrate change from:

https://github.com/torvalds/linux/commit/44adece57e2604cec8527a499b48e4d584ab53b8#diff-767fb253c0135686111755f394d64199

So I'll submit a v4 anyway.

Thanks all,
