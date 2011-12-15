From: Timur Tabi <timur@freescale.com>
Date: Thu, 15 Dec 2011 20:50:47 +0000
Subject: Should I use FBINFO_VIRTFB?
Message-Id: <4EEA5DA7.3010406@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

I'm cleaning up my fbdev driver, and I just noticed FBINFO_VIRTFB:

#define FBINFO_VIRTFB		0x0004 /* FB is System RAM, not device. */

I am currently not setting this flag, but I am allocating my framebuffer in system ram via dma_alloc_coherent().  I don't see any good documentation for this flag, but I suspect I should be enabling it.  What exactly does this flag do?

I'd also like some explanation for these two macros, which appear to be related:

#define FBINFO_PARTIAL_PAN_OK	0x0040 /* otw use pan only for double-buffering */
#define FBINFO_READS_FAST	0x0080 /* soft-copy faster than rendering */

-- 
Timur Tabi
Linux kernel developer at Freescale

