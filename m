From: InKi Dae <daeinki@gmail.com>
Subject: Re: [patch] added brightness feature to lcd class.
Date: Tue, 10 Nov 2009 12:26:32 +0900
Message-ID: <90b950fc0911091926v32dc1c44n1018322390282bc0@mail.gmail.com>
References: <90b950fc0911020050q3bc3fae8j954ec6ed73d79b5@mail.gmail.com>
	 <1257809705.29038.82.camel@dax.rpnet.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755877AbZKJD0a@vger.kernel.org>
In-Reply-To: <1257809705.29038.82.camel@dax.rpnet.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Purdie <rpurdie@linux.intel.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Kyungmin Park <kmpark@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Pavel Machek <pavel@ucw.cz>

Thank you for your comments.

it is a good idea that lcd driver registers interfaces to lcd class
and backlight class.
but I think for AMOLED LCD Panel, backlight couldn't be real device so
power on/off
for backlight device doesn't make sense.

I had tried lcd driver registers interfaces to lcd class and backlight
class as you said.
and also backlight fake driver as Pavel said.

but I thought to use my patch is more simple and effective.
of course, this patch has a problem that it has different path from
backlight class
for controlling brightness.

how about creating symbolic link file for competiability?

Best Regards,
InKi Dae.

2009/11/10 Richard Purdie <rpurdie@linux.intel.com>:
> On Mon, 2009-11-02 at 17:50 +0900, InKi Dae wrote:
>> This patch adds brightness feature to lcd class.
>> (kernel/driver/video/backlight/lcd.c)
>>
>> In the past, most of the lcd panels for embedded system was TFT-LCD
>> Panel needing backlight device.
>> But now AMOLED LCD Panel appeared so we should consider brightness
>> control for AMOLED Panel.
>>
>> For the time being, I used backlight fake driver for brightness
>> control of AMOLED LCD Panel.
>> But this way is not good, so I propose to add brightness feature to lcd class.
>>
>> For this, I attached patch file and if my proposal is approved
>> Then I will send s6e63m0 and tl2796 AMOLED lcd panel driver based on
>> lcd class modified soon.
>
> Pavel has a good point but let me try and explain it differently.
>
> The point of the backlight class is to expose a backlight brightness
> control to userspace in a consistent well defined way. Anyone wishing to
> write a piece of software to control the brightness of a backlight then
> only needs to support *one* interface.
>
> It is entirely accepted and normal that multiple "class" devices may
> appear in userspace for one piece of physical hardware.
>
> Your patch duplicates a userspace API and means any backlight
> application would have to look for *two* different interfaces. This is
> unacceptable.
>
> Why can't your driver just register a backlight interface and an LCD
> interface? I'd imagine your backlight and LCD can be powered on/off
> separately too.
>
> Please also cc: the backlight/lcd maintainer (me) on backlight/lcd
> patches in future.
>
> Andrew: Can you drop that patch from -mm please as I'm not convinced we
> need two backlight brightness interfaces around...
>
> Cheers,
>
> Richard
>
>
>
>
