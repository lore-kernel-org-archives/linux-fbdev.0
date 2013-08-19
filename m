From: Jonathan Campbell <jonathan@castus.tv>
Date: Mon, 19 Aug 2013 08:24:20 +0000
Subject: Bochs VBE & Virtualbox framebuffer driver
Message-Id: <5211D634.3010204@castus.tv>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This is an experimental framebuffer driver for VirtualBox and Bochs VBE 
displays. It started off as a proof of concept and grew into the code it 
is now. When testing Linux in Bochs or VirtualBox this allows greater 
control over the display and bit depth, though no h/w acceleration.

What do you think? Would this be something that could make it into the 
mainline kernel?

http://www.hackipedia.org/Projects/bochsfb/tvbox-v2.2-bochsfb-rev-00000019-src.tar.xz

