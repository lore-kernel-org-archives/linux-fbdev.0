From: James Hogan <james@albanarts.com>
Date: Fri, 03 Dec 2010 17:47:05 +0000
Subject: should fb drivers wait for vsync after panning?
Message-Id: <AANLkTik-J+3Q-J7mMZ-xUF5bM5jt3dVW5Xadw9ZimDBr@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

When double buffering by panning the framebuffer, a program might swap
the buffers by using the FBIOPAN_DISPLAY ioctl. However if the update
only occurs on the next vsync, the program has to wait until that
vsync before it is safe to write to the new back buffer, since the
hardware is still displaying it.

So is it the fb driver's responsibility to sleep until the next vsync
before returning from the fb_pan_display callback? If not, is there a
way for userland to do it safely without resorting to triple buffering
or non-standard ioctls?

Thanks
-- 
James Hogan
