From: Paulo Marques <pmarques@grupopie.com>
Subject: Re: [PATCH] pxafb: Add support for other palette formats
Date: Tue, 03 Jul 2007 17:03:37 +0100
Message-ID: <468A7359.5010305@grupopie.com>
References: <200707031607.08511.hjk@linutronix.de>	<468A6159.6000808@grupopie.com>	<200707031703.53102.hjk@linutronix.de>
	<18058.28725.106989.860166@ipc1.karo>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <18058.28725.106989.860166@ipc1.karo>
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
> 
>> Can userspace applications work with such a weired format?
>> If yes, I'm looking forward to your patch.
>>
> At least framebuffer consoles don't work with that. So you should
> add a configuration option that allows enabling the strange PXA pixel
> formats only when CONFIG_FRAMEBUFFER_CONSOLE is not set.

Or maybe teach fbcon to use 18bpp modes?

> BTW: PXA255 doesn't have an LCCR4 register.

If we make sure that we don't touch LCCR4 registers unless the platform 
driver asks for 18bpp we should be in the clear, no?

However, the current patch does write to LCCR4 without checking this, 
but this should be a no-op if there is no register there, AFAICS.

I'll try to handle it more correctly in my next patch, anyway.

-- 
Paulo Marques - www.grupopie.com

"You're just jealous because the voices only talk to me."

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
