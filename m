From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Thu, 24 Apr 2014 12:32:35 +0000
Subject: Re: [PATCH 03/13] video: clarify I2C dependencies
Message-Id: <20140424123235.GS26756@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398342509-10243-1-git-send-email-peter.griffin@linaro.org> <1398342509-10243-4-git-send-email-peter.griffin@linaro.org>
In-Reply-To: <1398342509-10243-4-git-send-email-peter.griffin@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Anatolij Gustschin <agust@denx.de>

On Thu, Apr 24, 2014 at 01:28:19PM +0100, Peter Griffin wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> We can only use I2C support in frame buffer drivers if
> Either I2C is built-in, or both I2C and the driver itself
> are loadable modules.

Why?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
