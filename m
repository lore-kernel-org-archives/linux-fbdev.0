From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Date: Wed, 30 Dec 2015 18:53:14 +0000
Subject: Whats missing in my new FB DRM driver... "No connectors reported connected with modes"?
Message-Id: <5684281A.7040300@synopsys.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5684268E.2000607@synopsys.com>
In-Reply-To: <5684268E.2000607@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: laurent.pinchart@ideasonboard.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: tomi.valkeinen@ti.com, CARLOS.PALMINHA@synopsys.com

Hi guys,

I'm writing a DRM driver for a framebuffer embedded hardware that uses 
an i2c encoder (adv7511), following the basic steps suggested by Laurent 
in "anatomy of an embedded KMS driver": 
https://www.youtube.com/watch?v=Ja8fM7rTae4

After initiliazing all kms, crtc, encoder, i2c, connector functions and 
structures i'm calling drm_fbdev_cma_init to create a fbdev.

When booting i'm getting an error message saying "No connectors reported 
connected with modes", but the driver init is ok and i can find the 
/dev/dri/* and /dev/fb0 devices.

Any clue what i might be missing during the driver load?

Thanks...

Regards,
C.Palminha

--- boot log snippet ---
[drm] Initialized drm 1.1.0 20060810
drm-arcpgu e0017000.pgu: No connectors reported connected with modes
[drm] Cannot find any crtc or sizes - going 1024x768
Console: switching to colour frame buffer device 128x48
drm-arcpgu e0017000.pgu: fb0:  frame buffer device
[drm] Initialized drm-arcpgu 1.0.0 20151127 on minor 0
--- boot log snippet ---
