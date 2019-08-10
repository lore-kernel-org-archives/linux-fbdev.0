From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Sat, 10 Aug 2019 07:29:00 +0000
Subject: Re: [PATCH 00/16] ARM: remove ks8695 and w90x900 platforms
Message-Id: <20190810072900.GA16359@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190809202749.742267-1-arnd@arndb.de>
In-Reply-To: <20190809202749.742267-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: soc@kernel.org, "Wanzongshun (Vincent)" <wanzongshun@huawei.com>, Greg Ungerer <gerg@kernel.org>, linux-serial@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-spi@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 10:27:28PM +0200, Arnd Bergmann wrote:
> As discussed previously, these two ARM platforms have no
> known remaining users, let's remove them completely.
> 
> Subsystem maintainers: feel free to take the driver removals
> through your respective trees, they are all independent of
> one another. We can merge any remaining patches through the
> soc tree.

Serial and USB host controller driver patches applied, thanks!

greg k-h
