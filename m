From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: 2 more fbcon rotation bugs
Date: Sat, 19 Nov 2005 19:35:50 +0800
Message-ID: <437F0E16.8040508@gmail.com>
References: <437DF1EA.7010906@t-online.de> <437E3856.9030509@gmail.com> <437EFA9B.8090402@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EdR0u-0000mw-Qn
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Nov 2005 03:36:12 -0800
Received: from zproxy.gmail.com ([64.233.162.198])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EdR0u-0007Wt-LI
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Nov 2005 03:36:12 -0800
Received: by zproxy.gmail.com with SMTP id z3so357795nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 19 Nov 2005 03:36:12 -0800 (PST)
In-Reply-To: <437EFA9B.8090402@t-online.de>
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
Content-Type: text/plain; charset="iso-8859-1"
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: linux-fbdev-devel@lists.sourceforge.net

Knut Petersen wrote:
> Antonino A. Daplas schrieb:

> Additional bug: I am used to compile vesafb into the kernel and to load
> and remove the cyblafb
> module during the developement process, switching to and from vesafb
> using con2fb. That=B4s still
> possible with rotation =3D=3D 0, but it locks the computer if at least =
one
> framebuffer is set to rotation 1.
> I have not tested that for rotation =3D=3D 2 or 3.

I tried with savagefb and vga16fb.  vga16fb is mapped to all consoles wit=
h
fbcon=3Dmap:1. Set different tty's at different angles of rotation.  Then
used con2fbmap to make savagefb take over the entire console. I don't
experience any hang, and all the consoles are properly rotated at their
respective angles.

I also tried mapping vga16fb back.  The resulting screen becomes corrupte=
d
of course, but no hang.  I can map savagefb back again without problems.

(The only bad thing that happened is when I tried switching consoles when
vga16fb owns the console and the display is corrupted.  The machine
reboots.)
=20
Tony


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=3D7628&alloc_id=3D16845&op=3Dclick
