From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: [PATCH 1/1 2.6.13] framebuffer: bit_putcs()
 optimization for 8x* fonts
Date: Wed, 31 Aug 2005 00:26:54 +0200
Message-ID: <4314DD2E.7060901@t-online.de>
References: <43148610.70406@t-online.de> <Pine.LNX.4.62.0508301814470.6045@numbat.sonytel.be> <43149E5B.7040006@t-online.de> <Pine.LNX.4.61.0508302039160.3743@scrub.home>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EAEWP-0007m0-On
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 Aug 2005 15:24:01 -0700
Received: from mailout11.sul.t-online.com ([194.25.134.85])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EAEWN-0001xE-CP
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 Aug 2005 15:24:01 -0700
In-Reply-To: <Pine.LNX.4.61.0508302039160.3743@scrub.home>
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
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, "Antonino A. Daplas" <adaplas@gmail.com>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Jochen Hein <jochen@jochen.org>

Hi Roman,

>Could you try the patch below, for a few extra cycles you might want to=20
>make it an inline function.
> =20
>
No, it does not help. If there is any difference, it is too small to be=20
measured on
my system ... and my system does run at 1000 Hz.

After 2.6.12 fb_pad_aligned_buffer() was changed to use memcpy() instead=20
of a
bytewise copy. That slowed things down a lot, some weeks ago that was=20
reverted.
fb_pad_aligned _buffer() isn=B4t that slow, it=B4s just an external funct=
ion=20
to be called
and that means a lot of unnecessary code.

How could I make it an inline function? It is used in console/bitblit.c,=20
nvidia/nvidia.c,
riva/fbdev.c and softcursor.c.

cu,
 Knut


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
