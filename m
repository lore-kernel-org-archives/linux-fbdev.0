From: Hans Verkuil <hansverk@cisco.com>
Date: Fri, 12 Aug 2016 14:38:04 +0000
Subject: Re: [PATCH RFC 5/5] drm/i2c: add tda998x/tda9950 CEC driver
Message-Id: <a9bc07ee-ae77-1791-ccf8-cb654cd4c302@cisco.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160812141421.GB1041@n2100.armlinux.org.uk>
 <E1bYDEx-0004ry-Jg@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1bYDEx-0004ry-Jg@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <rmk+kernel@armlinux.org.uk>, David Airlie <airlied@linux.ie>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org

On 08/12/2016 04:15 PM, Russell King wrote:
> Add a CEC driver for the TDA9950, which is a stand-alone I2C CEC device.
> The TDA9950 contains a command processor which handles retransmissions
> and the low level bus protocol.  The driver just has to read and write
> the messages, and handle error conditions.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/gpu/drm/i2c/Kconfig           |   5 +
>  drivers/gpu/drm/i2c/Makefile          |   1 +
>  drivers/gpu/drm/i2c/tda9950.c         | 514 ++++++++++++++++++++++++++++++++++
>  include/linux/platform_data/tda9950.h |  15 +
>  4 files changed, 535 insertions(+)
>  create mode 100644 drivers/gpu/drm/i2c/tda9950.c
>  create mode 100644 include/linux/platform_data/tda9950.h
>

<snip>

> +static int tda9950_cec_adap_log_addr(struct cec_adapter *adap, u8 addr)
> +{
> +	struct tda9950_priv *priv = adap->priv;
> +	u16 addresses;
> +	u8 buf[2];
> +
> +	if (addr = CEC_LOG_ADDR_INVALID)
> +		addresses = priv->addresses = BIT(15);

I saw this in patch 4/5 as well: why set bit 15? I would expect that this
is just set to 0. And priv->addresses doesn't seem to be used anywhere.

> +	else
> +		addresses = priv->addresses |= BIT(addr);
> +
> +	/* TDA9950 doesn't want address 15 set */
> +	addr &= 0x7fff;
> +	buf[0] = addresses >> 8;
> +	buf[1] = addresses;
> +
> +	return tda9950_write_range(priv->client, REG_ACKH, buf, 2);
> +}
> +

<snip>

> +static int tda9950_cec_adap_enable(struct cec_adapter *adap, bool enable)
> +{
> +	struct tda9950_priv *priv = adap->priv;
> +
> +	if (!enable) {
> +		tda9950_release(priv);
> +		return 0;
> +	} else {

Nitpick: no need for 'else' here since the 'if' always returns.

> +		return tda9950_open(priv);
> +	}
> +}

Regards,

	Hans

