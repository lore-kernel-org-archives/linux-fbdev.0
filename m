From: Ben Dooks <ben-linux@fluff.org>
Subject: BACKLIGHT: Add more information output to
	pwm_backlight
Date: Tue, 29 Jul 2008 11:44:06 +0100
Message-ID: <20080729104405.941921481@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KNmgo-0000iC-7M for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 29 Jul 2008 03:44:22 -0700
Received: from aeryn.fluff.org.uk ([87.194.8.8] helo=kira.home.fluff.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KNmgk-00040X-Pv
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 29 Jul 2008 03:44:22 -0700
Content-Disposition: inline;
	filename=simtec/simtec-drivers-backlight-pwm-updates.patch
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
To: akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net
Cc: Ben Dooks <ben-linux@fluff.org>, Russell King <rmk@arm.linux.org.uk>

Make the error paths in the pwm_backlight driver more
informative in the probe path, especially for the times
that it finds an error.

CC: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Index: linux-2.6.26-quilt4/drivers/video/backlight/pwm_bl.c
===================================================================
--- linux-2.6.26-quilt4.orig/drivers/video/backlight/pwm_bl.c	2008-07-29 11:28:01.000000000 +0100
+++ linux-2.6.26-quilt4/drivers/video/backlight/pwm_bl.c	2008-07-29 11:36:02.000000000 +0100
@@ -68,8 +68,10 @@ static int pwm_backlight_probe(struct pl
 	struct pwm_bl_data *pb;
 	int ret;
 
-	if (!data)
+	if (!data) {
+		dev_err(&pdev->dev, "failed to find platform data\n");
 		return -EINVAL;
+	}
 
 	if (data->init) {
 		ret = data->init(&pdev->dev);
@@ -79,6 +81,7 @@ static int pwm_backlight_probe(struct pl
 
 	pb = kzalloc(sizeof(*pb), GFP_KERNEL);
 	if (!pb) {
+		dev_err(&pdev->dev, "no memory for state\n");
 		ret = -ENOMEM;
 		goto err_alloc;
 	}
@@ -91,7 +94,8 @@ static int pwm_backlight_probe(struct pl
 		dev_err(&pdev->dev, "unable to request PWM for backlight\n");
 		ret = PTR_ERR(pb->pwm);
 		goto err_pwm;
-	}
+	} else
+		dev_dbg(&pdev->dev, "got pwm for backlight\n");
 
 	bl = backlight_device_register(pdev->name, &pdev->dev,
 			pb, &pwm_backlight_ops);

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
