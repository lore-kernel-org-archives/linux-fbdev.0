From: Paul Mackerras <paulus@au1.ibm.com>
Subject: Re: [PATCH] broken cfb* support in the 2.5.31-bk
Date: Fri, 16 Aug 2002 09:19:14 +1000 (EST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <15708.14066.32752.365661@argo.ozlabs.ibm.com>
References: <20020814192327.GD37217@ppc.vc.cvut.cz>
	<Pine.LNX.4.33.0208142128260.7482-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from dp.samba.org ([66.70.73.150] helo=lists.samba.org)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17fTwV-0000bj-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 15 Aug 2002 16:22:16 -0700
In-Reply-To: <Pine.LNX.4.33.0208142128260.7482-100000@maxwell.earthlink.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

James Simmons writes:

> That was done to push people to port there drivers to the new api.

Well, what _is_ the new API?

Anyway, you could apply this patch, for a start.  I wish you would be
a bit more careful about details.

Paul.

diff -urN linux-2.5/drivers/video/Makefile pmac-2.5/drivers/video/Makefile
--- linux-2.5/drivers/video/Makefile	Wed Aug 14 09:15:02 2002
+++ pmac-2.5/drivers/video/Makefile	Fri Aug 16 09:08:34 2002
@@ -60,7 +60,7 @@
 obj-$(CONFIG_FB_3DFX)             += tdfxfb.o
 obj-$(CONFIG_FB_MAC)              += macfb.o macmodes.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o 
 obj-$(CONFIG_FB_HP300)            += hpfb.o cfbfillrect.o cfbimgblt.o
-obj-$(CONFIG_FB_OF)               += offb.o cfbfillrect.o cfbimgblit.o cfbcopyarea.o
+obj-$(CONFIG_FB_OF)               += offb.o cfbfillrect.o cfbimgblt.o cfbcopyarea.o
 obj-$(CONFIG_FB_IMSTT)            += imsttfb.o
 obj-$(CONFIG_FB_RETINAZ3)         += retz3fb.o
 obj-$(CONFIG_FB_CLGEN)            += clgenfb.o


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
