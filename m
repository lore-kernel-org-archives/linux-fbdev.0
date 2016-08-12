From: Russell King - ARM Linux <linux@armlinux.org.uk>
Date: Fri, 12 Aug 2016 15:59:03 +0000
Subject: Re: [PATCH RFC 5/5] drm/i2c: add tda998x/tda9950 CEC driver
Message-Id: <20160812155902.GH1041@n2100.armlinux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160812141421.GB1041@n2100.armlinux.org.uk>
 <E1bYDEx-0004ry-Jg@rmk-PC.armlinux.org.uk>
 <a9bc07ee-ae77-1791-ccf8-cb654cd4c302@cisco.com>
 <f656e9b9-edb1-f6d7-bf64-7d608f2f3890@cisco.com>
 <20160812152939.GG1041@n2100.armlinux.org.uk>
 <7722d4a0-03f6-3858-0771-e6598d838b65@cisco.com>
In-Reply-To: <7722d4a0-03f6-3858-0771-e6598d838b65@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans Verkuil <hansverk@cisco.com>
Cc: linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org

On Fri, Aug 12, 2016 at 05:53:17PM +0200, Hans Verkuil wrote:
> There are three possible 'states' of a CEC adapter w.r.t. logical addresses:
> 
> 1) There is no physical address or no logical addresses have been set
> by the application (CEC_ADAP_S_LOG_ADDRS): in that case the device
> will not participate on the bus, it doesn't care about receiving messages
> let alone replying to them. The only exception is if the device can
> snoop messages, that is allowed even if CEC_ADAP_S_LOG_ADDRS is never
> called. That is ideal to have a 'neutral' observer of the bus that just
> listens but never participates. Not all hardware supports snooping, though.
> 
> 2) CEC_ADAP_S_LOG_ADDRS is called and the device becomes an 'Unregistered'
> device (i.e. it gets logical address 15). In that case it should receive
> broadcast messages and be able to transmit messages.
> 
> 3) CEC_ADAP_S_LOG_ADDRS is called and the device claims one or more logical
> addresses in the range 0-14. Then it can receive broadcast and directed
> messages, and of course transmit messages.
> 
> From the point of view of the hardware state 1 is selected if adap_log_addr
> is called with LOG_ADDR_INVALID. Some hardware might still receive broadcast
> messages (because they can't turn that off) and those should be filtered out
> by the CEC framework. But I think that doesn't happen, which would be a bug.
> I'll verify that tomorrow.
> 
> State 2 is a problem for hardware that has to enable support to receive
> broadcast messages since adap_log_addr is never called with
> LOG_ADDR_UNREGISTERED as argument. I missed that, since the hardware I tested
> with always accepts broadcast messages. I'll look into this tomorrow as well.
> It should be easy to fix.
> 
> State 3 works OK.
> 
> So for the dw-hdmi cec driver that means that for state 1 you set 'addresses'
> to 0, for state 2 you set it to BIT(15) and for state 3 you always
> OR with BIT(15). At least, as I understand your hardware.

Thanks, I think that needs documenting in Documentation/cec.txt.

> BTW, if either the tda or dw-hdmi supports snooping mode, then I strongly
> recommend supporting that. It's great for debugging.

Neither do.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
