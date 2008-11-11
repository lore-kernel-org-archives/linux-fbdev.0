From: jkimble@one.net
Subject: Re: Seg fault on any FB write (Epson
 S1D13A04onColdfire running 2.6.25)
Date: Tue, 11 Nov 2008 13:02:11 -0500 (EST)
Message-ID: <47826.137.237.242.138.1226426531.squirrel@webmail.nuvox.net>
References: <4918E5C3.2090108@one.net><49195726.2060103@cetrtapot.si><43185.137.237.242.42.1226415047.squirrel@webmail.nuvox.net><49199EE3.5090101@cetrtapot.si>
	<20081111195208.e2da189f.kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jkimble@one.net>) id 1KzxZL-0004xw-1Q
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Nov 2008 18:02:27 +0000
Received: from smtp-out2.atlngahp.sys.nuvox.net ([70.43.63.19]
	helo=smtp02.atlngahp.sys.nuvox.net)
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1KzxZC-00080h-12
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Nov 2008 18:02:27 +0000
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
Content-Type: text/plain; charset="utf-8"
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net


Sorry, I was hacking around just to get something to work. If you look at
the two side by side you'll see that I've not changed that much. The
changes are mostly just plugging in my specific info for the panel I'm
using.

I've not worked with patches much so I'll have to figure out how to do that.


> On Tue, 11 Nov 2008 16:04:03 +0100
> Hinko Kocevar <hinko.kocevar@cetrtapot.si> wrote:
>
>> jkimble@one.net wrote:
>> >> James Kimble wrote:
>> >
>> > /proc/iomem shows:
>> >
>> > 74000000-74009000 : s1d13a04fb.0
>> > 74000000-74009000 : s1d13xxxfb regs
>> > 74040000-74068000 : s1d13a04fb.0
>> > 74040000-74068000 : s1d13xxxfb mem
>>
>> I'm not sure if this is correct - two drivers mapped the same region
>> twice !?
>> Maybe the experts will shed some light on this..
>>
>> > f000070c-f000070c : spi-int-mask
>> > f0000740-f000075f : spi-int-level
>> > f0000a50-f0000a50 : spi-par
>> > f0008a00-f0008ab8 : spi-module
>> > f0008f00-f0008f20 : MCF548X-i2c
>> > f000a000-f000a7ff : mcf548x-flexcan.0
>> > f000a000-f000a7ff : mcf548x-flexcan
>> > f000a800-f000afff : mcf548x-flexcan.1
>> > f000a800-f000afff : mcf548x-flexcan
>> > f0020000-f0033000 : fsl-sec1
>> > fc000000-ffffffff : physmap-flash.0
>> >
>>
>> I haven't took a long look at your driver, but here is our driver for
>> S13706FB that
>> we use on our embedded platform. Hope it helps.
>
> Any chance of getting a patch against s1d13xxxfb?
>
>>
>> Regards,
>> Hinko
>> --
>> Hinko Ko=C4=8Devar, OSS developer
>> =C4=8CETRTA POT, d.o.o.
>> Planina 3, 4000 Kranj, SI EU
>> tel     ++386 (0) 4 280 66 03
>> e-mail  hinko.kocevar@cetrtapot.si
>> http    www.cetrtapot.si
>>
>>
>> -------------------------------------------------------------------------
>> This SF.Net email is sponsored by the Moblin Your Move Developer's
>> challenge
>> Build the coolest Linux based applications with Moblin SDK & win great
>> prizes
>> Grand prize is a trip for two to an Open Source event anywhere in the
>> world
>> http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
>> _______________________________________________
>> Linux-fbdev-devel mailing list
>> Linux-fbdev-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>
>
> --
> Kristoffer Ericson <kristoffer.ericson@gmail.com>
>



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
