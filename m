From: Ryan Mallon <ryan@bluewatersys.com>
Date: Thu, 26 Aug 2010 00:00:08 +0000
Subject: Re: [PATCH] video: tegra: add tegra display controller and fb driver
Message-Id: <4C75AE88.30809@bluewatersys.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1281568272-25871-1-git-send-email-konkers@android.com>	<4C6379E1.4010500@bluewatersys.com>	<AANLkTini+n1osaQHkomguzZi-DaHLX3i1G4gA82bK0=S@mail.gmail.com>	<4C75A039.8060701@bluewatersys.com>
	<AANLkTimTJKOgDKqpOR7LR-2gS1qQamke12m73hDru_=t@mail.gmail.com>
In-Reply-To: <AANLkTimTJKOgDKqpOR7LR-2gS1qQamke12m73hDru_=t@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 08/26/2010 11:56 AM, Erik Gilling wrote:
> On Wed, Aug 25, 2010 at 3:59 PM, Ryan Mallon <ryan@bluewatersys.com> wrote:
>> On 08/26/2010 10:03 AM, Erik Gilling wrote:
>>
>> You sent this just to me, did you mean to post to the list also?
> 
> oops
> 
>>>>> +config FB_TEGRA
>>>>> +     tristate "Tegra Framebuffer driver"
>>>>> +     depends on TEGRA_DC && FB = y
>>>>
>>
>>>>
>>>> The dump_regs code is very long for a debugging feature. Can it just be
>>>> replaced by a for loop which prints the offsets and values of each register?
>>>
>>> Printing the names of the registers has been invaluable so far.  I
>>> could move this to a separate file.
>>
>> Its useful for debugging while developing the driver, but it adds a lot
>> of code. Do you expect the register dumping features to be required once
>> the driver hits mainline?
> 
> I expect the driver will hit mainline is several phases.  This first
> one.  One where HDMI works.  One where DSI works.  One which has
> rotation.  This code is useful for all those phases.
...
> They still fill different uses.  You can't cat a debugfs file from an
> interrupt handler.  You can't call dump_regs() from userspace.  I'm
> still actively using both.  I could see taking one out once
> development on the driver calms down.

Okay, maybe keep both with a comment stating why the debug is still
there, and that it is scheduled to be removed once the driver is
complete in mainline?

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan@bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
