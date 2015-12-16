From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 16 Dec 2015 15:52:50 +0000
Subject: Re: [PATCH RFC 0/9] omapdrm/omapfb/omapdss split
Message-Id: <567188D2.4020008@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="pXfAc58dJbpe2DUk1c35Ek6cdCw5cL2lw"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449757535-5674-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1449757535-5674-1-git-send-email-tomi.valkeinen@ti.com>
To: Dave Airlie <airlied@linux.ie>
Cc: linux-fbdev@vger.kernel.org, Emil Velikov <emil.l.velikov@gmail.com>, dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

--pXfAc58dJbpe2DUk1c35Ek6cdCw5cL2lw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On 10/12/15 16:25, Tomi Valkeinen wrote:
> Hi,
>=20
> Here's an RFC series to fix the mess we have at the moment with
> omapdrm/omapfb/omapdss.

There hasn't been any NACKs for this series, so I'd like to get this in
for 4.5.

As it's mostly on the fbdev side, I can merge this via fbdev tree. Only
the two last patches are under drivers/gpu/ and it's unlikely they cause
any conflicts, as they mainly just move files from drivers/fbdev/ to
drivers/gpu/ (and they don't cause conflicts at the moment with my other
omapdrm patches, nor with current drm-next).

Can I get your ack on the two last patches?

 Tomi

> First, a short background on the current status. We have the following
> entities:
>=20
> * omapdss, located in drivers/video/fbdev/omap2/dss/. This is a driver =
for the
>   display subsystem IPs used on OMAP (and related) SoCs. It offers only=
 a
>   kernel internal API, and does not implement anything for fbdev or drm=
=2E
>=20
> * omapdss panels and encoders, located in
>   drivers/video/fbdev/omap2/displays-new/. These are panel and external=
 encoder
>   drivers, which use APIs offered by omapdss driver. These also don't i=
mplement
>   anything for fbdev or drm.
>=20
> * omapdrm, located in drivers/gpu/drm/omapdrm/. This is a drm driver, w=
hich
>   uses omapdss and the panel/encoder drivers to operate the hardware.
>=20
> * omapfb, located in drivers/video/fbdev/omap2/omapfb/. This is an fbde=
v
>   driver, which uses omapdss and the panel/encoder drivers to operate t=
he
>   hardware.
>=20
> * omap_vout, located in drivers/media/platform/omap/. This is a v4l2 dr=
iver,
>   which uses omapdss and omapfb to implement a v4l2 API for the video o=
verlays.
>=20
> So, on the top level, we have either omapdrm, or omapfb+omap_vout. Both=
 of
> those use the same low level drivers. Without going to the historical d=
etails
> why the architecture is like that, I think it's finally time to change =
that.
>=20
> The situation with omapfb+omap_vout is that it still works, but no new =
features
> have been added for a long time, and I want to keep it working as it's =
still
> being used.  At some point in the future I'd like to remove omapfb and
> omap_vout altogether.
>=20
> Omapdrm, on the other hand, is being actively developed. Sharing the lo=
w level
> parts with omapfb makes that development more difficult than it should =
be. It
> also "hides" half of the development, as everything happening in the lo=
w level
> parts resides under fbdev directory, not in the drm directory.
>=20
> I've been wanting to clean this up for a long time, but I haven't figur=
ed out a
> very good way to do it. I still haven't, but here's the best way I have=
 come up
> with.
>=20
> This series makes a full copy of the low level parts, omapdss and panel=
/encoder
> drivers. Both omapfb+omap_vout and omapdrm will have their own versions=
=2E The
> copy omapfb+omap_vout get is a new copy, and the copy that omapdrm gets=
 is just
> the current files moved. This way git will associate the omapdrm versio=
n with
> the old files.
>=20
> The omapfb+omap_vout versions won't be touched unless there are some bi=
g issues
> there.
>=20
> The omapdrm versions can be refactored and cleaned up, as the omapfb su=
pport
> code is no longer needed. We can perhaps also merge omapdss and omapdrm=
 into
> the same kernel module.
>=20
> This series only does the copy, and the absolutely necessary parts. No =
further
> cleanups are done yet.
>=20
>  Tomi
>=20
> Tomi Valkeinen (9):
>   omapfb: allow compilation only if DRM_OMAP is disabled
>   omapfb: copy omapdss & displays for omapfb
>   omapdss: remove CONFIG_OMAP2_DSS_VENC from omapdss.h
>   omapfb/dss: change CONFIG_OMAP* to CONFIG_FB_OMAP*
>   omapfb/displays: change CONFIG_DISPLAY_* to CONFIG_FB_OMAP2_*
>   omapfb: take omapfb's prive omapdss into use
>   omapfb: move vrfb into omapfb
>   drm/omap: move omapdss & displays under omapdrm
>   drm/omap: make omapdrm select OMAP2_DSS
>=20
>  drivers/gpu/drm/Makefile                           |    2 +-
>  drivers/gpu/drm/omapdrm/Kconfig                    |   10 +-
>  drivers/gpu/drm/omapdrm/Makefile                   |    3 +
>  .../drm/omapdrm/displays}/Kconfig                  |    3 +-
>  .../drm/omapdrm/displays}/Makefile                 |    0
>  .../drm/omapdrm/displays}/connector-analog-tv.c    |    0
>  .../drm/omapdrm/displays}/connector-dvi.c          |    0
>  .../drm/omapdrm/displays}/connector-hdmi.c         |    0
>  .../drm/omapdrm/displays}/encoder-opa362.c         |    0
>  .../drm/omapdrm/displays}/encoder-tfp410.c         |    0
>  .../drm/omapdrm/displays}/encoder-tpd12s015.c      |    0
>  .../drm/omapdrm/displays}/panel-dpi.c              |    0
>  .../drm/omapdrm/displays}/panel-dsi-cm.c           |    0
>  .../omapdrm/displays}/panel-lgphilips-lb035q02.c   |    0
>  .../drm/omapdrm/displays}/panel-nec-nl8048hl11.c   |    0
>  .../omapdrm/displays}/panel-sharp-ls037v7dw01.c    |    0
>  .../drm/omapdrm/displays}/panel-sony-acx565akm.c   |    0
>  .../drm/omapdrm/displays}/panel-tpo-td028ttec1.c   |    0
>  .../drm/omapdrm/displays}/panel-tpo-td043mtea1.c   |    0
>  .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/Kconfig    |    0
>  .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/Makefile   |    0
>  .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/apply.c    |    0
>  .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/core.c     |    0
>  .../omap2 =3D> gpu/drm/omapdrm}/dss/dispc-compat.c   |    0
>  .../omap2 =3D> gpu/drm/omapdrm}/dss/dispc-compat.h   |    0
>  .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dispc.c    |    0
>  .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dispc.h    |    0
>  .../omap2 =3D> gpu/drm/omapdrm}/dss/dispc_coefs.c    |    0
>  .../omap2 =3D> gpu/drm/omapdrm}/dss/display-sysfs.c  |    0
>  .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/display.c  |    0
>  .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dpi.c      |    0
>  .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dsi.c      |    0
>  .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dss-of.c   |    0
>  .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dss.c      |    0
>  .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dss.h      |    0
>  .../omap2 =3D> gpu/drm/omapdrm}/dss/dss_features.c   |    0
>  .../omap2 =3D> gpu/drm/omapdrm}/dss/dss_features.h   |    0
>  .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi.h     |    0
>  .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi4.c    |    0
>  .../omap2 =3D> gpu/drm/omapdrm}/dss/hdmi4_core.c     |    0
>  .../omap2 =3D> gpu/drm/omapdrm}/dss/hdmi4_core.h     |    0
>  .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi5.c    |    0
>  .../omap2 =3D> gpu/drm/omapdrm}/dss/hdmi5_core.c     |    0
>  .../omap2 =3D> gpu/drm/omapdrm}/dss/hdmi5_core.h     |    0
>  .../omap2 =3D> gpu/drm/omapdrm}/dss/hdmi_common.c    |    0
>  .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi_phy.c |    0
>  .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi_pll.c |    0
>  .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi_wp.c  |    0
>  .../omap2 =3D> gpu/drm/omapdrm}/dss/manager-sysfs.c  |    0
>  .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/manager.c  |    0
>  .../drm/omapdrm}/dss/omapdss-boot-init.c           |    0
>  .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/output.c   |    0
>  .../omap2 =3D> gpu/drm/omapdrm}/dss/overlay-sysfs.c  |    0
>  .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/overlay.c  |    0
>  .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/pll.c      |    0
>  .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/rfbi.c     |    0
>  .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/sdi.c      |    0
>  .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/venc.c     |    0
>  .../omap2 =3D> gpu/drm/omapdrm}/dss/video-pll.c      |    0
>  drivers/media/platform/omap/Kconfig                |    2 +-
>  drivers/video/fbdev/omap2/Kconfig                  |    5 -
>  drivers/video/fbdev/omap2/Makefile                 |    6 +-
>  drivers/video/fbdev/omap2/omapfb/Kconfig           |   14 +-
>  drivers/video/fbdev/omap2/omapfb/Makefile          |    3 +
>  drivers/video/fbdev/omap2/omapfb/displays/Kconfig  |   86 +
>  drivers/video/fbdev/omap2/omapfb/displays/Makefile |   14 +
>  .../omap2/omapfb/displays/connector-analog-tv.c    |  320 ++
>  .../fbdev/omap2/omapfb/displays/connector-dvi.c    |  398 ++
>  .../fbdev/omap2/omapfb/displays/connector-hdmi.c   |  348 ++
>  .../fbdev/omap2/omapfb/displays/encoder-opa362.c   |  278 +
>  .../fbdev/omap2/omapfb/displays/encoder-tfp410.c   |  320 ++
>  .../omap2/omapfb/displays/encoder-tpd12s015.c      |  379 ++
>  .../video/fbdev/omap2/omapfb/displays/panel-dpi.c  |  330 ++
>  .../fbdev/omap2/omapfb/displays/panel-dsi-cm.c     | 1388 +++++
>  .../omapfb/displays/panel-lgphilips-lb035q02.c     |  404 ++
>  .../omap2/omapfb/displays/panel-nec-nl8048hl11.c   |  437 ++
>  .../omapfb/displays/panel-sharp-ls037v7dw01.c      |  415 ++
>  .../omap2/omapfb/displays/panel-sony-acx565akm.c   |  917 ++++
>  .../omap2/omapfb/displays/panel-tpo-td028ttec1.c   |  511 ++
>  .../omap2/omapfb/displays/panel-tpo-td043mtea1.c   |  686 +++
>  drivers/video/fbdev/omap2/omapfb/dss/Kconfig       |  129 +
>  drivers/video/fbdev/omap2/omapfb/dss/Makefile      |   18 +
>  drivers/video/fbdev/omap2/omapfb/dss/apply.c       | 1702 ++++++
>  drivers/video/fbdev/omap2/omapfb/dss/core.c        |  343 ++
>  .../video/fbdev/omap2/omapfb/dss/dispc-compat.c    |  667 +++
>  .../video/fbdev/omap2/omapfb/dss/dispc-compat.h    |   30 +
>  drivers/video/fbdev/omap2/omapfb/dss/dispc.c       | 4135 ++++++++++++=
+++
>  drivers/video/fbdev/omap2/omapfb/dss/dispc.h       |  916 ++++
>  drivers/video/fbdev/omap2/omapfb/dss/dispc_coefs.c |  325 ++
>  .../video/fbdev/omap2/omapfb/dss/display-sysfs.c   |  356 ++
>  drivers/video/fbdev/omap2/omapfb/dss/display.c     |  338 ++
>  drivers/video/fbdev/omap2/omapfb/dss/dpi.c         |  899 ++++
>  drivers/video/fbdev/omap2/omapfb/dss/dsi.c         | 5607 ++++++++++++=
++++++++
>  drivers/video/fbdev/omap2/omapfb/dss/dss-of.c      |  183 +
>  drivers/video/fbdev/omap2/omapfb/dss/dss.c         | 1323 +++++
>  drivers/video/fbdev/omap2/omapfb/dss/dss.h         |  472 ++
>  .../video/fbdev/omap2/omapfb/dss/dss_features.c    |  962 ++++
>  .../video/fbdev/omap2/omapfb/dss/dss_features.h    |  105 +
>  drivers/video/fbdev/omap2/omapfb/dss/hdmi.h        |  370 ++
>  drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c       |  839 +++
>  drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c  |  904 ++++
>  drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.h  |  273 +
>  drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c       |  876 +++
>  drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c  |  916 ++++
>  drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.h  |  304 ++
>  drivers/video/fbdev/omap2/omapfb/dss/hdmi_common.c |  148 +
>  drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c    |  247 +
>  drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c    |  255 +
>  drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c     |  282 +
>  .../video/fbdev/omap2/omapfb/dss/manager-sysfs.c   |  531 ++
>  drivers/video/fbdev/omap2/omapfb/dss/manager.c     |  263 +
>  .../fbdev/omap2/omapfb/dss/omapdss-boot-init.c     |  227 +
>  drivers/video/fbdev/omap2/omapfb/dss/output.c      |  267 +
>  .../video/fbdev/omap2/omapfb/dss/overlay-sysfs.c   |  456 ++
>  drivers/video/fbdev/omap2/omapfb/dss/overlay.c     |  202 +
>  drivers/video/fbdev/omap2/omapfb/dss/pll.c         |  389 ++
>  drivers/video/fbdev/omap2/omapfb/dss/rfbi.c        | 1078 ++++
>  drivers/video/fbdev/omap2/omapfb/dss/sdi.c         |  454 ++
>  drivers/video/fbdev/omap2/omapfb/dss/venc.c        |  997 ++++
>  drivers/video/fbdev/omap2/omapfb/dss/video-pll.c   |  211 +
>  drivers/video/fbdev/omap2/{ =3D> omapfb}/vrfb.c      |    0
>  include/video/omapdss.h                            |    2 -
>  122 files changed, 36260 insertions(+), 20 deletions(-)
>  rename drivers/{video/fbdev/omap2/displays-new =3D> gpu/drm/omapdrm/di=
splays}/Kconfig (96%)
>  rename drivers/{video/fbdev/omap2/displays-new =3D> gpu/drm/omapdrm/di=
splays}/Makefile (100%)
>  rename drivers/{video/fbdev/omap2/displays-new =3D> gpu/drm/omapdrm/di=
splays}/connector-analog-tv.c (100%)
>  rename drivers/{video/fbdev/omap2/displays-new =3D> gpu/drm/omapdrm/di=
splays}/connector-dvi.c (100%)
>  rename drivers/{video/fbdev/omap2/displays-new =3D> gpu/drm/omapdrm/di=
splays}/connector-hdmi.c (100%)
>  rename drivers/{video/fbdev/omap2/displays-new =3D> gpu/drm/omapdrm/di=
splays}/encoder-opa362.c (100%)
>  rename drivers/{video/fbdev/omap2/displays-new =3D> gpu/drm/omapdrm/di=
splays}/encoder-tfp410.c (100%)
>  rename drivers/{video/fbdev/omap2/displays-new =3D> gpu/drm/omapdrm/di=
splays}/encoder-tpd12s015.c (100%)
>  rename drivers/{video/fbdev/omap2/displays-new =3D> gpu/drm/omapdrm/di=
splays}/panel-dpi.c (100%)
>  rename drivers/{video/fbdev/omap2/displays-new =3D> gpu/drm/omapdrm/di=
splays}/panel-dsi-cm.c (100%)
>  rename drivers/{video/fbdev/omap2/displays-new =3D> gpu/drm/omapdrm/di=
splays}/panel-lgphilips-lb035q02.c (100%)
>  rename drivers/{video/fbdev/omap2/displays-new =3D> gpu/drm/omapdrm/di=
splays}/panel-nec-nl8048hl11.c (100%)
>  rename drivers/{video/fbdev/omap2/displays-new =3D> gpu/drm/omapdrm/di=
splays}/panel-sharp-ls037v7dw01.c (100%)
>  rename drivers/{video/fbdev/omap2/displays-new =3D> gpu/drm/omapdrm/di=
splays}/panel-sony-acx565akm.c (100%)
>  rename drivers/{video/fbdev/omap2/displays-new =3D> gpu/drm/omapdrm/di=
splays}/panel-tpo-td028ttec1.c (100%)
>  rename drivers/{video/fbdev/omap2/displays-new =3D> gpu/drm/omapdrm/di=
splays}/panel-tpo-td043mtea1.c (100%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/Kconfig (1=
00%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/Makefile (=
100%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/apply.c (1=
00%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/core.c (10=
0%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dispc-comp=
at.c (100%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dispc-comp=
at.h (100%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dispc.c (1=
00%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dispc.h (1=
00%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dispc_coef=
s.c (100%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/display-sy=
sfs.c (100%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/display.c =
(100%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dpi.c (100=
%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dsi.c (100=
%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dss-of.c (=
100%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dss.c (100=
%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dss.h (100=
%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dss_featur=
es.c (100%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dss_featur=
es.h (100%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi.h (10=
0%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi4.c (1=
00%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi4_core=
=2Ec (100%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi4_core=
=2Eh (100%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi5.c (1=
00%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi5_core=
=2Ec (100%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi5_core=
=2Eh (100%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi_commo=
n.c (100%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi_phy.c=
 (100%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi_pll.c=
 (100%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi_wp.c =
(100%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/manager-sy=
sfs.c (100%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/manager.c =
(100%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/omapdss-bo=
ot-init.c (100%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/output.c (=
100%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/overlay-sy=
sfs.c (100%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/overlay.c =
(100%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/pll.c (100=
%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/rfbi.c (10=
0%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/sdi.c (100=
%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/venc.c (10=
0%)
>  rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/video-pll.=
c (100%)
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/Kconfig
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/Makefile
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/connector=
-analog-tv.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/connector=
-dvi.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/connector=
-hdmi.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/encoder-o=
pa362.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/encoder-t=
fp410.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/encoder-t=
pd12s015.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/panel-dpi=
=2Ec
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/panel-dsi=
-cm.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/panel-lgp=
hilips-lb035q02.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/panel-nec=
-nl8048hl11.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/panel-sha=
rp-ls037v7dw01.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/panel-son=
y-acx565akm.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/panel-tpo=
-td028ttec1.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/panel-tpo=
-td043mtea1.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/Kconfig
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/Makefile
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/apply.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/core.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c=

>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.h=

>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dispc.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dispc.h
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dispc_coefs.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.=
c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/display.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dpi.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dsi.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dss-of.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dss.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dss.h
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dss_features.c=

>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dss_features.h=

>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/hdmi.h
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.h
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.h
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/hdmi_common.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.=
c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/manager.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-i=
nit.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/output.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.=
c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/overlay.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/pll.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/rfbi.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/sdi.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/venc.c
>  create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/video-pll.c
>  rename drivers/video/fbdev/omap2/{ =3D> omapfb}/vrfb.c (100%)
>=20


--pXfAc58dJbpe2DUk1c35Ek6cdCw5cL2lw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWcYjTAAoJEPo9qoy8lh719c4P/02wfi1QuhhWJW5ssXw/8HzX
ceEkyVJ5P8Gq/nUUODaO1u18gH9JbGHZRkVkFDBSst6gEYXQ8BRV3pRp/UL5YuJJ
0Jnh6Jk8OTjwN5XqFXiVnOBqDjzoSYEfLgjOo6c2kRZpqftrFv1ZELOOLgvPb3gM
0n6Rx1Nqg2FE2mPhKDaovKu8U4XlBX6GlXqKmf4fGS2iSzQyMW9VWIsJtuyij2zv
vjBeVq+Ob+wJMGV0mrWJNKmkFEk6gwi3U3Ld2MPvUVVb3OJ6zqhtHJpEGr87GBg0
pb/MqbWyQ3/nzxwgOJODc7yhQNzsaw/qXfjnh07c+sLaPH1ntySSt57xd2wjJdna
wgqFUi6ejLj0Y8WzuW3J0IqhsBuxHRku+q9xt2bVIxQA25odoTXBBwLEFAor9aoz
g+BxyW+/ygVDWI4l8BvOouddoTAr3BjlBEsNpX/LypVi5z6TMaCI2lVrwwzQHyBP
mE031spcr0wJFoSzYfNUt7POo2fE2NXefJva3cMlCV+LccxdrkfI5RYUvgAGRUjS
DXGptoxrXVTAGEQcecv2XCUOjKq9uCzNFvjJeVCmHKmD9aDm8DVcW1WchZv24PqH
iF5sgRLKWgysXIGHs7/aanMgmpmg/D1HcHZVXjQRXjOGb2gfcBtJWxZJi5Q4y46G
yrH3ESshroB166cp8ErK
=HvBZ
-----END PGP SIGNATURE-----

--pXfAc58dJbpe2DUk1c35Ek6cdCw5cL2lw--
