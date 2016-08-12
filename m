From: Russell King - ARM Linux <linux@armlinux.org.uk>
Date: Fri, 12 Aug 2016 14:52:13 +0000
Subject: Re: [PATCH RFC 5/5] drm/i2c: add tda998x/tda9950 CEC driver
Message-Id: <20160812145212.GF1041@n2100.armlinux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160812141421.GB1041@n2100.armlinux.org.uk>
 <E1bYDEx-0004ry-Jg@rmk-PC.armlinux.org.uk>
 <a9bc07ee-ae77-1791-ccf8-cb654cd4c302@cisco.com>
In-Reply-To: <a9bc07ee-ae77-1791-ccf8-cb654cd4c302@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans Verkuil <hansverk@cisco.com>
Cc: linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org

On Fri, Aug 12, 2016 at 04:38:04PM +0200, Hans Verkuil wrote:
> On 08/12/2016 04:15 PM, Russell King wrote:
> >Add a CEC driver for the TDA9950, which is a stand-alone I2C CEC device.
> >The TDA9950 contains a command processor which handles retransmissions
> >and the low level bus protocol.  The driver just has to read and write
> >the messages, and handle error conditions.
> >
> >Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> >---
> > drivers/gpu/drm/i2c/Kconfig           |   5 +
> > drivers/gpu/drm/i2c/Makefile          |   1 +
> > drivers/gpu/drm/i2c/tda9950.c         | 514 ++++++++++++++++++++++++++++++++++
> > include/linux/platform_data/tda9950.h |  15 +
> > 4 files changed, 535 insertions(+)
> > create mode 100644 drivers/gpu/drm/i2c/tda9950.c
> > create mode 100644 include/linux/platform_data/tda9950.h
> >
> 
> <snip>
> 
> >+static int tda9950_cec_adap_log_addr(struct cec_adapter *adap, u8 addr)
> >+{
> >+	struct tda9950_priv *priv = adap->priv;
> >+	u16 addresses;
> >+	u8 buf[2];
> >+
> >+	if (addr = CEC_LOG_ADDR_INVALID)
> >+		addresses = priv->addresses = BIT(15);
> 
> I saw this in patch 4/5 as well: why set bit 15? I would expect that this
> is just set to 0. And priv->addresses doesn't seem to be used anywhere.

It's needed to be set so that the hardware receives messages sent
to the broadcast (15) address.

> >+	else
> >+		addresses = priv->addresses |= BIT(addr);

For the second point, read this line, paying close attention to the |=.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
