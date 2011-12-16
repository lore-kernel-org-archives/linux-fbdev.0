From: Timur Tabi <timur@freescale.com>
Date: Fri, 16 Dec 2011 21:49:30 +0000
Subject: "ls > /dev/fb0" generates weird ioctls if panning is set
Message-Id: <4EEBBCEA.9020104@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

If I do this:

	echo "0,100" > /sys/devices/soc.0/fffe10000.display/graphics/fb0/pan

then whenever I do this:

	ls > /dev/fb0

my driver receives the following three ioctls:

graphics fb0: unknown ioctl command (0x402C7413)                                                                                                   
graphics fb0: dir=2 type='t' (74) nr sizeD                                                                                                    
graphics fb0: unknown ioctl command (0x40087468)                                                                                                   
graphics fb0: dir=2 type='t' (74) nr4 size=8                                                                                                    
graphics fb0: unknown ioctl command (0x402C7413)                                                                                                   
graphics fb0: dir=2 type='t' (74) nr sizeD   

This is on PowerPC, where dir=2 means read.

The "echo" and "cat" commands don't generate these ioctls, so there's something special about the "ls" command.  Does anyone know what's going on?  ioctl-number.txt lists these ioctls for type 't':

't'	00-7F	linux/if_ppp.h
't'	80-8F	linux/isdn_ppp.h
't'	90	linux/toshiba.h

-- 
Timur Tabi
Linux kernel developer at Freescale

