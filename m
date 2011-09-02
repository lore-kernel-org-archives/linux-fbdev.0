From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Fri, 02 Sep 2011 17:24:03 +0000
Subject: [PATCH] fb: sh-mobile: Fix deadlock risk between lock_fb_info() and
Message-Id: <20110902192403.10f9cff7@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4DF7B0B4.4060002@gmx.de>
	<1308337359-3480-1-git-send-email-FlorianSchandinat@gmx.de>
	<20110618104311.6d80ba50@neptune.home>
	<20110618111934.26203dbf@neptune.home>
	<4E5FA7F9.9030802@gmx.de>
	<Pine.LNX.4.64.1109021802560.4731@axis700.grange>
	<4E61086C.3050102@gmx.de>
In-Reply-To: <4E61086C.3050102@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, lethal@linux-sh.org, linux-fbdev@vger.kernel.org, francis.moro@gmail.com, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, stable@kernel.org

Following on Herton's patch "fb: avoid possible deadlock caused by
fb_set_suspend" which moves lock_fb_info() out of fb_set_suspend()
to its callers, correct sh-mobile's locking around call to
fb_set_suspend() and the same sort of deaklocks with console_lock()
due to order of taking the lock.

console_lock() must be taken while fb_info is already locked and fb_info
must be locked while calling fb_set_suspend().

Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Hi Florian,

> On the other hand I just noticed the original patch didn't have
> Bruno's Signed-off and a commit message was missing. So may I ask you,
> Bruno, to add your Signed-off or preferably resend the version tested
> by Guennadi in the appropriate patch format.

Here it is with commit message and the Signed-off-by's.

Thanks,
Bruno




 drivers/video/sh_mobile_hdmi.c |   47 ++++++++++++++++++++++--------------=
---
 1 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index 7d54e2c..647ba98 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -1111,6 +1111,7 @@ static long sh_hdmi_clk_configure(struct sh_hdmi *hdm=
i, unsigned long hdmi_rate,
 static void sh_hdmi_edid_work_fn(struct work_struct *work)
 {
 	struct sh_hdmi *hdmi =3D container_of(work, struct sh_hdmi, edid_work.wor=
k);
+	struct fb_info *info;
 	struct sh_mobile_hdmi_info *pdata =3D hdmi->dev->platform_data;
 	struct sh_mobile_lcdc_chan *ch;
 	int ret;
@@ -1123,8 +1124,9 @@ static void sh_hdmi_edid_work_fn(struct work_struct *=
work)
=20
 	mutex_lock(&hdmi->mutex);
=20
+	info =3D hdmi->info;
+
 	if (hdmi->hp_state =3D HDMI_HOTPLUG_CONNECTED) {
-		struct fb_info *info =3D hdmi->info;
 		unsigned long parent_rate =3D 0, hdmi_rate;
=20
 		ret =3D sh_hdmi_read_edid(hdmi, &hdmi_rate, &parent_rate);
@@ -1148,42 +1150,45 @@ static void sh_hdmi_edid_work_fn(struct work_struct=
 *work)
=20
 		ch =3D info->par;
=20
-		console_lock();
+		if (lock_fb_info(info)) {
+			console_lock();
=20
-		/* HDMI plug in */
-		if (!sh_hdmi_must_reconfigure(hdmi) &&
-		    info->state =3D FBINFO_STATE_RUNNING) {
-			/*
-			 * First activation with the default monitor - just turn
-			 * on, if we run a resume here, the logo disappears
-			 */
-			if (lock_fb_info(info)) {
+			/* HDMI plug in */
+			if (!sh_hdmi_must_reconfigure(hdmi) &&
+			    info->state =3D FBINFO_STATE_RUNNING) {
+				/*
+				 * First activation with the default monitor - just turn
+				 * on, if we run a resume here, the logo disappears
+				 */
 				info->var.width =3D hdmi->var.width;
 				info->var.height =3D hdmi->var.height;
 				sh_hdmi_display_on(hdmi, info);
-				unlock_fb_info(info);
+			} else {
+				/* New monitor or have to wake up */
+				fb_set_suspend(info, 0);
 			}
-		} else {
-			/* New monitor or have to wake up */
-			fb_set_suspend(info, 0);
-		}
=20
-		console_unlock();
+			console_unlock();
+			unlock_fb_info(info);
+		}
 	} else {
 		ret =3D 0;
-		if (!hdmi->info)
+		if (!info)
 			goto out;
=20
 		hdmi->monspec.modedb_len =3D 0;
 		fb_destroy_modedb(hdmi->monspec.modedb);
 		hdmi->monspec.modedb =3D NULL;
=20
-		console_lock();
+		if (lock_fb_info(info)) {
+			console_lock();
=20
-		/* HDMI disconnect */
-		fb_set_suspend(hdmi->info, 1);
+			/* HDMI disconnect */
+			fb_set_suspend(info, 1);
=20
-		console_unlock();
+			console_unlock();
+			unlock_fb_info(info);
+		}
 	}
=20
 out:
