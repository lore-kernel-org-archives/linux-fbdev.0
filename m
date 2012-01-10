From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Tue, 10 Jan 2012 13:17:01 +0000
Subject: Re: [PATCH] atmel_lcdfb: support 16bit BGR:565 mode, remove unsupported 15bit modes
Message-Id: <87ty43d7ea.fsf@macbook.be.48ers.dk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1318517570-28459-1-git-send-email-jacmet@sunsite.dk>
 <4F0AC2B1.8010601@atmel.com> <87ty45dt89.fsf@macbook.be.48ers.dk>
 <20120110130146.GC2057@taskit.de>
In-Reply-To: <20120110130146.GC2057@taskit.de> (Christian Glindkamp's message
 of "Tue, 10 Jan 2012 14:01:46 +0100")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

>>>>> "Christian" = Christian Glindkamp <christian.glindkamp@taskit.de> writes:

Hi,

 >> So it doesn't really support RGB555 mode. The controller reads up to
 >> 32bit of framebuffer data and outputs 24bit on the LCD pins. You CAN
 >> wire up a RGB555 panel by just skipping the LSB green of a RGB565
 >> wiring, but that is independent of the framebufffer format.

 Christian> But the AT91SAM9261/AT91SAM9263 do not have a native RGB565
 Christian> format if it is configured for 16bit (so it does not read
 Christian> 32bit and output 24bit but just 16bit) but uses BGR555 with
 Christian> an additional intensity bit in the MSB like the palette
 Christian> where you also kept the BGR555 format. How can you get
 Christian> correct colors on these processors if this code above is
 Christian> removed?

Ahh, I wasn't aware of that (I'm using 9g45). I guess we need to do
something similar to what I did for the palette handling:

https://github.com/at91linux/linux-at91/commit/7a256fc44c1892ad3166363ba309d9996a49e7b8

E.G. keep the RBG555/BGR555 format for the old devices, and my proposed
change for the new ones. I'll cook something up.

-- 
Bye, Peter Korsgaard
