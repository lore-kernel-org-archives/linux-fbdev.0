From: jkimble@one.net
Subject: Re: Seg fault on any FB write (Epson
 S1D13A04onColdfire running 2.6.25)
Date: Wed, 12 Nov 2008 10:52:55 -0500 (EST)
Message-ID: <49850.137.237.242.138.1226505175.squirrel@webmail.nuvox.net>
References: <4918E5C3.2090108@one.net> <49195726.2060103@cetrtapot.si>   
	<43185.137.237.242.42.1226415047.squirrel@webmail.nuvox.net>   
	<49199EE3.5090101@cetrtapot.si>
	<1210.137.237.242.125.1226419828.squirrel@webmail.nuvox.net>
	<491A930F.2040507@cetrtapot.si>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jkimble@one.net>) id 1L0I1l-0002Ix-EW
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 12 Nov 2008 15:53:09 +0000
Received: from smtp-out3.atlngahp.sys.nuvox.net ([70.43.63.20]
	helo=smtp03.atlngahp.sys.nuvox.net)
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1L0I1i-0000nf-SP
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 12 Nov 2008 15:53:09 +0000
In-Reply-To: <491A930F.2040507@cetrtapot.si>
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
To: Hinko Kocevar <hinko.kocevar@cetrtapot.si>
Cc: linux-fbdev-devel@lists.sourceforge.net


Thanks! This should help a lot.

This seg fault thing is very weird though. I think my FB driver is ok. I
think it's something basic in how user space accesses this memory that I'm
missing.

Thanks for your help though.


> jkimble@one.net wrote:
>> I thought it looked OK because it looks the same as the flexCAN stuff.
>> However I just noticed that flexCAN has a .0 and .1 whereas the s1d13
>> are
>> both .0. Yeah, I hope an expert weighs in on this because I'm not sure
>> now.
>>
>> I didn't get your attachement.
>>
>
> Maybe I forgot to attach it :P
> Here it is.
>
>
> HTH,
> HK
>
>
> --
> Hinko Ko=C4=8Devar, OSS developer
> =C4=8CETRTA POT, d.o.o.
> Planina 3, 4000 Kranj, SI EU
> tel     ++386 (0) 4 280 66 03
> e-mail  hinko.kocevar@cetrtapot.si
> http    www.cetrtapot.si
>
>



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
