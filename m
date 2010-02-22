From: Julia Lawall <julia@diku.dk>
Date: Mon, 22 Feb 2010 07:14:12 +0000
Subject: question about drivers/video/intelfb/intelfbhw.c
Message-Id: <Pine.LNX.4.64.1002220813450.18401@ask.diku.dk>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The code below seems suspicious.  Which definition of vblank_end is
the right one?

This is not intended as a proper patch.  I can send a proper patch when I
know what to do.

julia



diff -u -p a/drivers/video/intelfb/intelfbhw.c b/drivers/video/intelfb/intelfbhw.c
--- a/drivers/video/intelfb/intelfbhw.c
+++ b/drivers/video/intelfb/intelfbhw.c
@@ -1192,7 +1192,6 @@ int intelfbhw_mode_to_hw(struct intelfb_
 	vsync_end = vsync_start + var->vsync_len;
 	vtotal = vsync_end + var->upper_margin;
 	vblank_start = vactive;
-	vblank_end = vtotal;
 	vblank_end = vsync_end + 1;
 
 	DBG_MSG("V: act %d, ss %d, se %d, tot %d bs %d, be %d\n",
