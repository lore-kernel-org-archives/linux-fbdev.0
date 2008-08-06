From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: [RFC] double buffering for atmel_lcdfb
Date: Wed, 6 Aug 2008 11:36:16 +0200
Message-ID: <200808061136.16783.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QCXmIwNJwQtzN6i"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQfRh-0008JU-6m for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 02:36:41 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KQfRe-0005eI-0w
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 02:36:41 -0700
Received: from ebg226.internetdsl.tpnet.pl (HELO staszek-desktop.local)
	(stf_xl@wp.pl@[83.14.136.226]) (envelope-sender <stf_xl@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with AES256-SHA encrypted SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>; 6 Aug 2008 11:36:22 +0200
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net, Nicolas Ferre <nicolas.ferre@atmel.com>

--Boundary-00=_QCXmIwNJwQtzN6i
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello.

I try to implement double buffering for Atmel LCD display on AT91SAM9263 based 
board. I could not find any document about panning display on linux 
framebuffer, so I have some question about it and generic question about 
double buffer design. 

1) Is FBIOPAN_DISPLAY ioctl right way to implement double buffering?

2) What is the difference between ypanstep and ywrapstep, which one should be 
used for double buffering.

3) Does double buffer stuff should be turned on using module parameter, 
compile time parameter, board specific parameter (flag from platform device).
As it consume 2x memory I don't thing anyone want it by default.

I think double buffer for Atmel LCD should go mainline, of course after doing 
it reliable. After your comments and advice, I think I will be able to send 
right done and signed-off patch. 

Below is patch I have already done. I also attached program which I used for 
for tests - as far result are quite nice.

Cheers
Stanislaw Gruszka

diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index b004036..d0b2bed 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -7,7 +7,6 @@
  * License.  See the file COPYING in the main directory of this archive for
  * more details.
  */
-
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
@@ -41,6 +40,8 @@
 #if defined(CONFIG_ARCH_AT91)
 #define	ATMEL_LCDFB_FBINFO_DEFAULT	FBINFO_DEFAULT
 
+static int double_buffering = 1;
+
 static inline void atmel_lcdfb_update_dma2d(struct atmel_lcdfb_info *sinfo,
 					struct fb_var_screeninfo *var)
 {
@@ -789,7 +790,13 @@ static int __init atmel_lcdfb_probe(struct 
platform_device *pdev)
 		 * Don't clear the framebuffer -- someone may have set
 		 * up a splash image.
 		 */
+		double_buffering = 0;
+ 		dev_info(dev, "dissable double buffering\n");
 	} else {
+ 		if (double_buffering) {
+ 			info->fix.ypanstep = info->var.yres_virtual;
+ 			info->var.yres_virtual *= 2;
+		}
 		/* alocate memory buffer */
 		ret = atmel_lcdfb_alloc_video_memory(sinfo);
 		if (ret < 0) {

--Boundary-00=_QCXmIwNJwQtzN6i
Content-Type: text/x-csrc;
  charset="utf-8";
  name="fbtest1.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fbtest1.c"

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <string.h>

#include <linux/fb.h>
#include <sys/mman.h>
#include <sys/ioctl.h>

int framebuffer_fd;
unsigned char *framebuffer_mem;
struct fb_var_screeninfo vinfo;
struct fb_fix_screeninfo finfo;

inline void perror_exit(char msg[])
{
	perror(msg);
	exit(1);
}

void draw_pixel(int x, int y, int r, int g, int b)
{
	unsigned int loc = (y+vinfo.yoffset) * finfo.line_length + (x+vinfo.xoffset) * vinfo.bits_per_pixel/8;
	unsigned char *ptr = framebuffer_mem;

	if (vinfo.bits_per_pixel == 16) {
		unsigned short pixel = r<<11 | g << 5 | b;
		*((unsigned int*)(ptr + loc)) = pixel;
     	} else if (vinfo.bits_per_pixel == 24) {
		*(ptr + loc + 0) = r;
		*(ptr + loc + 1) = g;
		*(ptr + loc + 2) = b;
	} else {
		fprintf(stderr, "Unsupported bits per pixel\n");
		exit(1);
	}
}

void blink_single_buf(void)
{
	unsigned int i, x, y;
	printf("Blinked screen with single buffer ... "); fflush(stdout);
	for (i = 0; i < 10; i++) {
		if (i & 1) {
			for (y = 0; y < vinfo.yres; y++)
        		for (x = 0; x < vinfo.xres; x++)
				draw_pixel(x, y, 0, 0, 31);
		} else {
			for (y = 0; y < vinfo.yres; y++)
        		for (x = 0; x < vinfo.xres; x++)
				draw_pixel(x, y, 31, 0, 0);
		}
		usleep(100*1000);
	}
	printf("done\n"); fflush(stdout);
}

void blink_double_buf(void)
{
	unsigned int i, x, y;
	printf("Blinked screen with double buffer ... "); fflush(stdout);
	for (i = 0; i < 10; i++) {
		if (vinfo.yoffset == vinfo.yres) {
			vinfo.yoffset = 0;
			for (y = 0; y < vinfo.yres; y++)
        		for (x = 0; x < vinfo.xres; x++)
				draw_pixel(x, y, 0, 0, 31);
    			if (ioctl(framebuffer_fd, FBIOPAN_DISPLAY, &vinfo))
				perror_exit("ioctl 1");
		} else {
			vinfo.yoffset = vinfo.yres;
			for (y = 0; y < vinfo.yres; y++)
        		for (x = 0; x < vinfo.xres; x++)
				draw_pixel(x, y, 31, 0, 0);
	    		if (ioctl(framebuffer_fd, FBIOPAN_DISPLAY, &vinfo))
				perror_exit("ioctl 2");
		}
		usleep(100*1000);
	}
	printf("done\n"); fflush(stdout);
}

int main(int argc, char *argv[])
{
	unsigned int scrsize;
	unsigned int x, y;
 
	framebuffer_fd = open("/dev/fb0", O_RDWR);
	if (!framebuffer_fd < 0)
        	perror_exit("open framebuffer device");

	if (ioctl(framebuffer_fd, FBIOGET_FSCREENINFO, &finfo))
       		perror_exit("ioctl(FBIOGET_FSCREENINFO)");

 	if (ioctl(framebuffer_fd, FBIOGET_VSCREENINFO, &vinfo))
        	perror_exit("ioctl(FBIOGET_VSCREENINFO)");
	
    	scrsize = vinfo.xres * vinfo.yres * vinfo.bits_per_pixel / 8;
    	printf("%dx%d virt(%dx%d), %dbpp, scrsize %u smem_len %u\n",
		vinfo.xres, vinfo.yres,
        	vinfo.xres_virtual, vinfo.yres_virtual,
		vinfo.bits_per_pixel, scrsize, finfo.smem_len);
	if (finfo.smem_len < 2*scrsize) {
		fprintf(stderr, "double buffering not supported by framebuffer!\n");
		return 1;
	}

	framebuffer_mem = (unsigned char *)mmap(0, finfo.smem_len,
						PROT_READ | PROT_WRITE, MAP_SHARED,
						framebuffer_fd, 0);
    	if ((long)framebuffer_mem == -1)
        	perror_exit("mmap");
    
    	for (y = 0; y < vinfo.yres; y++)
        for (x = 0; x < vinfo.xres; x++)
		draw_pixel(x, y, 0xff, 0xff, 0xff);

	blink_single_buf();
    	blink_double_buf();
	return 0;
}


--Boundary-00=_QCXmIwNJwQtzN6i
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--Boundary-00=_QCXmIwNJwQtzN6i
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--Boundary-00=_QCXmIwNJwQtzN6i--
