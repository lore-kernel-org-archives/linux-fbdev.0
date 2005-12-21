From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: [PATCH 1/1: 2.6.15-rc5-mm3] Cyblafb: Remove unneeded code
Date: Wed, 21 Dec 2005 11:02:04 +0100
Message-ID: <43A9281C.5040800@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ep0oy-0002Xx-Sz
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Dec 2005 02:03:44 -0800
Received: from mailout04.sul.t-online.com ([194.25.134.18])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Ep0ox-0006Xt-Gl
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Dec 2005 02:03:44 -0800
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
To: Andrew Morton <akpm@osdl.org>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net

Initialization of GEB8 ... GED4 is removed in the graphics engine
setup function. GEB8 and GEC8 are set in the drawing functions now,
and all other registers never were used.

Signed-off-by: Knut Petersen <Knut_Petersen@t-online.de>

diff -uprN -X linux/Documentation/dontdiff -x '*.bak' -x '*.ctx' linuxorig/drivers/video/cyblafb.c linux/drivers/video/cyblafb.c
--- linuxorig/drivers/video/cyblafb.c	2005-12-21 10:49:51.000000000 +0100
+++ linux/drivers/video/cyblafb.c	2005-12-21 10:11:34.000000000 +0100
@@ -220,21 +220,10 @@ static void cyblafb_setup_GE(int pitch,i

  	write3X4(CR36,0x90);	// reset GE
  	write3X4(CR36,0x80);	// enable GE
-
-	out32(GE24,1<<7);	// reset all GE pointers
-	out32(GE24,0);
-
+	out32(GE24,1<<7);	// reset all GE pointers by toggling
+	out32(GE24,0);		//   d7 of GE24
  	write3X4(CR2D,0x00);	// GE Timinigs, no delays
-
-	out32(GEB8,base); // Destination Stride / Buffer Base 0, p 133
-	out32(GEBC,base); // Destination Stride / Buffer Base 1, p 133
-	out32(GEC0,base); // Destination Stride / Buffer Base 2, p 133
-	out32(GEC4,base); // Destination Stride / Buffer Base 3, p 133
-	out32(GEC8,base); // Source Stride / Buffer Base 0, p 133
-	out32(GECC,base); // Source Stride / Buffer Base 1, p 133
-	out32(GED0,base); // Source Stride / Buffer Base 2, p 133
-	out32(GED4,base); // Source Stride / Buffer Base 3, p 133
-	out32(GE6C,0);	  // Pattern and Style, p 129, ok
+	out32(GE6C,0);		// Pattern and Style, p 129, ok
  }

  //=====================================================================



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
