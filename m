From: Jon Smirl <jonsmirl@gmail.com>
Subject: fixing fbdev for various framebuffer configs
Date: Fri, 29 Jul 2005 06:53:08 -0400
Message-ID: <9e473391050729035370d76cc5@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DySUM-0007x8-Pp
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 03:53:14 -0700
Received: from wproxy.gmail.com ([64.233.184.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DySUL-0003UN-OV
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 03:53:15 -0700
Received: by wproxy.gmail.com with SMTP id 36so583883wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 29 Jul 2005 03:53:08 -0700 (PDT)
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>, "Antonino A. Daplas" <adaplas@hotpop.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Simmons <jsimmons@infradead.org>

It has been determined that bits per pixel is insuffucient to
enumerate all the needed fbconfigs. Here are the possible fgconfigs
from the OpenGL headers:

total bits=20
8     GL_R3_G3_B2
8     GL_RGBA2
12   GL_RGB4
15   GL_RGB5
16   GL_R5_G6_B5
16   GL_RGBA4
16   GL_RGB5_A1
24   GL_RGB8
30   GL_RGB10
32   GL_RGBA8
32   GL_RGB10_A2
36   GL_RGB12
48   GL_RGB16
48   GL_RGBA12
48   GL_FLOAT_RGB16
64   GL_RGBA16
64   GL_FLOAT_RGBA16
96   GL_FLOAT_RGB32
128 GL_FLOAT_RGBA32

We need to be able to set any of these through the fbdev interface. We
also need to allow for possible future expansion.

Ideas on how to adjust the fbdev interface?

What is the effect of alpha bits on the scanout buffer, do they do anything=
?

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
