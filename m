From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 8/9] fbdev: Fix default timings in vga16fb
Date: Tue, 21 Dec 2004 23:34:18 +0800
Message-ID: <20041221213722.C41221A0257@smtp-1.hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CgrhO-0007p6-3k
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 21 Dec 2004 13:37:42 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CgrhN-0002Y2-Jj
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 21 Dec 2004 13:37:42 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id D49C8AAFA25
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 21 Dec 2004 21:37:28 +0000 (UTC)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Martin Wilck <martin.wilck@fujitsu-siemens.com>


=46rom Martin Wilck:

=2E.I am asking because we have encountered a video device that obviously=20
has problems displaying the standard mode of the vga16fb driver...

The default timings give a vtotal of 529 instead of 525 in 640x480@60.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
=2D--

 vga16fb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -Nru a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
=2D-- a/drivers/video/vga16fb.c	2004-11-10 06:15:07 +08:00
+++ b/drivers/video/vga16fb.c	2004-11-25 22:45:54 +08:00
@@ -91,8 +91,8 @@
 	.pixclock	=3D 39721,
 	.left_margin	=3D 48,
 	.right_margin	=3D 16,
=2D	.upper_margin	=3D 39,
=2D	.lower_margin	=3D 8,
+	.upper_margin	=3D 33,
+	.lower_margin	=3D 10,
 	.hsync_len 	=3D 96,
 	.vsync_len	=3D 2,
 	.vmode		=3D FB_VMODE_NONINTERLACED,






-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
