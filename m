From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: [BUG] [PATCH 8/10] fbcon: Break up bit_putcs into its component functions
Date: Fri, 02 Sep 2005 13:18:22 +0200
Message-ID: <431834FE.1030308@t-online.de>
References: <431775CA.4020509@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EB9wu-00021Y-Fc
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 02 Sep 2005 04:43:12 -0700
Received: from mailout11.sul.t-online.com ([194.25.134.85])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EB9ws-0006Ii-Lw
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 02 Sep 2005 04:43:12 -0700
In-Reply-To: <431775CA.4020509@gmail.com>
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
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>

The patch is broken, please don=B4t apply!

If count > maxcnt in bit_putcs(), bit_putcs_(un)aligned() is first=20
called to display
maxcnt characters. It returns, and the current value for the source=20
pointer s is lost.
Then bit_putcs_(un)aligned() is called again, obviously displaying=20
characters from
the start of s and not starting after the last allready displayed charact=
er.

Obviously that will only happen for small pixmap buffers, large fonts=20
and high
resolutions. For the default pixmap size of 8k, a 16x32 font this bug=20
will have
the described results for all xres > 2048, for the same font and a pixmap
size of 4k all xres > 1024.

A small pixmap sizes of 4k gives better overall performance for at least=20
the
cyberbade/i1 / Via Samuel 2 combination because of cache effects.

Steps to reproduce:

    - Reduce pixmap size to 4k, compile and reboot or reload framebuffer=20
module
    - fbset 1280x1024
    - setfont bitstream_vera_sans_mono_roman.16x30.psf
    - ctrl-alt-f2 ctrl-alt-f1

To Antonino,

    - dont=B4t pass unused parameters like count, xx and yy to=20
bit_putcs_(un)alligned()
    - you do not need to calculate idx if you have calculated and passed=20
s_pitch

cu
 knut




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
