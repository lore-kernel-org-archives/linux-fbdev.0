From: InKi Dae <daeinki@gmail.com>
Subject: Re: [patch] added brightness feature to lcd class.
Date: Sat, 7 Nov 2009 21:43:50 +0900
Message-ID: <90b950fc0911070443s57d2ec5ehcb5c9cf9edcf8d8c@mail.gmail.com>
References: <90b950fc0911020050q3bc3fae8j954ec6ed73d79b5@mail.gmail.com>
	 <20091105192725.GE1392@ucw.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751887AbZKGMnt@vger.kernel.org>
In-Reply-To: <20091105192725.GE1392@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Kyungmin Park <kmpark@infradead.org>

Thank you for your comments.

using backlight is good way in case of TFT-LCD Panel.
because TFT-LCD Panel needs backlight device to light up.

but AMOLED LCD Panel doesn't need backlight device because lighting up =
itself.
if you try to control brightness of AMOLED LCD Panel and using backligh=
t class
then you should write fake backlight driver that it has no real device
for controlling
and would control brightness through that driver.

with this reason, I think that it's better to control brightness
through lcd class in case of AMOLED LCD panel.
If lcd class has birghtness feature then AMOLED LCD Panel driver would
become more simple and effective.

I think it is more generic way that only real device should have
device driver so I proposed this.

Thank you.

Best Regards,
InKi Dae.

2009/11/6 Pavel Machek <pavel@ucw.cz>:
> On Mon 2009-11-02 17:50:02, InKi Dae wrote:
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
>> But this way is not good, so I propose to add brightness feature to =
lcd class.
>>
>
> Why is it 'not good'? Using backlight driver seems like way to go to
> me.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
Pavel
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/hors=
es/blog.html
>
