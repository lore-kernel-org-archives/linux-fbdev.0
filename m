From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] fb_ddc: Fix DDC lines quirk
Date: Sun, 18 Nov 2007 14:21:41 +0100
Message-ID: <20071118142141.22a1e753@hyperion.delvare>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Itk5t-00030D-Mm for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 Nov 2007 05:21:49 -0800
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]
	helo=mallaury.nerim.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Itk5s-0001BP-WC
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 Nov 2007 05:21:49 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Antonino Daplas <adaplas@gmail.com>

The code in fb_ddc_read() is said to be based on the implementation
of the radeon driver:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=fc5891c8a3ba284f13994d7bc1f1bfa8283982de

However, comparing the old radeon driver code with the new fb_ddc code
reveals some differences. Most notably, the I2C bus lines are held at
the end of the function, while the original code was releasing them
(as the comment above correctly says.)

There are a few other differences, which appear to be responsible for
read failures on my system. While tracing low-level I2C code in
i2c-algo-bit, I noticed that the initial attempt to read the EDID
always failed. It takes one retry for the read to succeed. As we are
about to remove this automatic retry property from i2c-algo-bit,
reading the EDID would really fail.

As a summary, the I2C lines quirk which is supposedly needed to read
EDID on some older monitors is currently breaking the (first) read on
all other monitors (and might not even work with older ones - did
anyone try since October 2006?)

After applying the patch below, which makes the code in fb_ddc_read()
really similar to what the radeon driver used to have, the first EDID
read succeeds again.

On top of that, as it appears that this code has been broken for one
year now and nobody seems to have complained, I'm curious if it makes
sense to keep this quirk in place. It makes the code more complex and
slower just for the sake of monitors which I guess nobody uses
anymore. Can't we just get rid of it?

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/video/fb_ddc.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.24-rc3.orig/drivers/video/fb_ddc.c	2007-11-17 20:23:03.000000000 +0100
+++ linux-2.6.24-rc3/drivers/video/fb_ddc.c	2007-11-18 12:49:14.000000000 +0100
@@ -56,13 +56,12 @@ unsigned char *fb_ddc_read(struct i2c_ad
 	int i, j;
 
 	algo_data->setscl(algo_data->data, 1);
-	algo_data->setscl(algo_data->data, 0);
 
 	for (i = 0; i < 3; i++) {
 		/* For some old monitors we need the
 		 * following process to initialize/stop DDC
 		 */
-		algo_data->setsda(algo_data->data, 0);
+		algo_data->setsda(algo_data->data, 1);
 		msleep(13);
 
 		algo_data->setscl(algo_data->data, 1);
@@ -97,14 +96,15 @@ unsigned char *fb_ddc_read(struct i2c_ad
 		algo_data->setsda(algo_data->data, 1);
 		msleep(15);
 		algo_data->setscl(algo_data->data, 0);
+		algo_data->setsda(algo_data->data, 0);
 		if (edid)
 			break;
 	}
 	/* Release the DDC lines when done or the Apple Cinema HD display
 	 * will switch off
 	 */
-	algo_data->setsda(algo_data->data, 0);
-	algo_data->setscl(algo_data->data, 0);
+	algo_data->setsda(algo_data->data, 1);
+	algo_data->setscl(algo_data->data, 1);
 
 	return edid;
 }


-- 
Jean Delvare

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
