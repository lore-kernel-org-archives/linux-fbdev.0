From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re: Linux 2.6.10-rc2
Date: Wed, 17 Nov 2004 15:12:57 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0411171504220.2222@ppc970.osdl.org>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org>
 <Pine.LNX.4.58.0411170802500.2222@ppc970.osdl.org> <200411171917.15962.andrew@walrond.org>
 <200411172233.28606.andrew@walrond.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUYz6-0004tE-9e
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Nov 2004 15:13:08 -0800
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CUYz5-0005hh-68
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Nov 2004 15:13:08 -0800
In-Reply-To: <200411172233.28606.andrew@walrond.org>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Walrond <andrew@walrond.org>, "Antonino A. Daplas" <adaplas@hotpop.com>
Cc: linux-fbdev-devel@lists.sourceforge.net



On Wed, 17 Nov 2004, Andrew Walrond wrote:
> 
> And I can confirm that the problem exists in both 32bit and 64bit kernels.

Ok. None of the code should actually have changed at all, but I notice one 
bug:

	diff -Nru a/drivers/video/riva/riva_hw.c b/drivers/video/riva/riva_hw.c
	--- a/drivers/video/riva/riva_hw.c      2004-11-17 15:00:52 -08:00
	+++ b/drivers/video/riva/riva_hw.c      2004-11-17 15:00:52 -08:00
	@@ -637,7 +641,10 @@
	     {
	         int  b = fifo_data.graphics_burst_size >> 4;
	         *burst = 0;
	-        while (b >>= 1) (*burst)++;
	+        while (b) {
	+           (*burst)++;
	+           b >>= 1;
	+       }
	         *lwm   = fifo_data.graphics_lwm >> 3;
	     }
	     else
	@@ -826,7 +834,10 @@
	     {
	         int  b = fifo_data.graphics_burst_size >> 4;
	         *burst = 0;
	-        while (b >>= 1) (*burst)++;
	+        while (b) {
	+           (*burst)++;
	+           b >>= 1;
	+       }
	         *lwm   = fifo_data.graphics_lwm >> 3;
	     }
	 }
	@@ -1088,7 +1101,10 @@
	     {
	         int  b = fifo_data.graphics_burst_size >> 4;
	         *burst = 0;
	-        while (b >>= 1) (*burst)++;
	+        while (b) {
	+           (*burst)++;
	+           b >>= 1;
	+       }
	         *lwm   = fifo_data.graphics_lwm >> 3;
	     }
	 }
	@@ -1139,7 +1155,10 @@
	     {
	         int  b = fifo_data.graphics_burst_size >> 4;
	         *burst = 0;
	-        while (b >>= 1) (*burst)++;
	+        while (b) {
	+           (*burst)++;
	+           b >>= 1;
	+       }
	         *lwm   = fifo_data.graphics_lwm >> 3;
	     }
	 }


please undo those parts (by hand, I've messed up white-space), since they 
make "burst" be one too big. Looks like the reason for doing that in the 
first place was an old sparse warning that no longer exists.

Antonino? Any I missed?

		Linus


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
