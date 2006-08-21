From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 2/5] mbxfb: Fix a chip bug? resulting in
	wrong pixclock
Date: Mon, 21 Aug 2006 18:54:00 +0800
Message-ID: <1156157640.6254.26.camel@daplas.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GF7Q0-0001HR-UQ for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Aug 2006 03:54:09 -0700
Received: from nz-out-0102.google.com ([64.233.162.193])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GF7Pz-0005UP-Jy
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Aug 2006 03:54:08 -0700
Received: by nz-out-0102.google.com with SMTP id l8so688649nzf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 21 Aug 2006 03:54:05 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Raphael Assenat <raph@8d.com>

From: Raphael Assenat <raph@8d.com>

This is a workaround for what I think is a bug in the 2700G chip.

The PLL output frequency is adustable using 3 values (M, N and P. See
code for formula). The N value range is documented to be 1 to 7 but when
it is set to 1, the output frequency is lower than it should be (divided by 2),
giving unexpected results such as no sync on a CRT display.

This patch prevents N=1 when searching for the best value for the requested
pixclock.

Signed-off-by: Raphael Assenat <raph@8d.com>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/mbx/mbxfb.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/video/mbx/mbxfb.c b/drivers/video/mbx/mbxfb.c
index 6849ab7..cfc6bf3 100644
--- a/drivers/video/mbx/mbxfb.c
+++ b/drivers/video/mbx/mbxfb.c
@@ -118,8 +118,19 @@ static unsigned int mbxfb_get_pixclock(u
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



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
