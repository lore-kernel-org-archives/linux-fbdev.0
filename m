From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 24 Apr 2014 12:48:26 +0000
Subject: Re: [PATCH 03/13] video: clarify I2C dependencies
Message-Id: <12886728.o7TzRXlxjF@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398342509-10243-1-git-send-email-peter.griffin@linaro.org> <1398342509-10243-4-git-send-email-peter.griffin@linaro.org> <20140424123235.GS26756@n2100.arm.linux.org.uk>
In-Reply-To: <20140424123235.GS26756@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Peter Griffin <peter.griffin@linaro.org>, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Anatolij Gustschin <agust@denx.de>

On Thursday 24 April 2014 13:32:35 Russell King - ARM Linux wrote:
> On Thu, Apr 24, 2014 at 01:28:19PM +0100, Peter Griffin wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > We can only use I2C support in frame buffer drivers if
> > Either I2C is built-in, or both I2C and the driver itself
> > are loadable modules.
> 
> Why?


If I2C is a loadable module, and the I2C support of the framebuffer
driver is built-in, you get a link error when building vmlinux:

drivers/built-in.o: In function `cyberpro_pci_remove':
:(.text+0x1ea5c): undefined reference to `i2c_del_adapter'
drivers/built-in.o: In function `cyberpro_pci_probe':
:(.text+0x20224): undefined reference to `i2c_bit_add_bus'
:(.text+0x20240): undefined reference to `i2c_del_adapter'
make[2]: *** [vmlinux] Error 1

It's probably a good idea to mention that in the changeset
text.

	Arnd
