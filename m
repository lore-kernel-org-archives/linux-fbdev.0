From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: Re: [directfb-users] Framebuffer woes...
Date: Wed, 19 Oct 2005 08:26:16 +0200
Message-ID: <4355E708.1000702@t-online.de>
References: <1129687824.25556.32.camel@localhost.localdomain> <4355D310.1060203@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ES7Km-0000oa-19
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 23:21:56 -0700
Received: from mailout06.sul.t-online.com ([194.25.134.19])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1ES7Kj-0005Hn-LA
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 23:21:56 -0700
In-Reply-To: <4355D310.1060203@gmail.com>
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
Cc: "Nathanael D. Noblet" <nathanael@gnat.ca>, directfb-users@directfb.org

Hi Nathanael,

>>I have a VIA EPIA board. It has a built in Trident graphics adapter. Th=
e
>>problem I'm having is that when I try to get it to run, the lcd OSD
>>throws up an error message about 'Out Of Range', sometimes blanking the
>>screen, sometimes not.
>>
>>   =20
>>

What kind of Epia? I suppose Epia 800 or Epia 5000. If that=B4s the case,=
=20
disable
tridentfb and enable the cyblafb driver included in the 2.6.14-rc kernels=
.

>>mode "1024x768-76"
>>    # D: 78.653 MHz, H: 59.949 kHz, V: 75.694 Hz
>>    geometry 1024 768 1024 768 16
>>    timings 12714 128 32 16 4 128 4
>>    rgba 5/11,6/5,5/0,0/0
>>endmode
>>
>>   =20
>>
Add
       video=3Dcyblafb:1024x768,bpp=3D16,ref=3D76
to the  kernel command line. If that does not help immediately, use
       video=3Dcyblafb:1024x768,bpp=3D16,ref=3D76,verbosity=3D2 vga=3D0x3=
17
and send complete dmesg output after booting as well as lspci -vv output.

There will be a lot of debugging output, be sure to use a big enough
buffer size for kernel messages.

>>All of those (regardless of depth (8,16,24) all produce 'out of range'
>>problems.
>>
>>   =20
>>
tridentfb timing calcualtion was broken in 2.4 kernels and is broken for=20
2.6 kernels,
at least for the cyberblade/i1.

cu,
 Knut


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
