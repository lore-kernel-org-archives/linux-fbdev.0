From: Raphael Assenat <raph@8d.com>
Subject: [PATCH 1/2] mbxfb: Fix a chip bug? resulting in
	wrong pixclock
Date: Mon, 14 Aug 2006 14:40:36 -0400
Message-ID: <44E0C3A4.6050407@8d.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080001080309060000020703"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GChLR-0004FX-Fm for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 14 Aug 2006 11:39:25 -0700
Received: from roc.holo.8d.com ([64.254.227.115])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GChLR-0003LP-1N
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 14 Aug 2006 11:39:25 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Mike Rapoport <mike@compulab.co.il>
Cc: linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080001080309060000020703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is a workaround for what I think is a bug in the 2700G chip.

The PLL output frequency is adustable using 3 values (M, N and P. See
code for formula). The N value range is documented to be 1 to 7 but when
it is set to 1, the output frequency is lower than it should be (divided by 2),
giving unexpected results such as no sync on a CRT display.

This patch prevents N=1 when searching for the best value for the requested
pixclock.


--------------080001080309060000020703
Content-Type: text/plain;
 name="mbxfb-disppll-workaound.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mbxfb-disppll-workaound.diff"

This is a workaround for what I think is a bug in the 2700G chip.

The PLL output frequency is adustable using 3 values (M, N and P. See
code for formula). The N value range is documented to be 1 to 7 but when
it is set to 1, the output frequency is lower than it should be (divided by 2),
giving unexpected results such as no sync on a CRT display.

This patch prevents N=1 when searching for the best value for the requested
pixclock.

Signed-off-by: Raphael Assenat <raph@8d.com>

--- linux-2.6.18-rc2/drivers/video/mbx/mbxfb.c	2006-07-17 15:20:06.000000000 -0400
+++ linux-2.6.18-rc2-8d/drivers/video/mbx/mbxfb.c	2006-08-14 14:04:39.000000000 -0400
@@ -118,8 +118,19 @@
 	/* convert pixclock to KHz */
 	pixclock = PICOS2KHZ(pixclock_ps);
 
+	/* PLL output freq = (ref_clk * M) / (N * 2^P) 
+	 *
+	 * M: 1 to 63
+	 * N: 1 to 7
+	 * P: 0 to 7
+	 */
+	
+	/* RAPH: When N==1, the resulting pixel clock appears to
+	 * get divided by 2. Preventing N=1 by starting the following
+	 * loop at 2 prevents this. Is this a bug with my chip 
+	 * revision or something I dont understand? */	
 	for (m = 1; m < 64; m++) {
-		for (n = 1; n < 8; n++) {
+		for (n = 2; n < 8; n++) {
 			for (p = 0; p < 8; p++) {
 				clk = (ref_clk * m) / (n * (1 << p));
 				err = (clk > pixclock) ? (clk - pixclock) :


--------------080001080309060000020703
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------080001080309060000020703
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--------------080001080309060000020703--
