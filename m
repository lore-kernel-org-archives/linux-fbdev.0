From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 08 Nov 2013 10:05:55 +0000
Subject: re: video: Add Aeroflex Gaisler GRVGA framebuffer device driver
Message-Id: <20131108100555.GV27977@elgon.mountain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello Kristoffer Glembo,

This is a semi-automatic email about new static checker warnings.

The patch a4b8f97a8fde: "video: Add Aeroflex Gaisler GRVGA 
framebuffer device driver" from Jul 5, 2011, leads to the following 
Smatch complaint:

drivers/video/grvga.c:519 grvga_remove()
	 warn: variable dereferenced before check 'info' (see line 517)

drivers/video/grvga.c
   516		struct fb_info *info = dev_get_drvdata(&device->dev);
   517		struct grvga_par *par = info->par;
                                        ^^^^^^^^^
Dereference.

   518	
   519		if (info) {
                   ^^^^^^
Check.

   520			unregister_framebuffer(info);
   521			fb_dealloc_cmap(&info->cmap);

regards,
dan carpenter
