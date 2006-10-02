From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: [PATCH] video: Get the default mode from the right database
Date: Mon, 2 Oct 2006 16:57:38 -0600
Message-ID: <20061002225738.GD7716@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary=OXfL5xGRrasGEqWY
Return-path: <devel-bounces@laptop.org>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://mailman.laptop.org/mailman/listinfo/devel>,
	<mailto:devel-request@laptop.org?subject=unsubscribe>
List-Archive: <http://mailman.laptop.org/pipermail/devel>
List-Post: <mailto:devel@laptop.org>
List-Help: <mailto:devel-request@laptop.org?subject=help>
List-Subscribe: <http://mailman.laptop.org/mailman/listinfo/devel>,
	<mailto:devel-request@laptop.org?subject=subscribe>
Sender: devel-bounces@laptop.org
Errors-To: devel-bounces@laptop.org
To: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, devel@laptop.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

fb_find_mode() is behaving in an non-intuitive way.  When I specify my
own video mode database, and no default mode, I would have expected it
to assume the first mode in my database as the default mode.  Instead, it
uses the built in database:

> if (!db) {
>     db = modedb;
>     dbsize = ARRAY_SIZE(modedb);
> }
> if (!default_mode)
>     default_mode = &modedb[DEFAULT_MODEDB_INDEX];

Personally, I think this is incorrect - if an alternate database is
specified, it should be always using that.  Patch is attached.

Regards,
Jordan

-- 
Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>

--OXfL5xGRrasGEqWY
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline;
 filename=modedb-fix.patch
Content-Transfer-Encoding: 7bit

[PATCH] video: Get the default mode from the right database

From: Jordan Crouse <jordan.crouse@amd.com>

If no default mode is specified, it should be grabbed from the supplied
database, not the default one.  

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 drivers/video/modedb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
index d126790..e068f52 100644
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -506,7 +506,7 @@ int fb_find_mode(struct fb_var_screeninf
 	dbsize = ARRAY_SIZE(modedb);
     }
     if (!default_mode)
-	default_mode = &modedb[DEFAULT_MODEDB_INDEX];
+	default_mode = &db[DEFAULT_MODEDB_INDEX];
     if (!default_bpp)
 	default_bpp = 8;
 

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Devel mailing list
Devel@laptop.org
http://mailman.laptop.org/mailman/listinfo/devel

--OXfL5xGRrasGEqWY--
