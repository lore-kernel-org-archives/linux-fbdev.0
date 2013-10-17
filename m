From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Date: Thu, 17 Oct 2013 09:50:43 +0000
Subject: [PATCH] tmio: call tmiofb_set_par in tmiofb_probe
Message-Id: <1382003443-5044-1-git-send-email-dbaryshkov@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Call tmiofb_set_par() to initlaize fixed variable before registering
framebuffer. This is necessary for current kexecboot.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/video/tmiofb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/video/tmiofb.c b/drivers/video/tmiofb.c
index deb8733..69fd0f7 100644
--- a/drivers/video/tmiofb.c
+++ b/drivers/video/tmiofb.c
@@ -774,6 +774,10 @@ static int tmiofb_probe(struct platform_device *dev)
 	if (retval)
 		goto err_hw_init;
 
+	retval = tmiofb_set_par(info);
+	if (retval)
+		goto err_set_par;
+
 	fb_videomode_to_modelist(data->modes, data->num_modes,
 				 &info->modelist);
 
@@ -787,7 +791,7 @@ static int tmiofb_probe(struct platform_device *dev)
 	return 0;
 
 err_register_framebuffer:
-/*err_set_par:*/
+err_set_par:
 	tmiofb_hw_stop(dev);
 err_hw_init:
 	if (cell->disable)
-- 
1.8.4.rc3

