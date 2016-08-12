From: Russell King - ARM Linux <linux@armlinux.org.uk>
Date: Fri, 12 Aug 2016 14:26:46 +0000
Subject: Re: [PATCH RFC 4/5] drm/bridge: add dw-hdmi cec driver using Hans Verkil's CEC code
Message-Id: <20160812142646.GD1041@n2100.armlinux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160812141421.GB1041@n2100.armlinux.org.uk>
 <E1bYDEs-0004rs-FP@rmk-PC.armlinux.org.uk>
 <d417880e-8628-5d90-9487-e88d283f309c@cisco.com>
In-Reply-To: <d417880e-8628-5d90-9487-e88d283f309c@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans Verkuil <hansverk@cisco.com>
Cc: linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org

On Fri, Aug 12, 2016 at 04:25:02PM +0200, Hans Verkuil wrote:
> On 08/12/2016 04:15 PM, Russell King wrote:
> >Add a CEC driver for the dw-hdmi hardware using Hans Verkil's CEC
> 
> That's Verkuil :-)

Oops, sorry about that.

> BTW, since cec is part of the media subsystem please include linux-media
> for the next round.

I can't guarantee that, I'm quite forgetful.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
