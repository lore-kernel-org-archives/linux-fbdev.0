From: Paulo Marques <pmarques@grupopie.com>
Subject: Re: [PATCH] pxafb: Add support for other palette formats
Date: Wed, 04 Jul 2007 12:00:48 +0100
Message-ID: <468B7DE0.9020506@grupopie.com>
References: <200707031607.08511.hjk@linutronix.de>	<200707031845.57256.hjk@linutronix.de>	<468A85A2.1070506@grupopie.com>	<200707031944.21467.hjk@linutronix.de>	<468A9300.7060608@grupopie.com>
	<18059.18815.378793.220680@ipc1.karo>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <18059.18815.378793.220680@ipc1.karo>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Lothar Wassmann <LW@KARO-electronics.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

Lothar Wassmann wrote:
> Hi,

Hi,

>> I assume the "red 6@16" is a typo for "red 6@12", since the "3 byte / 
>> green 6@6 and blue 6@0" match exactly the 18bpp packed format. Even 
>>
> Take a closer look at the actual pixel format of the PXA270.
> The usual graphics packages AFAIK support either packed pixels
> (i.e. 18 bit on screen => 18 bit in memory)

This mode would be quite insane: 16 pixels in 9 words?  :P

No, I don't think there are graphics packages out there supporting this 
mode.

> or unpacked (i.e. 18/24
> or whatever bits => 32 bit in memory).
> The PXA supports either the unpacked pixel format (which is a waste of
> memory especially on embedded systems) 

...but is very good for alignment. Access to any individual pixel is 
always aligned on a 4 byte boundary. So, I guess it depends on the 
application.

> or a strange format which is
> neither: 18bit on screen in 24bit in memory (IOW 4 pixels in 3
> words in memory).

Take a closer look at my post, specially at the "3 byte" part. The mode 
supported by DirectFB is really the packed mode of the PXA270: 18bit on 
screen in 24bit in memory.

-- 
Paulo Marques - www.grupopie.com

"All I ask is a chance to prove that money can't make me happy."

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
