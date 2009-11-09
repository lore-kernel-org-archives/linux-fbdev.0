From: InKi Dae <daeinki@gmail.com>
Subject: Re: [patch] added brightness feature to lcd class.
Date: Tue, 10 Nov 2009 00:37:59 +0900
Message-ID: <90b950fc0911090737tde32562qc878fac38cacabae@mail.gmail.com>
References: <90b950fc0911020050q3bc3fae8j954ec6ed73d79b5@mail.gmail.com>
	 <20091105192725.GE1392@ucw.cz>
	 <90b950fc0911070443s57d2ec5ehcb5c9cf9edcf8d8c@mail.gmail.com>
	 <20091107164830.GA1586@ucw.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756171AbZKIPhz@vger.kernel.org>
In-Reply-To: <20091107164830.GA1586@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Kyungmin Park <kmpark@infradead.org>

are you saying me that user shouldn't know if it is TFT-LCD or AMOLD?
I agree your saying.

if lcd class has brightness feature then sysfs file for controlling
brightness will be placed
in /sys/class/lcd/*/brightness.
it would be a problem because the path is no sysfs you expected.

how about that symbolic link file is created by lcd class for user?
like this,
/sys/class/lcd/*/brightness -> /sys/class/backlight/*/brightness

for this, some codes of creating symbolic link file should be added to
lcd class.

I still think it is not good way that lcd panel driver not having
backlight device has backlight driver
to control brightness and it should be solved in the course of time.

thank you.

2009/11/8 Pavel Machek <pavel@ucw.cz>:
> On Sat 2009-11-07 21:43:50, InKi Dae wrote:
>> Thank you for your comments.
>>
>> using backlight is good way in case of TFT-LCD Panel.
>> because TFT-LCD Panel needs backlight device to light up.
>>
>> but AMOLED LCD Panel doesn't need backlight device because lighting =
up itself.
>
> I know. So what?
>
> User wants to set brightness. Why should userspace know/care if it is
> TFT or AMOLED?
>
> I have this script:
>
> #!/bin/bash
> echo $1 > /sys/class/backlight/*/brightness
>
> why should I have to rewrite it just because you decided amoled is
> special?
>
> Kernel is expected to provide hw abstraction...
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
Pavel
>
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/hors=
es/blog.html
>
