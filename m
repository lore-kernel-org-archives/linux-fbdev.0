From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Thu, 25 Feb 2016 16:57:23 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <20160225165723.GT19428@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <3695074.sKSIyOjpjD@wuerfel>
 <CACRpkdZjfjOCFUucF1U5yVZBxSwa41GKEMv-HHQE=ymF2NZ21g@mail.gmail.com>
 <6859810.tb1t0IEONi@wuerfel> <56CC57FC.20707@ti.com>
 <CACRpkdYNaNtQQJ-tsBe5ksa4-z380ZQj-zN8ZnK0ED2kNPUwvg@mail.gmail.com>
 <56CC60C4.6040908@ti.com>
 <CACRpkdZd8TLdsi7_cOrqzcqWKJrfdp4Vz2sx5ozpwJXOj0fa+Q@mail.gmail.com>
 <56CF2FB1.106@ti.com>
In-Reply-To: <56CF2FB1.106@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Feb 25, 2016 at 06:45:37PM +0200, Tomi Valkeinen wrote:
> > *All* the others
> > will be very happy with *ONE* display defined as panel in the
> > device tree, and off they go. Usually VGA. And that will look
> 
> You keep mentioning VGA. So is there are VGA output? Or do you just mean
> MIPI DPI panels, which happen to take the same video timings as VGA?

There is a 15-pin VGA connector too.  No DDC though.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
