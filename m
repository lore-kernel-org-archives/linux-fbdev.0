From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] add new Cobalt LCD framebuffer
	driver
Date: Wed, 16 Jul 2008 17:31:54 -0700
Message-ID: <20080716173154.8cb87400.akpm@linux-foundation.org>
References: <20080715222751.86091a71.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KJHPm-0003Tg-Tg for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 Jul 2008 17:32:10 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KJHPm-0001JS-JM
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 Jul 2008 17:32:10 -0700
In-Reply-To: <20080715222751.86091a71.yoichi_yuasa@tripeaks.co.jp>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
Cc: adaplas@pol.net, linux-mips@linux-mips.org, linux-fbdev-devel@lists.sourceforge.net, ralf@linux-mips.org, yoichi_yuasa@tripeaks.co.jp

On Tue, 15 Jul 2008 22:27:51 +0900
Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:

> I update cobalt_lcdfb driver.
> 
> v3
> - fix read/write count boundary check.
> - add <include/uaccess.h>.
> - fix MODULE_AUTHOR.
> 
> v2
> - add dpends MIPS_COBALT in Kconfig.
> - add handling of signal_pending().
> - check overflow of read/write count.
> 
> v1
> - first release.

This driver has been merged into the subsystem tree for a long time and
has been reviewed and has been perhaps tested by others.  Sending a
complete new version of the entire thing is really quite an unfriendly
act.  It basically invalidates all the review and test work which
everyone else has done.

This is why I will almost always turn replacement patches into
incremental patches - so I can see what changed.  But that's only good
for me.  Everyone else who is reading your new version won't bother
doing that.


So I generated the incremental patch and:

- The driver I have already includes linux/uaccess.h, so that change
  was unneeded.

- The driver I have has already fixed the reject in
  drivers/video/Makefile, so I get to fix it again, ho hum.

Here's what I ended up committing:

 drivers/video/Kconfig        |    2 +-
 drivers/video/cobalt_lcdfb.c |   24 ++++++++++++++++++------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff -puN drivers/video/Kconfig~add-new-cobalt-lcd-framebuffer-driver drivers/video/Kconfig
--- a/drivers/video/Kconfig~add-new-cobalt-lcd-framebuffer-driver
+++ a/drivers/video/Kconfig
@@ -1989,7 +1989,7 @@ config FB_AM200EPD
 
 config FB_COBALT
 	tristate "Cobalt server LCD frame buffer support"
-	depends on FB
+	depends on FB && MIPS_COBALT
 
 config FB_VIRTUAL
 	tristate "Virtual Frame Buffer support (ONLY FOR TESTING!)"
diff -puN drivers/video/Makefile~add-new-cobalt-lcd-framebuffer-driver drivers/video/Makefile
diff -puN drivers/video/cobalt_lcdfb.c~add-new-cobalt-lcd-framebuffer-driver drivers/video/cobalt_lcdfb.c
--- a/drivers/video/cobalt_lcdfb.c~add-new-cobalt-lcd-framebuffer-driver
+++ a/drivers/video/cobalt_lcdfb.c
@@ -137,13 +137,16 @@ static ssize_t cobalt_lcdfb_read(struct 
 {
 	char src[LCD_CHARS_MAX];
 	unsigned long pos;
-	int len, retval;
+	int len, retval = 0;
 
 	pos = *ppos;
-	if (pos >= LCD_CHARS_MAX)
+	if (pos >= LCD_CHARS_MAX || count == 0)
 		return 0;
 
-	if (pos + count >= LCD_CHARS_MAX)
+	if (count > LCD_CHARS_MAX)
+		count = LCD_CHARS_MAX;
+
+	if (pos + count > LCD_CHARS_MAX)
 		count = LCD_CHARS_MAX - pos;
 
 	for (len = 0; len < count; len++) {
@@ -164,6 +167,9 @@ static ssize_t cobalt_lcdfb_read(struct 
 			pos++;
 	}
 
+	if (retval < 0 && signal_pending(current))
+		return -ERESTARTSYS;
+
 	if (copy_to_user(buf, src, len))
 		return -EFAULT;
 
@@ -177,13 +183,16 @@ static ssize_t cobalt_lcdfb_write(struct
 {
 	char dst[LCD_CHARS_MAX];
 	unsigned long pos;
-	int len, retval;
+	int len, retval = 0;
 
 	pos = *ppos;
-	if (pos >= LCD_CHARS_MAX)
+	if (pos >= LCD_CHARS_MAX || count == 0)
 		return 0;
 
-	if (pos + count >= LCD_CHARS_MAX)
+	if (count > LCD_CHARS_MAX)
+		count = LCD_CHARS_MAX;
+
+	if (pos + count > LCD_CHARS_MAX)
 		count = LCD_CHARS_MAX - pos;
 
 	if (copy_from_user(dst, buf, count))
@@ -207,6 +216,9 @@ static ssize_t cobalt_lcdfb_write(struct
 			pos++;
 	}
 
+	if (retval < 0 && signal_pending(current))
+		return -ERESTARTSYS;
+
 	*ppos += len;
 
 	return len;
_


and I'm a bit uncertain about it.

- the test for (count > LCD_CHARS_MAX) appear to be unneeded, given
  the follwing test for (pos + count > LCD_CHARS_MAX).

  Or perhaps it is an obscure test for very large tests of `count',
  which would cause overflows in `count+pos'?  Can it all be simplified?

- Do we need to test for `count == 0'?  I have a feeling that this
  case is handled at the higher levels of read(), but I cannot find
  that piece of code at present.  Perhaps I dreamed it.



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
