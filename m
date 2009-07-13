From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/2] fbdev: add fillrect and copyarea ioctls
Date: Mon, 13 Jul 2009 20:53:12 +0200
Message-ID: <200907132053.13032.arnd@arndb.de>
References: <20090713151709.GA1297@lilem.mirepesht> <20090713163530.GA22251@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752166AbZGMSxl@vger.kernel.org>
In-Reply-To: <20090713163530.GA22251@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: Text/Plain; charset="us-ascii"
To: Greg KH <gregkh@suse.de>
Cc: Ali Gholami Rudi <ali@rudi.ir>, fbdev <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>, Andrea Righi <righi.andrea@gmail.com>, Krzysztof Helt <krzysztof.h1@wp.pl>, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Philippe De Muyter <phdm@macqel.be>, linux-kernel@vger.kernel.org

On Monday 13 July 2009, Greg KH wrote:
> On Mon, Jul 13, 2009 at 07:47:09PM +0430, Ali Gholami Rudi wrote:
> > Hi,
> > 
> > Is there any reason for not adding these ioctls to fbdev?  I searched
> > the net and couldn't any.  Anyway, these patches simply implement those
> > ioctls.
> 
> Have you also added the needed 32 vs. 64 bit handlers for these ioctls?
> 

They are not there, but could be trivially added with

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index f8a09bf..ce107c4 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1285,6 +1285,8 @@ static long fb_compat_ioctl(struct file *file, unsigned int cmd,
 	case FBIOPAN_DISPLAY:
 	case FBIOGET_CON2FBMAP:
 	case FBIOPUT_CON2FBMAP:
+	case FBIOCOPYAREA:
+	case FBIOFILLRECT:
 		arg = (unsigned long) compat_ptr(arg);
 	case FBIOBLANK:
 		ret = do_fb_ioctl(info, cmd, arg);


Unfortunately, it would not be as easy to add an FBIOIMAGE, which sounds
equally useful.

	Arnd <><
