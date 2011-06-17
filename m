From: Steve Strobel <steve.strobel@link-comm.com>
Date: Fri, 17 Jun 2011 23:10:22 +0000
Subject: Framebuffer driver for controller with indirect addressing?
Message-Id: <0LlUqt-1Pye1R36EZ-00bCDF@mrelay.perfora.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

I am trying to support a Tianma TM023KDH18 QVGA LCD display (1) via a 
16-bit parallel bus interface on a BF537 Blackfin running the 
distribution from blackfin.uclinux.org.  Built into the display is a 
ILITEK ILI9342 controller (2).  The controller has built-in memory 
for the framebuffer and handles refreshing the display 
automatically.  Changing the contents of the framebuffer is done by 
sending commands to set the starting pixel position, then writing 
repeatedly to the same address with the data for each successive 
pixel.  It does not have address lines, so the framebuffer memory is 
not directly accessible as with the S1D13XXX chips.  A single D/CX 
pin, which we plan to treat like an address line, controls whether 
each bus read/write operation is treated as a command or data.

I am wondering if there is an existing driver for something that 
works in a similar way that I could use as a model.  I think I am 
going to need to create a shadow framebuffer in system memory (maybe 
using the virtual framebuffer) and DMA it to the graphics controller 
whenever the displayed information changes (or maybe on the 
double-buffer flip).  Ultimately I would like to use Qt, so building 
on the existing framebuffer API seems like a good idea.

If someone could point me to a driver that works in a similar way, it 
would help me out a lot.  Thanks.

Steve

(1) Datasheet at 
http://www.tianma-usa.com/web/uploads/spec/0906123532_TM023KDH18%20V1.0.pdf
(2) Datasheet at http://linkcomm.com/temp/ILI9342.pdf



---
Steve Strobel
Link Communications, Inc.
1035 Cerise Rd
Billings, MT 59101-7378
(406) 245-5002 ext 102
(406) 245-4889 (fax)
WWW: http://www.link-comm.com
MailTo:steve.strobel@link-comm.com

