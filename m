From: Woody Suwalski <woodys@xandros.com>
Subject: Re: 2.6.16-rc3 + Xorg 6.9.0  - works for me...
Date: Wed, 26 Apr 2006 14:38:34 -0400
Message-ID: <444FBE2A.90106@xandros.com>
References: <43F4AF97.8080909@xandros.com> <443E3A4B.8000101@netwinder.org> <443E4435.1060904@xandros.com> <443F8EB1.30803@netwinder.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <bounce-debian-arm=debian-arm=m.gmane.org@lists.debian.org>
In-Reply-To: <443F8EB1.30803@netwinder.org>
Resent-Message-ID: <K7pIRB.A.rtF.jL8TEB@murphy>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:debian-arm@lists.debian.org>
List-Help: <mailto:debian-arm-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-arm-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-arm-request@lists.debian.org?subject=unsubscribe>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Martin Michlmayr <tbm@cyrius.com>, rmk@arm.linux.org.uk
Cc: Ralph Siemsen <ralphs@netwinder.org>, linux-fbdev-devel@lists.sourceforge.net, debian-arm@lists.debian.org

 >>>
I just upgraded my Netwinder from 2.4.27 to 2.6.15 and the framebuffer
no longer works.  Console works but when I start X.org I first get a
corrupted screen and a little bit later the whole machine hangs.
There's no panic or any information on the serial console.
<<<

This problem appears only on Cyber2010 chips (Netwinders with Cyber2000 
work OK)

The crash issue on 2010 can be solved by disabling burst mode on the 
Cyberpro 2010 (graphic register 0x30, EXT_BUS_CTL_PCIBURST_WRITE=0). It 
is enabled in the kernel driver by default now.

However, I can see in the cyber2000fb.c file that the 2010 is also used 
on Shark architecture.

Martin, Russell,
Can you verify if the current 2.6.1x kernel + X 6.9 works OK on SHARK 
machine??? I do not have any of them here to test...

Basically we need to establish, if this fix is needed just for 
Netwinders with CyberPro 2010 (here tested on machine with 1M VRAM in 
32-bit mode, but Martin seems to have problem on 2M VRAM Netwinder?) or 
all machines with CyberPro 2010.

Thanks, Woody

-- 
Xandros Corporation
Simple. Powerful. Linux.
Visit us at http://www.xandros.com
