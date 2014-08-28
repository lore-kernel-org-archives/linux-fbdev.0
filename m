From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Date: Thu, 28 Aug 2014 19:19:39 +0000
Subject: EARLY_PRINTK equivalent for framebuffers.
Message-Id: <CAKON4Owx5wQS29qj9Ks2CzP-Q9Kos6=6MbPRxS+4n9WkdbWegQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Is there some existing way to do early printk type output to a
framebuffer that has been set up by the bootloader?  early printk is
before any device drivers are loaded.

If not, what would it take to create a way to do this? Something along
the lines of build in the fbdev library and give it an address plus
x/y layout of the buffer. Assume that everything else is set up and
anything written to the buffer will appear on the display. Then hook
into where the kernel does early printk on uarts and add in support
for this buffer. The core fbdev library implements scrolling and
graphical characters.

I'm only looking to address early boot messages so that if the kernel
fails to boot before it can get to a real video driver, the output is
still visible.

Note that you get this early output right now, but it is buffered by
the kernel until the console driver is loaded, then it gets dumped. If
you fail before that console driver loads you see nothing. The idea is
to make the output that gets lost visible.

To communicate this you need the existing fb mode line on the kernel
command line (to get x/y layout) plus the framebuffer address. Or this
info can come via the DT.

No intention to keep this display working once real display drivers
get loaded. So no touching clocks, regulators, display modes, etc....

-- 
Jon Smirl
jonsmirl@gmail.com
