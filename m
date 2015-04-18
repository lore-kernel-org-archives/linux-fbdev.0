From: z f <taishan901028@gmail.com>
Date: Sat, 18 Apr 2015 07:46:48 +0000
Subject: what's the difference between smem_start and mmio_start?
Message-Id: <CADvLq87aq7m-xuf6XbOq7rDDjLORwiW-5O0qd5tfm+_H_xd05w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

what's the difference between smem_start member and mmio_start member
in struct fb_fix_screeninfo?
I have looked the fb_mmap() and cant understand its behavior:
http://lxr.free-electrons.com/source/drivers/video/fbdev/core/fbmem.c#L1413
