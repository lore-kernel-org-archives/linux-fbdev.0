From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: video: Get the default mode from the right database
Date: Tue, 3 Oct 2006 09:07:23 -0600
Message-ID: <20061003150723.GG7716@cosmic.amd.com>
References: <20061002225738.GD7716@cosmic.amd.com>
	<Pine.LNX.4.62.0610030901070.28197@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="E39vaYmALEf/7YXx"
Return-path: <devel-bounces@laptop.org>
In-Reply-To: <Pine.LNX.4.62.0610030901070.28197@pademelon.sonytel.be>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, devel@laptop.org


--E39vaYmALEf/7YXx
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On 03/10/06 09:04 +0200, Geert Uytterhoeven wrote:
> >      if (!default_mode)
> > -	default_mode = &modedb[DEFAULT_MODEDB_INDEX];
> > +	default_mode = &db[DEFAULT_MODEDB_INDEX];
> >      if (!default_bpp)
> >  	default_bpp = 8;
> 
> Although currently DEFAULT_MODEDB_INDEX is defined to be 0, perhaps we need a
> more rigorous check now it may apply to the custom video mode database?
> Probably you always want the first mode of your custom video mode database to
> be the default?

Indeed.  I'm not sure how many people out there actually change
DEFAULT_MODEDB_INDEX to be non zero, but can't think of a reason why the
default shouldn't just always use the first index in the database.  

At least, thats the way I thought fb_find_mode() worked before I looked into 
the internals. Still, there might be some people attached to 
DEFAULT_MODEDB_INDEX, so I've attached a new patch that should make everybody 
happy.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>

--E39vaYmALEf/7YXx
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

 drivers/video/modedb.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
index d126790..4c04413 100644
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -505,8 +505,11 @@ int fb_find_mode(struct fb_var_screeninf
 	db = modedb;
 	dbsize = ARRAY_SIZE(modedb);
     }
-    if (!default_mode)
+    if (!default_mode && db != modedb)
+	default_mode = &db[0];
+    else
 	default_mode = &modedb[DEFAULT_MODEDB_INDEX];
+
     if (!default_bpp)
 	default_bpp = 8;
 

--E39vaYmALEf/7YXx
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Devel mailing list
Devel@laptop.org
http://mailman.laptop.org/mailman/listinfo/devel

--E39vaYmALEf/7YXx--
