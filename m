From: Tony Prisk <linux@prisktech.co.nz>
Date: Sun, 11 Aug 2013 04:41:46 +0000
Subject: EDID modes unavailable when no connector/crtc available at boot
Message-Id: <5207160A.6070803@prisktech.co.nz>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

I am working on the HDMI driver for the i.MX6 as part of the larger DRM 
driver written by Sascha Hauer and need a little advice. I seem to be 
missing one important part of the subsystem that I haven't been able to 
resolve.

In my testing, powering on the system with only a HDMI cable connected 
works perfectly. Resolution is set to 1920x1080 as requested (with the 
framebuffer console at the same resolution).

If I boot up the system without an HDMI cable connected (or any other 
cable), I get the expected:
[    1.470273] imx_hdmi_connector_detect
[    1.470276] returned cable DISCONNECTED
[    1.470289] imx-drm imx-drm: No connectors reported connected with modes
[    1.470297] [drm] Cannot find any crtc or sizes - going 1024x768

When I connect the cable at a later time, all EDID detected modes are 
'truncated' to '<= 1024x768', but because I have a video=xxx in 
bootargs, the driver still seems to initialize to 1920x1080, but with a 
framebuffer of 1024x768.

I assume this is a mistake on my part, but I don't know what I'm missing 
that would cause it.

I see in drm_crtc_helper.c:drm_helper_mode_fill_fb_struct that the 
width/height are set to the initialized mode.
Later in drm_fb_helper.c:drm_fb_helper_hotplug_event, max_width if set 
to fb->width.

This is what causes the modes to be truncated when the HDMI connector is 
finally connected (max_width is now limited to 1024).


Suggestions appreciated.

Regards
Tony Prisk
