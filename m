From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Date: Fri, 27 Mar 2020 12:56:26 +0000
Subject: Re: [Intel-gfx] [PATCH v7 05/18] video/hdmi: Add Unpack only function for DRM infoframe
Message-Id: <20200327125626.GE13686@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200211074657.231405-1-gwan-gyeong.mun@intel.com>
 <20200211074657.231405-6-gwan-gyeong.mun@intel.com>
 <87k13fcm8w.fsf@intel.com> <87h7yjcldq.fsf@intel.com>
 <20200320115737.GF5193@pendragon.ideasonboard.com>
 <2dd87897a2c1dea8d882141823ed1ca1206ec01c.camel@intel.com>
In-Reply-To: <2dd87897a2c1dea8d882141823ed1ca1206ec01c.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Mun, Gwan-gyeong" <gwan-gyeong.mun@intel.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "hverkuil@xs4all.nl" <hverkuil@xs4all.nl>, "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>

On Fri, Mar 27, 2020 at 07:27:56AM +0000, Mun, Gwan-gyeong wrote:
> On Fri, 2020-03-20 at 13:57 +0200, Laurent Pinchart wrote:
> > Hi Jani,
> >=20
> > On Fri, Mar 20, 2020 at 01:32:17PM +0200, Jani Nikula wrote:
> > > On Fri, 20 Mar 2020, Jani Nikula <jani.nikula@linux.intel.com>
> > > wrote:
> > > > On Tue, 11 Feb 2020, Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> > > > wrote:
> > > > > It adds an unpack only function for DRM infoframe for dynamic
> > > > > range and
> > > > > mastering infoframe readout.
> > > > > It unpacks the information data block contained in the binary
> > > > > buffer into
> > > > > a structured frame of the HDMI Dynamic Range and Mastering
> > > > > (DRM)
> > > > > information frame.
> > > > >=20
> > > > > In contrast to hdmi_drm_infoframe_unpack() function, it does
> > > > > not verify
> > > > > a checksum.
> > > > >=20
> > > > > It can be used for unpacking a DP HDR Metadata Infoframe SDP
> > > > > case.
> > > > > DP HDR Metadata Infoframe SDP uses the same Dynamic Range and
> > > > > Mastering
> > > > > (DRM) information (CTA-861-G spec.) such as HDMI DRM infoframe.
> > > > > But DP SDP header and payload structure are different from HDMI
> > > > > DRM
> > > > > Infoframe. Therefore unpacking DRM infoframe for DP requires
> > > > > skipping of
> > > > > a verifying checksum.
> > > > >=20
> > > > > Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> > > > > Reviewed-by: Uma Shankar <uma.shankar@intel.com>
> > > >=20
> > > > Bartlomiej, can I have your ack for merging this via drm-intel
> > > > along
> > > > with the rest of the series, please?
> > >=20
> > > Or Hans or Laurent, from v4l/video point of view.
> >=20
> > I'm no expert on InfoFrame, I'll only comment on the API below.
> >=20
> > > > > ---
> > > > >  drivers/video/hdmi.c | 58 +++++++++++++++++++++++++++++++-----
> > > > > --------
> > > > >  include/linux/hdmi.h |  2 ++
> > > > >  2 files changed, 43 insertions(+), 17 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
> > > > > index 9c82e2a0a411..9818836d82b7 100644
> > > > > --- a/drivers/video/hdmi.c
> > > > > +++ b/drivers/video/hdmi.c
> > > > > @@ -1775,20 +1775,18 @@ hdmi_vendor_any_infoframe_unpack(union
> > > > > hdmi_vendor_any_infoframe *frame,
> > > > >  }
> > > > > =20
> > > > >  /**
> > > > > - * hdmi_drm_infoframe_unpack() - unpack binary buffer to a
> > > > > HDMI DRM infoframe
> > > > > + * hdmi_drm_infoframe_unpack_only() - unpack binary buffer to
> > > > > a HDMI DRM infoframe
> > > > >   * @frame: HDMI DRM infoframe
> > > > >   * @buffer: source buffer
> > > > >   * @size: size of buffer
> > > > >   *
> > > > > - * Unpacks the information contained in binary @buffer into a
> > > > > structured
> > > > > + * Unpacks the information data block contained in binary
> > > > > @buffer into a structured
> >=20
> > Line wrap please.
> >=20
> > This needs to be clarified to explain exactly what the buffer points
> > to.
> >=20
> Okay I'll update clear comments next version.
> > Also, as this is applicable to DP too, shouldn't we drop the hdmi_
> > prefix ? Is there another prefix that could be used for functions
> > that
> > are application to infoframe handling shared by different display
> > interfaces ? A bit of refactoring would help making all this clear.
> >=20
> Both DP and HDMI use CTA-861-G spec for DRM infoframe. I'll update
> prefix with cta_ instead of hdmi_.

Most of video/hdmi.c is from the CTA spec(s). The name is just a name.
Let's not start making it inconsistent just for this one case.

--=20
Ville Syrj=E4l=E4
Intel
