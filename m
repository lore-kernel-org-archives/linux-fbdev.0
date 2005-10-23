From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: mode switching on intelfb and non-CRT displays
Date: Sun, 23 Oct 2005 09:05:33 +0200
Message-ID: <435B363D.3030308@t-online.de>
References: <7ceaf2d70510171035u66d65f53rfd6cfde956c399d7@mail.gmail.com> <4354AD3A.3070504@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ETZqo-0006Xp-Da
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 23 Oct 2005 00:01:02 -0700
Received: from mailout11.sul.t-online.com ([194.25.134.85])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1ETZqm-00016X-Od
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 23 Oct 2005 00:01:02 -0700
In-Reply-To: <4354AD3A.3070504@gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: xgdfalcon@gmail.com

Hi Tony,

>>What would it take to get intelfb mode switching working with non-CRT
>>displays?=20
>>
>Documentation.  Or you can try googling for vesafb-tng.
> =20
>
Something like that should be possible even without documentation from=20
vendor xyz.

    0: google, read X sources, etc.

    1: Extend a private version of vesafb and xyz-fb with a function=20
that dumps all known
    hardware  registers. Call it at the end of the xyz-fb_set_par()=20
routine and while loading
    vesafb.

    2. Boot several times (without loading X) and save a vesafb register=20
dump for every
    valid vesa mode.

    3. Compare the register dumps and try to be intelligent ;-)  Most=20
probably you will
    find that only a few registers differ. Some will change with=20
differnt color depths,
    some will change with different vertical and horizontal resolutions.=20
Also a clock
    divider needs to be discovered.

    4. Verify your assumptions and release a mode switching xyz-fb driver=
.

It might also be a good idea to write a little dumpreg program for DOS=20
and/or Windows.
If there is e.g. a utility program for DOS that allows you to change the=20
refresh rate, it
should be quite easy to identify the clock divider registers.

ypan and ywrap scrolling does help a lot to increase speed. Try to=20
identify as many
bits of the crt start address value as possible by instrumenting vesafb.=20
Simply call your
register dump function at the end of vesafb_pan_display() for several=20
times and have a close
look at the bits changed during scrolling. Don=B4t start displaying those=
=20
register dumps immediately,
that way you obviously would lock your pc.

cu,
 knut

PS and ONLY for the brave: Write a little DOS program that single steps=20
the BIOS, saves all
IO to the vga register range to a buffer and displays it after=20
completion of the mode switch.
If the BIOS tries to prevent single stepping in real mode, switch to=20
vm86. It=B4s even possible
(and easier to implement than a vm86 monitor) to use a memory manager=20
like qemm386 and
a few lines of assembly code to map a writable copy of the video bios=20
image at the place of
the original bios if necessary.




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
