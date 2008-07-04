From: Robert Reif <reif@earthlink.net>
Subject: Re: Enabling Hardware acceleration in	existing
 framebuffer driver
Date: Fri, 04 Jul 2008 15:09:35 -0400
Message-ID: <486E756F.4090000@earthlink.net>
References: <486E4812.5070803@linuxinstruments.com>	<20080704182215.6f64f848.krzysztof.h1@poczta.fm>	<486E50F5.5070401@linuxinstruments.com>	<20080704193226.a1750cf8.krzysztof.h1@poczta.fm>
	<20080704182123.GE7132@sci.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020306020101000200090405"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KEqf9-000601-0E for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 Jul 2008 12:09:43 -0700
Received: from pop-sarus.atl.sa.earthlink.net ([207.69.195.72])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KEqf7-0004LK-Gk
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 Jul 2008 12:09:42 -0700
In-Reply-To: <20080704182123.GE7132@sci.fi>
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
To: Krzysztof Helt <krzysztof.h1@poczta.fm>, Keith Williams <espian@linuxinstruments.com>, linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------020306020101000200090405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Ville Syrj=E4l=E4 wrote:
> On Fri, Jul 04, 2008 at 07:32:26PM +0200, Krzysztof Helt wrote:
>  =20
>> On Fri, 04 Jul 2008 12:33:57 -0400
>> Keith Williams <espian@linuxinstruments.com> wrote:
>>
>>    =20
>>> The fillrect was the simplest to implement.  I agree that the others
>>> will be much higher value.
>>>
>>> In DirectFB there are a set of benchmarks that run through all of the
>>> different drawing types including filled rectangles.  That is what I =
am
>>> using as my baseline.
>>>
>>>      =20
>> I don't know DirectFB. I am not sure if the DirectFB uses the frame bu=
ffer
>> acceleration or its own.=20
>>    =20
>
> DirectFB has it's own low level gfx drivers. It can use fbdev for mode
> switching but that's all.
>
> In fact there is no way to call fbdev accel code from userspace.
>
>  =20
I'm adding hardware acceleration to the sparc leo driver and this is=20
what I am using for user space testing:

--------------020306020101000200090405
Content-Type: text/plain;
 name="fbmem.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fbmem.diff.txt"

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 776f7fc..14d5586 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1023,6 +1023,9 @@ fb_ioctl(struct inode *inode, struct fil
 	struct fb_con2fbmap con2fb;
 	struct fb_cmap_user cmap;
 	struct fb_event event;
+	struct fb_copyarea area;
+	struct fb_fillrect rect;
+	struct fb_image image;	
 	void __user *argp = (void __user *)arg;
 	int i;
 	
@@ -1103,6 +1106,27 @@ #endif /* CONFIG_KMOD */
 		info->flags &= ~FBINFO_MISC_USEREVENT;
 		release_console_sem();
 		return i;
+	case FBIOFILLRECT:
+		if (copy_from_user(&rect, argp, sizeof(rect)))
+			return -EFAULT;
+		acquire_console_sem();
+		fb->fb_fillrect(info, &rect);
+		release_console_sem();
+		return 0;
+	case FBIOCOPYAREA:
+		if (copy_from_user(&area, argp, sizeof(area)))
+			return -EFAULT;
+		acquire_console_sem();
+		fb->fb_copyarea(info, &area);
+		release_console_sem();
+		return 0;
+	case FBIOIMAGEBLIT:
+		if (copy_from_user(&image, argp, sizeof(image)))
+			return -EFAULT;
+		acquire_console_sem();
+		fb->fb_imageblit(info, &image);
+		release_console_sem();
+		return 0;
 	default:
 		if (fb->fb_ioctl == NULL)
 			return -EINVAL;
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 72295b0..a369d0f 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -38,6 +38,9 @@ #define FBIOGET_GLYPH           0x4615
 #define FBIOGET_HWCINFO         0x4616
 #define FBIOPUT_MODEINFO        0x4617
 #define FBIOGET_DISPINFO        0x4618
+#define FBIOFILLRECT		0x4619
+#define FBIOCOPYAREA		0x461A
+#define FBIOIMAGEBLIT		0x461B
 
 
 #define FB_TYPE_PACKED_PIXELS		0	/* Packed Pixels	*/

--------------020306020101000200090405
Content-Type: text/plain;
 name="fbtest.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fbtest.diff.txt"

Index: fb.c
===================================================================
RCS file: /cvsroot/linux-fbdev/FBdev/utlilities/fbtest/fb.c,v
retrieving revision 1.7
diff -r1.7 fb.c
30c30
< static int fb_fd = -1;
---
> int fb_fd = -1;
Index: include/fb.h
===================================================================
RCS file: /cvsroot/linux-fbdev/FBdev/utlilities/fbtest/include/fb.h,v
retrieving revision 1.2
diff -r1.2 fb.h
19a20
> extern int fb_fd;
Index: tests/test001.c
===================================================================
RCS file: /cvsroot/linux-fbdev/FBdev/utlilities/fbtest/tests/test001.c,v
retrieving revision 1.1
diff -r1.1 test001.c
11a12
> #include <errno.h>
12a14,16
> #include <stdlib.h>
> #include <string.h>
> #include <sys/ioctl.h>
23a28,29
> #define FBIOFILLRECT	0x4619
> 
28a35,38
>     u8 * screen;
>     u32 bytes;
>     struct fb_fillrect rect;
>     enum test_res res = TEST_OK;
37a48,74
> 
>     bytes = (fb_var.xres * fb_var.yres * fb_var.bits_per_pixel) / 8;
>     if (!(screen = malloc(bytes)))
>         Fatal("malloc %d: %s\n", bytes, strerror(errno));
>     memcpy(screen, fb, bytes);
> 
>     for (i = 1, y0 = 0; i <= Y_BLOCKS; i++, y0 = y1) {
> 	y1 = i*fb_var.yres/Y_BLOCKS;
> 	for (j = 1, x0 = 0; j <= X_BLOCKS; j++, x0 = x1) {
> 	    pixel = (i+j) & 1 ? white_pixel : black_pixel;
> 	    x1 = j*fb_var.xres/X_BLOCKS;
> 	    rect.dx = x0;
> 	    rect.dy = y0;
> 	    rect.width = x1 - x0;
> 	    rect.height = y1 - y0;
> 	    rect.color = (i+j) & 1 ? 15 : 0;
> 	    rect.rop = ROP_COPY;
> 	
> 	    if (ioctl(fb_fd, FBIOFILLRECT, &rect) == -1) {
> 	        Fatal("ioctl FBIOFILLRECT: %s\n", strerror(errno));
> 	    }
> 	}
>     }
> 
>     if (memcmp(screen, fb, bytes) != 0)
> 	res = TEST_FAIL; 
>     free(screen);
39c76
<     return TEST_OK;
---
>     return res;

--------------020306020101000200090405
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
--------------020306020101000200090405
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--------------020306020101000200090405--
