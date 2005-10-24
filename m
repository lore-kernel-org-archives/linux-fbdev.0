From: Andrey Volkov <avolkov@varma-el.com>
Subject: Re: Linux Framebuffer endian issues
Date: Mon, 24 Oct 2005 16:51:42 +0400
Message-ID: <435CD8DE.8020906@varma-el.com>
References: <200510241357.46987.rolf.offermanns@gmx.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EU1nr-0001dC-DS
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 24 Oct 2005 05:51:51 -0700
Received: from [195.144.244.147] (helo=amanaus.varma-el.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EU1nq-0003jh-Vs
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 24 Oct 2005 05:51:51 -0700
In-Reply-To: <200510241357.46987.rolf.offermanns@gmx.net>
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
Content-Type: text/plain; charset="us-ascii"
To: Rolf Offermanns <rolf.offermanns@gmx.net>
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi Rolf,

Rolf Offermanns wrote:
> Hi Andrey,
> I have seen your thread about endian issues with the linux framebuffer system 
> and your SMI501 driver.
> 
> I am currently writing a driver for a SMI712 on a PCI card in a big endian 
> system (PPC440EP).
> 
> While 8bpp modes works quite well, I have wrong color in 16bpp truecolor 
> visual.
> 
> I guess this could be the same thing, you saw.
> 
> Did you solve the problem? 
No I defer solution of this problem :(, since 16 bpp doesn't critical
for me in nearest 2 months.

> If yes, would you be so kind to share your findings 
> with me? I tried lots of things like changing the offsets of the length 
> fields, but I was not successfull.

For me, was helpful offsets changing (I get right colors), but in this
case pixels are shifted :(.

Try something like this dirty hack:

--- fb.h.old	2005-10-24 16:46:34.000000000 +0400
+++ fb.h	2005-10-24 16:47:42.000000000 +0400
@@ -778,7 +778,7 @@
 #define fb_writeq sbus_writeq
 #define fb_memset sbus_memset_io

-#elif defined(__i386__) || defined(__alpha__) || defined(__x86_64__) ||
defined(__hppa__) || (defined(__sh__) && !defined(__SH5__)) ||
defined(__powerpc__)
+#elif defined(__i386__) || defined(__alpha__) || defined(__x86_64__) ||
defined(__hppa__) || (defined(__sh__) && !defined(__SH5__))

 #define fb_readb __raw_readb
 #define fb_readw __raw_readw
@@ -790,6 +790,16 @@
 #define fb_writeq __raw_writeq
 #define fb_memset memset_io

+#else if defined(__powerpc__)
+#define fb_readb readb
+#define fb_readw readw
+#define fb_readl readl
+#define fb_readq readq
+#define fb_writeb writeb
+#define fb_writew writew
+#define fb_writel writel
+#define fb_writeq writeq
+#define fb_memset memset_io
 #else

 #define fb_readb(addr) (*(volatile u8 *) (addr))

> 
> Thanks,
> Rolf
> 
> 

-- 
Regards
Andrey Volkov


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
