From: Sean Paul <sean@poorly.run>
Date: Thu, 23 May 2019 17:13:41 +0000
Subject: Re: [PATCH] drm/mediatek: Fix warning about unhandled enum value
Message-Id: <20190523171341.GE17077@art_vandelay>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190522202207.223110-1-sean@poorly.run>
 <1558592000.552.3.camel@mtksdaap41>
In-Reply-To: <1558592000.552.3.camel@mtksdaap41>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: CK Hu <ck.hu@mediatek.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maxime Ripard <maxime.ripard@bootlin.com>, dri-devel@lists.freedesktop.org, Hans Verkuil <hansverk@cisco.com>, David Airlie <airlied@linux.ie>, Uma Shankar <uma.shankar@intel.com>, Sean Paul <seanpaul@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org, Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org

On Thu, May 23, 2019 at 02:13:20PM +0800, CK Hu wrote:
> Hi, Sean:
> 
> On Wed, 2019-05-22 at 16:21 -0400, Sean Paul wrote:
> > From: Sean Paul <seanpaul@chromium.org>
> > 
> > Fixes the following build warning:
> > drivers/gpu/drm/mediatek/mtk_hdmi.c:327:2: warning: enumeration value ‘HDMI_INFOFRAME_TYPE_DRM’ not handled in switch [-Wswitch]
> > 
> > Introduced with the addition of HDMI_INFOFRAME_TYPE_DRM in the commit
> > below, but the code really should have been future-proofed from the
> > start.
> 
> Acked-by: CK Hu <ck.hu@mediatek.com>
> 
> > 
> > Fixes: 2cdbfd66a829 ("drm: Enable HDR infoframe support")
> 
> I think "drm: Enable HDR infoframe support" exist only in drm-misc tree,
> could you just merge this patch to "drm: Enable HDR infoframe support"?

Yes, I've applied it to drm-misc-next. Thanks for your Ack!

Sean

> 
> Regards,
> CK
> 
> > Cc: Uma Shankar <uma.shankar@intel.com>
> > Cc: Shashank Sharma <shashank.sharma@intel.com>
> > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> > Cc: Sean Paul <sean@poorly.run>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: "Ville Syrjälä" <ville.syrjala@linux.intel.com>
> > Cc: Hans Verkuil <hansverk@cisco.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-fbdev@vger.kernel.org
> > Signed-off-by: Sean Paul <seanpaul@chromium.org>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_hdmi.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> > index e04e6c293d39..10cc9910f164 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> > @@ -341,6 +341,9 @@ static void mtk_hdmi_hw_send_info_frame(struct mtk_hdmi *hdmi, u8 *buffer,
> >  		ctrl_frame_en = VS_EN;
> >  		ctrl_reg = GRL_ACP_ISRC_CTRL;
> >  		break;
> > +	default:
> > +		dev_err(hdmi->dev, "Unknown infoframe type %d\n", frame_type);
> > +		return;
> >  	}
> >  	mtk_hdmi_clear_bits(hdmi, ctrl_reg, ctrl_frame_en);
> >  	mtk_hdmi_write(hdmi, GRL_INFOFRM_TYPE, frame_type);
> 
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
