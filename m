From: zhonghua <kezh@cetcmotor.com>
Date: Fri, 29 Jan 2016 09:05:00 +0000
Subject: Kernel blocked at register_framebuffer because console_block
Message-Id: <56AB2B3C.5040608@cetcmotor.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hell all,

I have a booting problem because the drm driver register a new 
framebuffer device after created it. Im not sure if the system blocked 
or crashed, because there were no message output after its internal call 
to console_lock. I tried marked the booting sequence, and found the 
problem at: down(&console_sem);
and in its internal line is: sem->count--; Im not sure why? The fb 
device is a dpi device, if I register another device, such as hdmi, it 
would be OK.
