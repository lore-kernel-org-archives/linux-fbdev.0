From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Re: [PATCH] fbdev: colormap fixes
Date: Thu, 28 Jul 2005 22:50:53 +0800
Message-ID: <42E8F0CD.6070500@gmail.com>
References: <200507280031.j6S0V3L3016861@hera.kernel.org>	 <Pine.LNX.4.62.0507280952140.24391@numbat.sonytel.be> <9e473391050728060741040424@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dy9ix-0003jd-Nz
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Jul 2005 07:51:03 -0700
Received: from wproxy.gmail.com ([64.233.184.206])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Dy9ix-0006Tt-2c
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Jul 2005 07:51:03 -0700
Received: by wproxy.gmail.com with SMTP id 36so413447wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 28 Jul 2005 07:50:50 -0700 (PDT)
In-Reply-To: <9e473391050728060741040424@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>

Jon Smirl wrote:
> On 7/28/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Wed, 27 Jul 2005, Linux Kernel Mailing List wrote:
> 
> There are a couple of ways to fix this. 
> 
> 1) Add a check to limit use of the sysfs attributes to 256 entries. If
> you want more you have to use /dev/fb0 and the ioctl. More is an
> uncommon case.
> 2) Switch this to a binary parameter. Now you have to use tools like
> hexdump instead of cat to work with the data. It was nice to be able
> to use cat to see the current map.
> 
> Does anyone have preferences for which way to fix it?

Or...

  3) Add another file in sysfs which specifies at what index and how many
entries will be read or written from or to the cmap. With this additional
sysfs file, it should be able to handle any reasonable cmap length, but
it will take more than one reading of the color_map file. Another
advantage is that the entire color map need not be read or written if
only one field needs to be changed.

I've attached a test patch.  Let me know what you think.

Tony

    The functions store_cmap and show_cmap assume that cmap entries will never
    exceed 256.  However, even on the i386 graphics cards exist with 10-bit
    DAC's. The current functions are insufficient on these hardware.

    In order to provide support > 256 entries, a new sysfs entry is introduced -
    cmap_range.  It consists of two fields separated by a comma. The first field
    sets the starting index, and the second field, the number of entries. Thus,
    to grab a 256 color map in a machine with pagesize = 4096, one might do
    the ff:

        echo 0,128 > cmap_entry
        cat color_map
        echo 128,128 > cmap_entry
        cat color_map

    It also makes the function more efficient since one can alter a single entry
    without reading/writing the entire cmap.

    The output of color_map is also changed to accomodate the transparency field,
    and also to increase readability.

    iiii. tttt rrrr gggg bbbb
    iiii. tttt rrrr gggg bbbb

    where i = index;
          t = transparency;
          r = red;
          g = green;
          b = blue;

    From: Antonino Daplas <adaplas@pol.net>
    Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 drivers/video/fbsysfs.c |  172 ++++++++++++++++++++++++++++++++----------------
 include/linux/fb.h      |    2
 2 files changed, 117 insertions(+), 57 deletions(-)

--- a/drivers/video/fbsysfs.c
+++ b/drivers/video/fbsysfs.c
@@ -242,95 +242,152 @@ static ssize_t show_virtual(struct class
 			fb_info->var.yres_virtual);
 }
 
-/* Format for cmap is "%02x%c%4x%4x%4x\n" */
-/* %02x entry %c transp %4x red %4x blue %4x green \n */
-/* 255 rows at 16 chars equals 4096 */
-/* PAGE_SIZE can be 4096 or larger */
+/* Format for cmap is "%4x. %4x %4x %4x %4x\n" */
+/* %4x. index %4x transp %4x red %4x green %4x blue \n */
 static ssize_t store_cmap(struct class_device *class_device, const char *buf,
 			  size_t count)
 {
-	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
-	int rc, i, start, length, transp = 0;
-
-	if ((count > 4096) || ((count % 16) != 0) || (PAGE_SIZE < 4096))
-		return -EINVAL;
+	struct fb_info *fb_info = class_get_devdata(class_device);
+	int rc = 0, i, length, start = fb_info->cmap_start;
 
 	if (!fb_info->fbops->fb_setcolreg && !fb_info->fbops->fb_setcmap)
 		return -EINVAL;
 
-	sscanf(buf, "%02x", &start);
-	length = count / 16;
+	length = count/26;
 
-	for (i = 0; i < length; i++)
-		if (buf[i * 16 + 2] != ' ')
-			transp = 1;
+	if (start + length > fb_info->cmap.len || length > fb_info->cmap_len)
+		return -EINVAL;
 
+	acquire_console_sem();
+	
 	/* If we can batch, do it */
 	if (fb_info->fbops->fb_setcmap && length > 1) {
 		struct fb_cmap umap;
 
 		memset(&umap, 0, sizeof(umap));
-		if ((rc = fb_alloc_cmap(&umap, length, transp)))
-			return rc;
 
-		umap.start = start;
-		for (i = 0; i < length; i++) {
-			sscanf(&buf[i * 16 +  3], "%4hx", &umap.red[i]);
-			sscanf(&buf[i * 16 +  7], "%4hx", &umap.blue[i]);
-			sscanf(&buf[i * 16 + 11], "%4hx", &umap.green[i]);
-			if (transp)
-				umap.transp[i] = (buf[i * 16 +  2] != ' ');
+		rc = fb_alloc_cmap(&umap, length, 1);
+		
+		if (!rc) {
+			umap.start = start;
+
+			for (i = 0; i < length; i++) {
+				sscanf(&buf[i*26+06], "%4hx", &umap.transp[i]);
+				sscanf(&buf[i*26+11], "%4hx", &umap.red[i]);
+				sscanf(&buf[i*26+16], "%4hx", &umap.green[i]);
+				sscanf(&buf[i*26+21], "%4hx", &umap.blue[i]);
+			}
+			
+			rc = fb_info->fbops->fb_setcmap(&umap, fb_info);
+			fb_copy_cmap(&umap, &fb_info->cmap);
+			fb_dealloc_cmap(&umap);
 		}
-		rc = fb_info->fbops->fb_setcmap(&umap, fb_info);
-		fb_copy_cmap(&umap, &fb_info->cmap);
-		fb_dealloc_cmap(&umap);
-
-		return rc;
-	}
-	for (i = 0; i < length; i++) {
+			
+	} else {
 		u16 red, blue, green, tsp;
 
-		sscanf(&buf[i * 16 +  3], "%4hx", &red);
-		sscanf(&buf[i * 16 +  7], "%4hx", &blue);
-		sscanf(&buf[i * 16 + 11], "%4hx", &green);
-		tsp = (buf[i * 16 +  2] != ' ');
-		if ((rc = fb_info->fbops->fb_setcolreg(start++,
-				      red, green, blue, tsp, fb_info)))
-			return rc;
-
-		fb_info->cmap.red[i] = red;
-		fb_info->cmap.blue[i] = blue;
-		fb_info->cmap.green[i] = green;
-		if (transp)
-			fb_info->cmap.transp[i] = tsp;
+		for (i = 0; i < length; i++) {
+			sscanf(&buf[i * 26 +  6], "%4hx", &tsp);
+			sscanf(&buf[i * 26 + 11], "%4hx", &red);
+			sscanf(&buf[i * 26 + 16], "%4hx", &green);
+			sscanf(&buf[i * 26 + 21], "%4hx", &blue);
+			
+			rc = fb_info->fbops->fb_setcolreg(start++, red, green,
+							  blue, tsp, fb_info);
+			if (rc)
+				break;
+
+			fb_info->cmap.red[i] = red;
+			fb_info->cmap.blue[i] = blue;
+			fb_info->cmap.green[i] = green;
+			if (fb_info->cmap.transp)
+				fb_info->cmap.transp[i] = tsp;
+		}
 	}
-	return 0;
+
+	release_console_sem();
+	return rc;
 }
 
 static ssize_t show_cmap(struct class_device *class_device, char *buf)
 {
-	struct fb_info *fb_info =
-		(struct fb_info *)class_get_devdata(class_device);
-	unsigned int i;
+	struct fb_info *fb_info = class_get_devdata(class_device);
+	unsigned int i, start;
+	u16 transp = 1;
 
 	if (!fb_info->cmap.red || !fb_info->cmap.blue ||
 	   !fb_info->cmap.green)
 		return -EINVAL;
 
-	if (PAGE_SIZE < 4096)
-		return -EINVAL;
+	if (!fb_info->cmap.transp)
+		transp = 0;
+	
+	acquire_console_sem();
+	start = fb_info->cmap_start;
 
-	/* don't mess with the format, the buffer is PAGE_SIZE */
-	/* 255 entries at 16 chars per line equals 4096 = PAGE_SIZE */
-	for (i = 0; i < fb_info->cmap.len; i++) {
-		sprintf(&buf[ i * 16], "%02x%c%4x%4x%4x\n", i + fb_info->cmap.start,
-			((fb_info->cmap.transp && fb_info->cmap.transp[i]) ? '*' : ' '),
-			fb_info->cmap.red[i], fb_info->cmap.blue[i],
-			fb_info->cmap.green[i]);
+	if (start + fb_info->cmap_len <= fb_info->cmap.len) {
+		/* each row is 26 bytes */
+		for (i = 0; i < fb_info->cmap_len; i++) {
+			sprintf(&buf[i * 26], "%04x. %04x %04x %04x %04x\n",
+				i + fb_info->cmap_start,
+				(!transp) ? 0 : fb_info->cmap.transp[i+start],
+				fb_info->cmap.red[i+start],
+				fb_info->cmap.green[i+start],
+				fb_info->cmap.blue[i+start]);
+		}
 	}
-	return 4096;
+
+	i = fb_info->cmap_len * 26;
+	release_console_sem();
+
+	return i;
 }
 
+static ssize_t show_cmap_range(struct class_device *class_device, char *buf)
+{
+	struct fb_info *fb_info = class_get_devdata(class_device);
+	
+	return snprintf(buf, PAGE_SIZE, "%d,%d\n", fb_info->cmap_start,
+			fb_info->cmap_len);
+}
+
+static ssize_t store_cmap_range(struct class_device *class_device,
+				const char *buf, size_t count)
+{
+	struct fb_info *fb_info = class_get_devdata(class_device);
+	char *last = NULL;
+	int start, len, err = 1;
+
+	start = simple_strtoul(buf, &last, 0);
+	last++;
+
+	if (last - buf < count) {
+		len = simple_strtoul(last, &last, 0);
+		err = 0;
+	}
+
+	if (!err) {
+		if (len > 0x10000)
+			len = 0x10000;
+
+		if (len > PAGE_SIZE/26)
+			len = PAGE_SIZE/26;
+
+		if (start > fb_info->cmap.len - 1)
+			start = 0;
+
+		if (len > fb_info->cmap.len - start) 
+			len = fb_info->cmap.len - start;
+
+		acquire_console_sem();
+		fb_info->cmap_start = start;
+		fb_info->cmap_len = len;
+		release_console_sem();
+	}
+
+	return count;
+}
+	
 static ssize_t store_blank(struct class_device *class_device, const char * buf,
 			   size_t count)
 {
@@ -424,6 +481,7 @@ static struct class_device_attribute cla
 	__ATTR(modes, S_IRUGO|S_IWUSR, show_modes, store_modes),
 	__ATTR(pan, S_IRUGO|S_IWUSR, show_pan, store_pan),
 	__ATTR(virtual_size, S_IRUGO|S_IWUSR, show_virtual, store_virtual),
+	__ATTR(cmap_range, S_IRUGO|S_IWUSR, show_cmap_range, store_cmap_range),
 };
 
 int fb_init_class_device(struct fb_info *fb_info)
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -720,6 +720,8 @@ struct fb_info {
 	struct fb_pixmap pixmap;	/* Image hardware mapper */
 	struct fb_pixmap sprite;	/* Cursor hardware mapper */
 	struct fb_cmap cmap;		/* Current cmap */
+	int    cmap_start;              /* Start of cmap entries to access in sysfs */
+	int    cmap_len;                /* Num of entries to to access in sysfs */
 	struct list_head modelist;      /* mode list */
 	struct fb_videomode *mode;	/* current mode */
 	struct fb_ops *fbops;



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
