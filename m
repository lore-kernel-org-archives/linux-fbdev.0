From: Michal Suchanek <hramrach@gmail.com>
Date: Thu, 28 Aug 2014 10:32:11 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <CAOMqctRpKSn=USM2_y2d9Nppm8DYKAYeRv8TE8K14aj1DCoDew@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825150501.GE14763@ulmo.nvidia.com>
 <20140825152232.GE15297@lukather>
 <20140826080432.GD17263@ulmo> <20140826135341.GM15297@lukather>
 <20140826143550.GB3027@ulmo> <20140826210248.GO15297@lukather>
 <20140827065440.GG15640@ulmo> <20140827084526.GR15297@lukather>
 <20140827095241.GC23186@ulmo> <20140827154221.GX15297@lukather>
 <20140828101140.GB14388@ulmo>
In-Reply-To: <20140828101140.GB14388@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 28 August 2014 12:11, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Wed, Aug 27, 2014 at 05:42:21PM +0200, Maxime Ripard wrote:
>> On Wed, Aug 27, 2014 at 11:52:48AM +0200, Thierry Reding wrote:
>> > On Wed, Aug 27, 2014 at 10:45:26AM +0200, Maxime Ripard wrote:
>> > > On Wed, Aug 27, 2014 at 08:54:41AM +0200, Thierry Reding wrote:
>> > > > On Tue, Aug 26, 2014 at 11:02:48PM +0200, Maxime Ripard wrote:
>> > > > > On Tue, Aug 26, 2014 at 04:35:51PM +0200, Thierry Reding wrote:
>> > [...]
>> > > > > > > Mike Turquette repeatedly said that he was against such a DT property:
>> > > > > > > https://lkml.org/lkml/2014/5/12/693
>> > > > > >
>> > > > > > Mike says in that email that he's opposing the addition of a property
>> > > > > > for clocks that is the equivalent of regulator-always-on. That's not
>> > > > > > what this is about. If at all it'd be a property to mark a clock that
>> > > > > > should not be disabled by default because it's essential.
>> > > > >
>> > > > > It's just semantic. How is "a clock that should not be disabled by
>> > > > > default because it's essential" not a clock that stays always on?
>> > > >
>> > > > Because a clock that should not be disabled by default can be turned off
>> > > > when appropriate. A clock that is always on can't be turned off.
>> > >
>> > > If a clock is essential, then it should never be disabled. Or we don't
>> > > share the same meaning of essential.
>> >
>> > Essential for the particular use-case.
>>
>> So, how would the clock driver would know about which use case we're
>> in? How would it know about which display engine is currently running?
>> How would it know about which video output is being set?
>>
>> Currently, we have two separate display engines, which can each output
>> either to 4 different outputs (HDMI, RGB/LVDS, 2 DSI). Each and every
>> one of these combinations would require different clocks. What clocks
>> will we put in the driver? All of them?
>
> Ideally the solution wouldn't involve hard-coding this into the clock
> driver at all. There should be a way for firmware to communicate to the
> kernel that a given clock shouldn't be disabled. Then since firmware
> already knows what it set up it can tell the kernel to not touch those.
>

And that way is that it inserts into the simplefb node or whatever
node the list of clocks that it programmed in order to make the
framebuffer work. Do you know a better, more generic way than that?

Thanks

Michal
