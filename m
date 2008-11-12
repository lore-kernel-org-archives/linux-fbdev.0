From: Hinko Kocevar <hinko.kocevar@cetrtapot.si>
Subject: Re: Seg fault on any FB write (Epson S1D13A04on
 Coldfire running 2.6.25)
Date: Wed, 12 Nov 2008 09:34:49 +0100
Message-ID: <491A9529.8020305@cetrtapot.si>
References: <4918E5C3.2090108@one.net>	<49195726.2060103@cetrtapot.si>	<43185.137.237.242.42.1226415047.squirrel@webmail.nuvox.net>	<49199EE3.5090101@cetrtapot.si>
	<20081111195208.e2da189f.kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hinko.kocevar@cetrtapot.si>) id 1L0BFE-0006Fq-23
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 12 Nov 2008 08:38:36 +0000
Received: from zimbra-mta.cetrtapot.si ([89.212.80.172])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1L0BF8-0000q3-MS for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 12 Nov 2008 08:38:36 +0000
In-Reply-To: <20081111195208.e2da189f.kristoffer.ericson@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Kristoffer Ericson wrote:
> On Tue, 11 Nov 2008 16:04:03 +0100
> Hinko Kocevar <hinko.kocevar@cetrtapot.si> wrote:
> =

>> jkimble@one.net wrote:
>>>> James Kimble wrote:
>>> /proc/iomem shows:
>>>
>>> 74000000-74009000 : s1d13a04fb.0
>>> 74000000-74009000 : s1d13xxxfb regs
>>> 74040000-74068000 : s1d13a04fb.0
>>> 74040000-74068000 : s1d13xxxfb mem
>> I'm not sure if this is correct - two drivers mapped the same region twi=
ce !?
>> Maybe the experts will shed some light on this..
>>
>>> f000070c-f000070c : spi-int-mask
>>> f0000740-f000075f : spi-int-level
>>> f0000a50-f0000a50 : spi-par
>>> f0008a00-f0008ab8 : spi-module
>>> f0008f00-f0008f20 : MCF548X-i2c
>>> f000a000-f000a7ff : mcf548x-flexcan.0
>>> f000a000-f000a7ff : mcf548x-flexcan
>>> f000a800-f000afff : mcf548x-flexcan.1
>>> f000a800-f000afff : mcf548x-flexcan
>>> f0020000-f0033000 : fsl-sec1
>>> fc000000-ffffffff : physmap-flash.0
>>>
>> I haven't took a long look at your driver, but here is our driver for S1=
3706FB that
>> we use on our embedded platform. Hope it helps.
> =

> Any chance of getting a patch against s1d13xxxfb?

Maybe, in the days that follow, in the meantime please take a look at the =

driver (resend) in the previous email.

It is tested with 320x240 LCD panel from Sharp, 8bpp, and hardware palette.=
 The xx706 chip
only has 80kB of framebuffer memory so there is not much you can do with it.

Regards,
Hinko

-- =

Hinko Ko=E8evar, OSS developer
=C8ETRTA POT, d.o.o.
Planina 3, 4000 Kranj, SI EU
tel     ++386 (0) 4 280 66 03
e-mail  hinko.kocevar@cetrtapot.si
http    www.cetrtapot.si


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
