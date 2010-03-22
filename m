From: InKi Dae <daeinki@gmail.com>
Subject: Re: [PATCH] fixed sparkling issue on lcd panel when fb_blank mode is 
	changed.
Date: Mon, 22 Mar 2010 12:18:05 +0900
Message-ID: <90b950fc1003212018h69bb0fa0t9dd62815b08eb7b3@mail.gmail.com>
References: <90b950fc1003182136n73d54c2di4be84f16e4c3534f@mail.gmail.com>
	 <1269004294.4292.18.camel@rex>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1269004294.4292.18.camel@rex>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Pavel Machek <pavel@ucw.cz>, Kyungmin Park <kmpark@infradead.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

yes, you are right.

when fb_blank mode is changed to FB_BLANK_NORMAL or
=46B_BLANK_UNBLANK(power down -> power up)
it has a possibility that we would encounter same issue.

I'd try to modify my patch to be considered with your opinion and will
send it again.
Thank you for your answer.

Best Regards,
InKi Dae.

2010/3/19 Richard Purdie <rpurdie@rpsys.net>:
> Hi,
>
> On Fri, 2010-03-19 at 13:36 +0900, InKi Dae wrote:
>> This issue is a problem that lcd panel is spakled when fb_blank mode=
 is changed
>> From FB_BLANK_UNBLANK to FB_BLANK_POWER or FB_BLANK_POWER to FB_BLAN=
K_UNBLANK.
>>
>> In case of FB_BLANK_UNBLANK, screen =3D on, vsync =3D on, hsync =3D =
on and
>> For FB_BLANK_POWERDOWN screen =3D blanked, vsync =3D off, hsync =3D =
off
>> So like this when fb_blank mode becomes FB_BLANK_POWERDOWN,
>> Display controller and lcd panel should become off to reduce power c=
onsumption.
>>
>> Let's see fb_blank function of fbmem.c file.
>>
>> fb_blank()
>> {
>> =A0 =A0 if (info->fbops->fb_blank)
>> =A0 =A0 =A0 =A0 =A0 =A0 ret =3D info->fbops->fb_blank(blank, info(
>> =A0 =A0 if (!ret)
>> =A0 =A0 =A0 =A0 =A0 =A0 fb_notifier_call_chain(FB_EVENT_BLANK, &even=
t);
>> }
>>
>> This problem is because this code calls fb_blank (fb_blank of device
>> specific framebuffer driver)
>> Earlier then fb_notifier_call_chain.
>>
>> For example,
>> Device specific fb_blank function is registered to generic framebuff=
er
>> driver through register_framebuffer function
>> And fb_notifier_call_chain calls any callback function registered to
>> lcd class(lcd.c) through fb_notifier_callback function.
>> So if fb_blank mode is changed to FB_BLANK_POWERDOWN then display
>> controller would become off(clock disable)
>> On the other hand, lcd panel would still be on. at this time, some
>> situation on lcd panel occers like sparkling
>> Because video clock to be delivered to ldi module of lcd panel is di=
sabled also.
>>
>> This patch get fb_notifier_call_chain to be called earlier then fb_b=
lank.
>> Please, review this patch.
>
> So to summarise the problem more succinctly the LCD and the display
> controllers power off in the wrong order causing visual defects
> (sparkling) on the display.
>
> I was a bit worried about event order and loops with this change so I
> checked and there are three consumers of these events in the kernel:
> consoles, LCD and backlight. None of them have a problem with this
> change of order for power down so from that point of view I'm ok with
> the change.
>
> However this function also covers powerup from a screen blank to an
> active screen. When powering up it makes sense to power up the video
> device first, then the LCD, backlight and console as per the current
> code, otherwise I can imagine "sparkling" upon powerup.
>
> So it looks like we need to change order only on powerdown, not upon
> resume, otherwise we'll get further regression reports on poweron?
>
> Cheers,
>
> Richard
>
>
>
>
>
