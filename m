From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Console unregistration questions
Date: Wed, 25 Apr 2007 09:17:13 +0800
Message-ID: <1177463833.4829.20.camel@daplas>
References: <200704241459.29297.jbarnes@virtuousgeek.org>
	<1177456787.10465.29.camel@daplas> <1177458135.4829.5.camel@daplas>
	<200704241646.34556.jbarnes@virtuousgeek.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-w5MDvzoxd17wdnJVBGpJ"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HgW8I-000611-Aw for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 24 Apr 2007 18:17:22 -0700
Received: from qb-out-0506.google.com ([72.14.204.233])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HgW8G-0007Dq-SF
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 24 Apr 2007 18:17:22 -0700
Received: by qb-out-0506.google.com with SMTP id a16so5667396qbd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 24 Apr 2007 18:17:20 -0700 (PDT)
In-Reply-To: <200704241646.34556.jbarnes@virtuousgeek.org>
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
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Dave Airlie <airlied@linux.ie>, Jakob Bornecrantz <wallbraker@gmail.com>, linux-fbdev-devel@lists.sourceforge.net


--=-w5MDvzoxd17wdnJVBGpJ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2007-04-24 at 16:46 -0700, Jesse Barnes wrote:
> On Tuesday, April 24, 2007, Antonino A. Daplas wrote:
> > > >  Also, shouldn't callers of
> > > > unregister_con_driver be checking return values?  That would have
> > > > made this bug a lot easier to find at least. :)
> >
> > Replying to myself:
> >
> > At this point, if unregister_con_driver() fails, it is too late for
> > fbcon, the best thing to do is issue a BUG().
> 
> I guess there's no way to propagate the error back to 
> unregister_framebuffer?  If we did, then it could return -EBUSY or 
> something, keeping the module loaded instead of unsafely allowing it to be 
> removed...
> 
> > However, I'll add extra code to unregister_framebuffer() that will check
> > if it's safe for the driver to unload.  The drivers may then choose to
> > check it or not.
> 
> Sounds good.
> 

Here's a test patch.  Basically, it checks if the driver is still mapped
to the console, and if it is, unregister_framebuffer() will exit
immediately.  As mentioned, it's untested, so let me know if there are
problems.

Note, the driver must also do its part, by checking if the driver is
opened by something in userspace.

Tony


--=-w5MDvzoxd17wdnJVBGpJ
Content-Disposition: attachment; filename=safe_unregister.diff
Content-Type: text/x-patch; name=safe_unregister.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 34ec0ef..f424adb 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -3100,6 +3100,8 @@ static int fbcon_event_notify(struct not
 	case FB_EVENT_NEW_MODELIST:
 		fbcon_new_modelist(info);
 		break;
+	case FB_EVENT_FB_UNREGISTER_SAFE:
+		ret = search_fb_in_map(info->node);
 	}
 
 done:
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index cd14079..8e878e6 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1362,6 +1362,10 @@ unregister_framebuffer(struct fb_info *f
 	if (!registered_fb[i])
 		return -EINVAL;
 
+	event.info = fb_info;
+	if (fb_notifier_call_chain(FB_EVENT_FB_UNREGISTER_SAFE, &event))
+		return -EINVAL;
+	
 	if (fb_info->pixmap.addr &&
 	    (fb_info->pixmap.flags & FB_PIXMAP_DEFAULT))
 		kfree(fb_info->pixmap.addr);
diff --git a/include/linux/fb.h b/include/linux/fb.h
index ecb8bc6..e955865 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -527,6 +527,8 @@ #define FB_EVENT_NEW_MODELIST           
 #define FB_EVENT_MODE_CHANGE_ALL	0x0B
 /*	A software display blank change occured */
 #define FB_EVENT_CONBLANK               0x0C
+/*      Check if it's safe to unregister */
+#define FB_EVENT_FB_UNREGISTER_SAFE     0x0D
 
 struct fb_event {
 	struct fb_info *info;

--=-w5MDvzoxd17wdnJVBGpJ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--=-w5MDvzoxd17wdnJVBGpJ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--=-w5MDvzoxd17wdnJVBGpJ--
