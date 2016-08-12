From: Hans Verkuil <hansverk@cisco.com>
Date: Fri, 12 Aug 2016 14:25:02 +0000
Subject: Re: [PATCH RFC 4/5] drm/bridge: add dw-hdmi cec driver using Hans Verkil's CEC code
Message-Id: <d417880e-8628-5d90-9487-e88d283f309c@cisco.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160812141421.GB1041@n2100.armlinux.org.uk>
 <E1bYDEs-0004rs-FP@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1bYDEs-0004rs-FP@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <rmk+kernel@arm.linux.org.uk>, David Airlie <airlied@linux.ie>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org

On 08/12/2016 04:15 PM, Russell King wrote:
> Add a CEC driver for the dw-hdmi hardware using Hans Verkil's CEC

That's Verkuil :-)

BTW, since cec is part of the media subsystem please include linux-media for the next round.

Regards,

	Hans
