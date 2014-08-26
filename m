From: =?UTF-8?B?5L2Q44CF5pyo5aSn6LyU?= <daisuke.sasaki@atmark-techno.com>
Date: Tue, 26 Aug 2014 09:38:10 +0000
Subject: Questions about cea_modes database in modedb.c
Message-Id: <CAAr_WKyXnPuN2NjcUAhoPX1=MY2ztxC=gzRKX4UsX2KDb4Cefg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Dear experts,

This is a first time for me to write a email to this mailing list.

I am trying to output the video signal from the LCD controller of the
embedded system. I want to output the signal whose timings are defined in the
"CEA Standard ".
I am looking at the documentation for the CEA-816-D.

I understand that the signal timing of CEA Standard is defined as
"drivers/fbdev/core/modedb.c".

I have some questions on cea_modes database in modedb.c.

Q.1) In interlaced mode, for the values of the upper_margin, lower_margin
     and vsync_len, do I need to set the doubled number of the specs
     of the CEA Standard?

Q.2) When the two pixel clock frequencies are defined in one format, how
     would you choose the value of pixclock?
     For example, Format 5 can be selected 74.025MHz and 74.176MHz.
     The modedb.c file, how do I manage about this format?
     (Can I use in common to this file? Or, rewritten for each system?)

Q.3) Format 5: is the value of pixclock correct?
     In CEA Standard, pixclock of this format is 74.176 or 74.250MHz.

Q.4) Format 7 and 9: is the value of pixclock correct?
     In CEA Standard, pixclock of this format is 27.000 or 27.027MHz.

Q.5) Format 20: The value of hsync_len is wrong?
     I think, hsync_len should be 44.

Any feedback is really appreciated.


diff --git drivers/video/fbdev/core/modedb.c drivers/video/fbdev/core/modedb.c
index a9a907c..ed6b883 100644
--- drivers/video/fbdev/core/modedb.c
+++ drivers/video/fbdev/core/modedb.c
@@ -305,18 +305,18 @@ const struct fb_videomode cea_modes[64] = {
        },
        /* #5: 1920x1080i@59.94/60Hz */
        [5] = {
-               NULL, 60, 1920, 1080, 13763, 148, 88, 15, 2, 44, 5,
+               NULL, 60, 1920, 1080, 13468, 148, 88, 30, 4, 44, 10,
                FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
                FB_VMODE_INTERLACED, 0,
        },
        /* #7: 720(1440)x480iH@59.94/60Hz */
        [7] = {
-               NULL, 60, 1440, 480, 18554/*37108*/, 114, 38, 15, 4, 124, 3, 0,
+               NULL, 60, 1440, 480, 37037, 114, 38, 30, 8, 124, 6, 0,
                FB_VMODE_INTERLACED, 0,
        },
        /* #9: 720(1440)x240pH@59.94/60Hz */
        [9] = {
-               NULL, 60, 1440, 240, 18554, 114, 38, 16, 4, 124, 3, 0,
+               NULL, 60, 1440, 240, 37037, 114, 38, 16, 4, 124, 3, 0,
                FB_VMODE_NONINTERLACED, 0,
        },
        /* #18: 720x576pH@50Hz */
@@ -332,7 +332,7 @@ const struct fb_videomode cea_modes[64] = {
        },
        /* #20: 1920x1080i@50Hz */
        [20] = {
-               NULL, 50, 1920, 1080, 13480, 148, 528, 15, 5, 528, 5,
+               NULL, 50, 1920, 1080, 13468, 148, 528, 30, 4, 44, 10,
                FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
                FB_VMODE_INTERLACED, 0,
        },

--
Daisuke Sasaki
Atmark Techno, Inc.

