From: Russell King - ARM Linux <linux@armlinux.org.uk>
Date: Fri, 12 Aug 2016 15:29:40 +0000
Subject: Re: [PATCH RFC 5/5] drm/i2c: add tda998x/tda9950 CEC driver
Message-Id: <20160812152939.GG1041@n2100.armlinux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160812141421.GB1041@n2100.armlinux.org.uk>
 <E1bYDEx-0004ry-Jg@rmk-PC.armlinux.org.uk>
 <a9bc07ee-ae77-1791-ccf8-cb654cd4c302@cisco.com>
 <f656e9b9-edb1-f6d7-bf64-7d608f2f3890@cisco.com>
In-Reply-To: <f656e9b9-edb1-f6d7-bf64-7d608f2f3890@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans Verkuil <hansverk@cisco.com>
Cc: linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org

On Fri, Aug 12, 2016 at 05:16:41PM +0200, Hans Verkuil wrote:
> On 08/12/2016 04:38 PM, Hans Verkuil wrote:
> >On 08/12/2016 04:15 PM, Russell King wrote:
> >>Add a CEC driver for the TDA9950, which is a stand-alone I2C CEC device.
> >>The TDA9950 contains a command processor which handles retransmissions
> >>and the low level bus protocol.  The driver just has to read and write
> >>the messages, and handle error conditions.
> >>
> >>Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> >>---
> >> drivers/gpu/drm/i2c/Kconfig           |   5 +
> >> drivers/gpu/drm/i2c/Makefile          |   1 +
> >> drivers/gpu/drm/i2c/tda9950.c         | 514 ++++++++++++++++++++++++++++++++++
> >> include/linux/platform_data/tda9950.h |  15 +
> >> 4 files changed, 535 insertions(+)
> >> create mode 100644 drivers/gpu/drm/i2c/tda9950.c
> >> create mode 100644 include/linux/platform_data/tda9950.h
> >>
> >
> ><snip>
> >
> >>+static int tda9950_cec_adap_log_addr(struct cec_adapter *adap, u8 addr)
> >>+{
> >>+    struct tda9950_priv *priv = adap->priv;
> >>+    u16 addresses;
> >>+    u8 buf[2];
> >>+
> >>+    if (addr = CEC_LOG_ADDR_INVALID)
> >>+        addresses = priv->addresses = BIT(15);
> >
> >I saw this in patch 4/5 as well: why set bit 15? I would expect that this
> >is just set to 0. And priv->addresses doesn't seem to be used anywhere.
> 
> Yeah, you are right, priv->addresses is used. I've been reviewing too many
> patches today.
> 
> The whole BIT(15) part remains weird. If log_addr is called with
> LOG_ADDR_INVALID as argument, then the intention is that no more
> messages are to be received (unless the hardware is in snooping mode).
> So there is no need to receive broadcast messages either.

What about hardware where you can't stop it receiving broadcast
addresses?  Should drivers manually check for this in their
interrupt handler?

> That said, I now realize that if userspace wants to configure the CEC
> device as 'Unregistered', then adap_log_addr is never called, which
> would be required if the hardware has to enable support to receive
> broadcast messages.

I don't see how that could possibly work.  The CEC specification
requires that we receive broadcast addressed messages so that (eg)
the current source can be tracked.  Being present on the bus, and
participating as an active source requires the reception of
broadcast messages so that you know when you stop being an active
source.

Nothing (afaics) enables broadcast address reception in the kernel
side, nor using cec-ctl in userspace.

> >>+    else
> >>+        addresses = priv->addresses |= BIT(addr);
> >>+
> >>+    /* TDA9950 doesn't want address 15 set */
> >>+    addr &= 0x7fff;
> 
> Shouldn't this be 'addresses' instead of 'addr'? 'addr' makes no sense here.
> 
> And if so, then I still don't understand setting BIT(15), since that bit is
> removed by the &=.

You're right in this case, but for dw-hdmi, bit 15 must be set for
broadcast messages to be received.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
