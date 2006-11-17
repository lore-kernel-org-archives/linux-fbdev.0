From: Andrew Morton <akpm@osdl.org>
Subject: Re: fb: modedb uses wrong default_mode
Date: Fri, 17 Nov 2006 12:40:13 -0800
Message-ID: <20061117124013.b6e4183d.akpm@osdl.org>
References: <Pine.LNX.4.64.0611151933070.12799@jalava.cc.jyu.fi>
	<20061115152952.0e92c50d.akpm@osdl.org>
	<20061115234456.GB3674@cosmic.amd.com>
	<Pine.LNX.4.64.0611171919090.9851@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GlAVj-0003XB-4Y for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Nov 2006 12:40:31 -0800
Received: from smtp.osdl.org ([65.172.181.25])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GlAVh-0007ea-PC
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Nov 2006 12:40:31 -0800
In-Reply-To: <Pine.LNX.4.64.0611171919090.9851@pentafluge.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: James Simmons <jsimmons@infradead.org>
Cc: Tero Roponen <teanropo@jyu.fi>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Fri, 17 Nov 2006 20:08:47 +0000 (GMT)
James Simmons <jsimmons@infradead.org> wrote:

> Who knows how many drivers get this wrong. BTW Jordan is right. 
> DEFAULT_MODEDB_INDEX is unless. Also we don't need dbsize anymore. 
> Jordan did point out a error in fb_find_mode. It should be
> 
> 	if (!db)
> 	    db = modedb;
> 	dbsize = ARRAY_SIZE(modedb);
> 
> 	if (!default_mode)
> 	    default_mode = &db[DEFAULT_MODEDB_INDEX];
> 	if (!default_bpp)
> 	    default_bpp = 8;
> 
> db will always be set.

I think we do need dbsize, and that the code which I have now:

int fb_find_mode(struct fb_var_screeninfo *var,
		 struct fb_info *info, const char *mode_option,
		 const struct fb_videomode *db, unsigned int dbsize,
		 const struct fb_videomode *default_mode,
		 unsigned int default_bpp)
{
    int i;

    /* Set up defaults */
    if (!db) {
	db = modedb;
	dbsize = ARRAY_SIZE(modedb);
    }

    if (!default_mode)
	default_mode = &db[0];

    if (!default_bpp)
	default_bpp = 8;


is appropriate?


Here's the current version of this monster patch:

From: Jordan Crouse <jordan.crouse@amd.com>

If no default mode is specified, it should be grabbed from the supplied
database, not the default one.

[teanropo@jyu.fi: fix it]
[akpm@osdl.org: simplify it]
[akpm@osdl.org: remove pointless DEFAULT_MODEDB_INDEX]
Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Antonino A. Daplas" <adaplas@pol.net>
Signed-off-by: Tero Roponen <teanropo@jyu.fi>
Cc: James Simmons <jsimmons@infradead.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/video/modedb.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/video/modedb.c~video-get-the-default-mode-from-the-right-database drivers/video/modedb.c
--- a/drivers/video/modedb.c~video-get-the-default-mode-from-the-right-database
+++ a/drivers/video/modedb.c
@@ -34,8 +34,6 @@ const char *global_mode_option;
      *  Standard video mode definitions (taken from XFree86)
      */
 
-#define DEFAULT_MODEDB_INDEX	0
-
 static const struct fb_videomode modedb[] = {
     {
 	/* 640x400 @ 70 Hz, 31.5 kHz hsync */
@@ -505,8 +503,10 @@ int fb_find_mode(struct fb_var_screeninf
 	db = modedb;
 	dbsize = ARRAY_SIZE(modedb);
     }
+
     if (!default_mode)
-	default_mode = &modedb[DEFAULT_MODEDB_INDEX];
+	default_mode = &db[0];
+
     if (!default_bpp)
 	default_bpp = 8;
 
_


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
