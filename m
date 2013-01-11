From: Timur Tabi <timur@freescale.com>
Date: Fri, 11 Jan 2013 23:22:19 +0000
Subject: fb_image.data format for cursors?
Message-Id: <50F09EAB.5060506@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Is there any documentation for cursor support?  I'm trying to add cursor
support to my framebuffer driver, and I'm having a really hard time find a
description of anything.

In particular, what is the format of the image data in the fb_image.data
buffer?  For example, if fb_image.width = 12, and fb_image.height = 8,
how is the cursor data packed into the 'data' buffer?  That is, what is in
data[0], data[1], etc?

-- 
Timur Tabi
Linux kernel developer at Freescale

