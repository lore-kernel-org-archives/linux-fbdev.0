From: Russell King - ARM Linux <linux@armlinux.org.uk>
Date: Wed, 31 Aug 2016 12:28:35 +0000
Subject: Re: [PATCH RFC 4/5] drm/bridge: add dw-hdmi cec driver using Hans Verkil's CEC code
Message-Id: <20160831122835.GT1041@n2100.armlinux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160812141421.GB1041@n2100.armlinux.org.uk>
 <E1bYDEs-0004rs-FP@rmk-PC.armlinux.org.uk>
 <dcd9587f-be60-0cb6-92bb-3226c51bddfb@xs4all.nl>
 <20160823075950.GC1041@n2100.armlinux.org.uk>
 <57BC03D9.10707@cisco.com>
In-Reply-To: <57BC03D9.10707@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans Verkuil <hansverk@cisco.com>
Cc: linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil@xs4all.nl>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org

On Tue, Aug 23, 2016 at 10:05:45AM +0200, Hans Verkuil wrote:
> 
> 
> On 08/23/16 09:59, Russell King - ARM Linux wrote:
> > On Tue, Aug 23, 2016 at 09:21:17AM +0200, Hans Verkuil wrote:
> >> Hi Russell,
> >>
> >> On 08/12/2016 04:15 PM, Russell King wrote:
> >>> Add a CEC driver for the dw-hdmi hardware using Hans Verkil's CEC
> >>> implementation.
> >>>
> >>> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> >>> ---
> >>>  drivers/gpu/drm/bridge/Kconfig            |   7 +
> >>>  drivers/gpu/drm/bridge/Makefile           |   1 +
> >>>  drivers/gpu/drm/bridge/dw-hdmi-cec.c      | 344 ++++++++++++++++++++++++++++++
> >>>  drivers/gpu/drm/bridge/dw-hdmi.c          |  64 +++++-
> >>>  include/linux/platform_data/dw_hdmi-cec.h |  16 ++
> >>>  5 files changed, 421 insertions(+), 11 deletions(-)
> >>>  create mode 100644 drivers/gpu/drm/bridge/dw-hdmi-cec.c
> >>>  create mode 100644 include/linux/platform_data/dw_hdmi-cec.h
> >>>
> >>
> >> <snip>
> >>
> >>> +static unsigned int parse_hdmi_addr(const struct edid *edid)
> >>> +{
> >>> +	if (!edid || edid->extensions = 0)
> >>> +		return (u16)~0;
> >>> +
> >>> +	return cec_get_edid_phys_addr((u8 *)edid,
> >>> +				EDID_LENGTH * (edid->extensions + 1), NULL);
> >>> +}
> >>> +
> >>> +static int dw_hdmi_cec_notify(struct notifier_block *nb, unsigned long event,
> >>> +			      void *data)
> >>> +{
> >>> +	struct dw_hdmi_cec *cec = container_of(nb, struct dw_hdmi_cec, nb);
> >>> +	union hdmi_event *event_block = data;
> >>> +	unsigned int phys;
> >>> +
> >>> +	dev_info(event_block->base.source, "event %lu\n", event);
> >>> +
> >>> +	if (event_block->base.source != cec->adap->devnode.parent)
> >>> +		return NOTIFY_OK;
> >>> +
> >>> +	switch (event) {
> >>> +	case HDMI_CONNECTED:
> >>> +		break;
> >>> +
> >>> +	case HDMI_DISCONNECTED:
> >>> +		cec_s_phys_addr(cec->adap, CEC_PHYS_ADDR_INVALID, false);
> >>> +		break;
> >>> +
> >>> +	case HDMI_NEW_EDID:
> >>> +		phys = parse_hdmi_addr(event_block->edid.edid);
> >>> +		cec_s_phys_addr(cec->adap, phys, false);
> >>> +		break;
> >>> +	}
> >>> +
> >>> +	return NOTIFY_OK;
> >>> +}
> >>
> >> Wouldn't it make a lot of sense to integrate this into the cec framework?
> >>
> >> All you need is to pass an hdmi_notifier_dev as argument to cec_allocate_adapter()
> >> and you can integrate this.
> >>
> >> If you are OK with that, then I can make patches for that.
> > 
> > It's not just about CEC.  It's also used for passing information between
> > the video and audio parts, so tying this into CEC is wrong.
> 
> I'm not saying that the hdmi notifier should be integrated, just that the
> CEC core can register itself as a notifier and handle cec_s_phys_addr.

Yes, that would decrease the amount of code duplication.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
