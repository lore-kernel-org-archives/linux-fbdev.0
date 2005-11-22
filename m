From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: 2 more fbcon rotation bugs
Date: Tue, 22 Nov 2005 07:34:11 +0100
Message-ID: <4382BBE3.9020002@t-online.de>
References: <437DF1EA.7010906@t-online.de> <437E3856.9030509@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EeRjL-0003em-RE
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Nov 2005 22:34:15 -0800
Received: from mailout02.sul.t-online.com ([194.25.134.17])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EeRjK-0004Pb-JC
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Nov 2005 22:34:15 -0800
In-Reply-To: <437E3856.9030509@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi Antonino,

>>Any idea where to start? Can you reproduce the odd behaviour?
>>   =20
>>
>
>This one I cannot reproduce. Have you tried reproducing it with vesafb?
>Any message in the log, such as a kernel oops?  Your description sounds
>like a corruption of cursor->mask and cursor->image.data.
> =20
>
I found the bug, it is specific to cyblafb.

 The problem is that the 16x30 font causes the cyblafb imageblit to fall=20
back to
cfb_imageblit for rotation 1 and 3 while the accelerated copyarea=20
function is
still used. That breaks the private sync mechanism of cyblafb and causes=20
the
erroneous behaviour.

 I=B4ll publish a patch soon.

cu,
 Knut


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=3D7628&alloc_id=3D16845&op=3Dclick
