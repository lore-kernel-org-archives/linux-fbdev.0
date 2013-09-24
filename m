From: Randy Dunlap <rdunlap@infradead.org>
Date: Tue, 24 Sep 2013 19:05:15 +0000
Subject: Re: linux-next: Tree for Sep 24 (video/mb862xx)
Message-Id: <5241E26B.3080901@infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130924144341.772ef648fe8ea2137160596f@canb.auug.org.au>
In-Reply-To: <20130924144341.772ef648fe8ea2137160596f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Anatolij Gustschin <agust@denx.de>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>

On 09/23/13 21:43, Stephen Rothwell wrote:
> Hi all,
> 
> 
> Changes since 20130923:
> 

on i386:

when CONFIG_I2C=m and
CONFIG_FB_MB862XX=y
CONFIG_FB_MB862XX_PCI_GDC=y
CONFIG_FB_MB862XX_I2C=y


drivers/built-in.o: In function `mb862xx_i2c_init':
(.text+0x68a1c): undefined reference to `i2c_add_adapter'
drivers/built-in.o: In function `mb862xx_i2c_exit':
(.text+0x68a6e): undefined reference to `i2c_del_adapter'


Caused by this kconfig bool:
config FB_MB862XX_I2C
	bool "Support I2C bus on MB862XX GDC"
	depends on FB_MB862XX && I2C
	default y

which = 'y' even when CONFIG_I2C = m.




-- 
~Randy
