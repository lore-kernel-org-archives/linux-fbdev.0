From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH 7/8] fbdev: atyfb_base.c requires atyfb_cursor()
Date: Tue, 2 Nov 2004 15:58:43 +0200
Message-ID: <20041102135843.GA13761@sci.fi>
References: <200411021946.26862.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1COzBP-0002xv-Jz
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 05:58:47 -0800
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1COzBP-0004dF-4Q
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 05:58:47 -0800
Content-Disposition: inline
In-Reply-To: <200411021946.26862.adaplas@hotpop.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Olaf Hering <olh@suse.de>

On Tue, Nov 02, 2004 at 07:46:26PM +0800, Antonino A. Daplas wrote:
> atyfb_base.c requires atyfb_cursor, but it is only available for linkin=
g
> if CONFIG_FB_ATY_CT=3Dy.
> This patch moves the .o file to the CONFIG_FB_ATY rule.

Here's a better fix. It was a part of my swcursor patch which was=20
partially included. Looks like Alex accidentally dropped this part.


Fix atyfb cursor problems:
- oops with noaccel option
- CONFIG_FB_ATY_CT dependency problem

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---

 atyfb_base.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Nur a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base=
.c
--- a/drivers/video/aty/atyfb_base.c	2004-11-02 15:20:23.199495000 +0200
+++ b/drivers/video/aty/atyfb_base.c	2004-11-02 15:22:20.979495000 +0200
@@ -292,7 +292,7 @@
 	.fb_fillrect	=3D atyfb_fillrect,
 	.fb_copyarea	=3D atyfb_copyarea,
 	.fb_imageblit	=3D atyfb_imageblit,
-	.fb_cursor	=3D atyfb_cursor,
+	.fb_cursor	=3D soft_cursor,
 #ifdef __sparc__
 	.fb_mmap	=3D atyfb_mmap,
 #endif

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
