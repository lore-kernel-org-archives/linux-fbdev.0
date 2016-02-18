From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Thu, 18 Feb 2016 13:12:33 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <20160218131233.GP19428@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <56C438DA.5040109@ti.com>
 <CACRpkdZ+G17hmVP8AejL7NTqg7k0SBC5kgF55ASjD+kfuGFJhQ@mail.gmail.com>
 <20160217213250.GK19428@n2100.arm.linux.org.uk>
 <56C5B080.9090007@ti.com>
In-Reply-To: <56C5B080.9090007@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Feb 18, 2016 at 01:52:32PM +0200, Tomi Valkeinen wrote:
> In my opinion the best option would be to use DT overlays, but so that
> the bootloader would supply them, or construct the dtb. But afaik that's
> not possible at the moment. And perhaps I think that's the best option
> only because I don't work with the bootloaders =).
> 
> So, I don't like this, but I don't have a good suggestion how to do it
> better with the infrastructure in place at the moment.

The danger of that position is that we end up with nothing happening,
and the problem remaining unresolved, which then pushes people into
maintaining patches out of mainline just to have a working setup -
which then pushes people to vendor trees.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
