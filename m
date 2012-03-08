From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 08 Mar 2012 16:26:34 +0000
Subject: [RFC] FB_MODE_IS_* usage
Message-Id: <2317885.WEEKmd8lWO@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi everybody,

While going through users of the fb_videomode structure, I realized that some 
of the FB_MODE_IS_* flags didn't seem to be used for any practical purpose.

The flags are defined as

#define FB_MODE_IS_UNKNOWN      0
#define FB_MODE_IS_DETAILED     1
#define FB_MODE_IS_STANDARD     2
#define FB_MODE_IS_VESA         4
#define FB_MODE_IS_CALCULATED   8
#define FB_MODE_IS_FIRST        16
#define FB_MODE_IS_FROM_VAR     32

- FB_MODE_IS_UNKNOWN isn't used at all

- FB_MODE_IS_DETAILED is set by the EDID parser for modes coming from detailed 
timing descriptors, and checked right after to work around monitors that 
report the "Preferred timing mode specified in descriptor block 1" bit in 
their EDID block, but don't report any detailed timing descriptor. 
FB_MODE_IS_DETAILED is thus only used internally in the EDID parser.

- FB_MODE_IS_STANDARD, FB_MODE_IS_VESA and FB_MODE_IS_CALCULATED are set but 
never used.

- FB_MODE_IS_FIRST is set by the EDID parser on the first detailed mode, and 
checked by fb_find_best_display() and a couple of drivers (fsl-diu-fb, 
sh_mobile_hdmi, aty and riva) to locate the first detailed mode (I will check 
if I can modify those 4 drivers to use fb_find_best_display() or something 
similar).

- FB_MODE_IS_FROM_VAR is set but never used.

If I can remove direct use of the FB_MODE_IS_FIRST flag in the drivers 
mentioned above, the FB_MODE_IS_DETAILED and FB_MODE_IS_FIRST flags will only 
be used internally in the EDID parser. All the other flags are either not used 
at all, or set but never read.

I'm working on sharing the EDID parser between DRM/KMS, FB and V4L2. The 
FB_MODE_IS_FIRST and FB_MODE_IS_DETAILED flags will thus become unused. Is 
there any objection to removing them then ?

-- 
Regards,

Laurent Pinchart

