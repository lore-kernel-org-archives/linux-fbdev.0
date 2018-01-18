From: B Mithran <mithranbr15@gmail.com>
Date: Thu, 18 Jan 2018 11:56:31 +0000
Subject: OLED Display -- Framebuffer driver to DRM driver conversion required???
Message-Id: <CAPR_6vW3-XR+iw+cn5hOtkF1Rx84HfVffH37pqvFr-vnnOKg7w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Hi,

In my project (Arm processor based), we are using 2 displays. Primary
display is for Ubuntu 16.04 OS Gui display and secondary display is for status
messages, some small OLED display (128x64). This OLED display is framebuffer
driver based.

My doubt is:

1. Whether I need to convert this framebuffer driver to DRM driver? Is
this required? What is the advantages of this?

Please provide some inputs on this.

-Thanks.
