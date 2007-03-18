From: Guido Guenther <agx@sigxcpu.org>
Subject: rivafb: fix initial brightness
Date: Sun, 18 Mar 2007 23:58:31 +0100
Message-ID: <20070318225830.GA6466@bogon.ms20.nix>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HT4PC-00032t-7d for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 Mar 2007 16:03:14 -0700
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HT4PA-0008BU-Mk
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 Mar 2007 16:03:14 -0700
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net, Richard Purdie <rpurdie@rpsys.net>

Hi
this is the rivafb equivalent of
238576e12fef1d52751c6e08db2d0bdb0e248caf. It fixes rivafb having a
default backlight brightness of 0 (no picture at all) on a PBook 6,1.
Since this is a regression over 2.6.20, can this go into 2.6.21?
Cheers,
 -- Guido

Signed-Off-By: Guido Guenther <agx@sigxcpu.org>

diff --git a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
index 1d1c7c6..d7ece8d 100644
--- a/drivers/video/riva/fbdev.c
+++ b/drivers/video/riva/fbdev.c
@@ -285,8 +285,6 @@ static const struct riva_regs reg_template = {
 #define MAX_LEVEL 0x534
 #define LEVEL_STEP ((MAX_LEVEL - MIN_LEVEL) / FB_BACKLIGHT_MAX)
 
-static struct backlight_properties riva_bl_data;
-
 static int riva_bl_get_level_brightness(struct riva_par *par,
 		int level)
 {
@@ -372,7 +370,7 @@ static void riva_bl_init(struct riva_par *par)
 		FB_BACKLIGHT_MAX);
 
 	bd->props.max_brightness = FB_BACKLIGHT_LEVELS - 1;
-	bd->props.brightness = riva_bl_data.max_brightness;
+	bd->props.brightness = bd->props.max_brightness;
 	bd->props.power = FB_BLANK_UNBLANK;
 	backlight_update_status(bd);
 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
