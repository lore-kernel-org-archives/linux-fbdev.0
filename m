From: Timur Tabi <timur@freescale.com>
Date: Fri, 16 Dec 2011 22:31:22 +0000
Subject: Re: "ls > /dev/fb0" generates weird ioctls if panning is set
Message-Id: <4EEBC6BA.1060905@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4EEBBCEA.9020104@freescale.com>
In-Reply-To: <4EEBBCEA.9020104@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Timur Tabi wrote:

> graphics fb0: unknown ioctl command (0x402C7413)                                                                                                   
> graphics fb0: dir=2 type='t' (74) nr sizeD                                                                                                    
> graphics fb0: unknown ioctl command (0x40087468)                                                                                                   
> graphics fb0: dir=2 type='t' (74) nr4 size=8                                                                                                    
> graphics fb0: unknown ioctl command (0x402C7413)                                                                                                   
> graphics fb0: dir=2 type='t' (74) nr sizeD   

I figured it out.  These ioctls are:

#define TCGETS		_IOR('t', 19, struct termios)
#define TIOCGWINSZ	_IOR('t', 104, struct winsize)

I'm guessing that since I redirect stdout to /dev/fb0, Linux is treating /dev/fb0 as a terminal, and therefore it's receiving terminal ioctls.

Is this something that fbdev should be supporting, or am I wrong to use /dev/fb0 as a terminal?

-- 
Timur Tabi
Linux kernel developer at Freescale

