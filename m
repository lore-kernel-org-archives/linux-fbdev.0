From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [framebuffer] broken again :/
Date: Wed, 21 Jul 2004 22:45:15 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040721224515.1b76193e.akpm@osdl.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BnTb3-0005Gr-0F
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Jul 2004 19:46:13 -0700
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BnTb2-000320-9u
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Jul 2004 19:46:12 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: pluto@pld-linux.org



Begin forwarded message:

Date: Wed, 21 Jul 2004 16:00:44 +0200
From: Pawe=B3 Sikora <pluto@pld-linux.org>
To: Andrew Morton <akpm@osdl.org>
Subject: [framebuffer] broken again :/


Hi,

# vanilla 2.8.8rc2...

I switch *all* consoles to 1024x768(75Hz,32bpp) (rivafb) mode.
(http://149.156.124.14/~pluto/tmp/kernel/step1.png)
Even without launching a bootsplash while switching
to another console I observe below effect:
(strange resolution and horrible aspect ratio)
http://149.156.124.14/~pluto/tmp/kernel/step2.png
I switch consoles again to 1024x768(75Hz,32bpp) mode
and get an oops:
http://149.156.124.14/~pluto/tmp/kernel/step3.png

# vanilla 2.6.7...

I switch *all* consoles to 1024x768(75Hz,32bpp) (rivafb) mode.
While switching to another console everything is all right.
(no resolution/aspect changes, no oops).

# summary

Framebuffer in 2.6.8-xx is broken (again) :/
Writing to lkml =3D=3D Writing to /dev/null :/
Please, forward this email to fb-related developers.
At now, PLD-Linux rolls back to 2.6.7(+security fixes).

2.6.8 is unusable :(

--=20
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
