From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Mon, 09 Jan 2012 06:15:14 +0000
Subject: Re: [PATCH] atmel_lcdfb: support 16bit BGR:565 mode, remove unsupported 15bit modes
Message-Id: <877h11fll9.fsf@macbook.be.48ers.dk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1318517570-28459-1-git-send-email-jacmet@sunsite.dk>
 <87zke29yqj.fsf@macbook.be.48ers.dk> <4F0A55D7.50707@gmx.de>
In-Reply-To: <4F0A55D7.50707@gmx.de> (Florian Tobias Schandinat's message of
 "Mon, 09 Jan 2012 02:49:59 +0000")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

>>>>> "Florian" = Florian Tobias Schandinat <FlorianSchandinat@gmx.de> writes:

Hi,

 Peter> Allow framebuffer to be configured in 16bit mode when panel is
 Peter> wired in (the default) BGR configuration, and don't claim to
 Peter> support 15bit input modes, which the LCD controller cannot
 Peter> handle.
 >> 
 >> Ping? Nicolas, you added it to your at91-lcd branch - But it doesn't seem
 >> to have gone any further.

 Florian> I could also take care of this patch but I'd prefer if it gets
 Florian> an Acked-by of someone at Atmel (or someone else who knows the
 Florian> hardware) as I cannot really tell whether it is correct.

I understand. Nicolas, presumably you're ok with it as you added it to
your tree?

-- 
Bye, Peter Korsgaard
