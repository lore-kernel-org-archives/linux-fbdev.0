From: Dave Airlie <airlied@gmail.com>
Date: Wed, 23 Mar 2011 00:46:03 +0000
Subject: Re: [RFC PATCH] HDMI:Support for EDID parsing in kernel.
Message-Id: <AANLkTim61Xdo6ED7mr_SvpLuotso89RdR6Qaz-GCXOmJ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1300815176-21206-1-git-send-email-mythripk@ti.com>
In-Reply-To: <1300815176-21206-1-git-send-email-mythripk@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Mythri P K <mythripk@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-media@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>

On Wed, Mar 23, 2011 at 3:32 AM, Mythri P K <mythripk@ti.com> wrote:
> Adding support for common EDID parsing in kernel.
>
> EDID - Extended display identification data is a data structure provided =
by
> a digital display to describe its capabilities to a video source, This a
> standard supported by CEA and VESA.
>
> There are several custom implementations for parsing EDID in kernel, some
> of them are present in fbmon.c, drm_edid.c, sh_mobile_hdmi.c, Ideally
> parsing of EDID should be done in a library, which is agnostic of the
> framework (V4l2, DRM, FB) =A0which is using the functionality, just based=
 on
> the raw EDID pointer with size/segment information.
>
> With other RFC's such as the one below, which tries to standardize HDMI A=
PI's
> It would be better to have a common EDID code in one place.It also helps =
to
> provide better interoperability with variety of TV/Monitor may be even by
> listing out quirks which might get missed with several custom implementat=
ion
> of EDID.
> http://permalink.gmane.org/gmane.linux.drivers.video-input-infrastructure=
/30401
>
> This patch tries to add functions to parse some portion EDID (detailed ti=
ming,
> monitor limits, AV delay information, deep color mode support, Audio and =
VSDB)
> If we can align on this library approach i can enhance this library to pa=
rse
> other blocks and probably we could also add quirks from other implementat=
ion
> as well.
>

If you want to take this approach, you need to start from the DRM EDID pars=
er,
its the most well tested and I can guarantee its been plugged into more mon=
itors
than any of the others. There is just no way we would move the DRM parser t=
o a
library one that isn't derived from it + enhancements, as we'd throw away t=
he
years of testing and the regression count would be way too high.

Dave.
