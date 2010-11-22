From: Inki Dae <inki.dae@samsung.com>
Date: Mon, 22 Nov 2010 03:03:28 +0000
Subject: Header definitions for RGB and CPU mode.
Message-Id: <008901cb89f1$dbb6e030$9324a090$%dae@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello, Paul.

I wish your opinion to header definitions for rgb and cpu mode interface,
Now, fb.h is considering only RGB interface.
Framebuffer driver could be used as RGB mode and CPU mode also.

How about adding definitions for RGB mode and CPU mode like below?

For example,
#define FB_MODE_RGB		0	<- default setting for
compatibility.
#define FB_MODE_CPU		1

Thank you.

