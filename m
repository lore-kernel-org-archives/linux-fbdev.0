From: Timur Tabi <timur@freescale.com>
Date: Mon, 17 Sep 2012 16:06:03 +0000
Subject: CONFIG_VIDEO_OUTPUT_CONTROL dead code?
Message-Id: <50574A6B.7050102@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

I found CONFIG_VIDEO_OUTPUT_CONTROL enabled in one of my defconfigs, but I
can't figure out what this option is for.  I can see that it compiles
drviers/video/output.c, but I can't find any other code in the kernel that
uses this API.  Google searches haven't revealed anything either.

What is this feature, and does anyone still use it?

-- 
Timur Tabi
Linux kernel developer at Freescale

