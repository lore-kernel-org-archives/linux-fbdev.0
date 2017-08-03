From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 03 Aug 2017 10:05:24 +0000
Subject: Re: [PATCH 0/6] Support for LEGO MINDSTORMS EV3 LCD display
Message-Id: <20170803100524.pisejaxz7wr2sutd@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1501355870-13960-1-git-send-email-david@lechnology.com>
 <5d8f6518-8d7e-c029-2da4-e3417afb3e40@lechnology.com>
 <28188f5c-1daf-121b-6daf-1899668c3875@tronnes.org>
 <1ce36d43-b9dd-807e-23aa-bac4fda70fdc@lechnology.com>
 <bfb3d541-856b-0233-dd85-72512788939f@tronnes.org>
 <bbec0574-311a-e1b4-d7fd-f6fb15b078d2@lechnology.com>
 <937aa71c-1415-4645-7e04-6be43dd33174@tronnes.org>
 <abbd75ac-67f6-e189-5093-ee4a8f44ba6e@lechnology.com>
In-Reply-To: <abbd75ac-67f6-e189-5093-ee4a8f44ba6e@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Lechner <david@lechnology.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org

On Wed, Aug 02, 2017 at 11:05:58AM -0500, David Lechner wrote:
> On 08/02/2017 03:05 AM, Noralf Tr=F8nnes wrote:
> >=20
> > Den 02.08.2017 00.26, skrev David Lechner:
> > > On 08/01/2017 01:08 PM, Noralf Tr=F8nnes wrote:
> > > > (cc: Daniel Vetter)
> > > >=20
> > > >=20
> > > > Den 01.08.2017 18.51, skrev David Lechner:
> > > > > On 07/30/2017 12:14 PM, Noralf Tr=F8nnes wrote:
> > > > > >=20
> > > > > > Den 29.07.2017 21.40, skrev David Lechner:
> > > > > > > On 07/29/2017 02:17 PM, David Lechner wrote:
> > > > > > > > The goal of this series is to get the built-in
> > > > > > > > LCD of the LEGO MINDSTORMS EV3
> > > > > > > > working. But, most of the content here is
> > > > > > > > building up the infrastructure to do
> > > > > > > > that.
> > > > > > > >=20
> > > > > > >=20
> > > > > > > Some general comments/questions:
> > > > > > >=20
> > > > > > > I have noticed that DRM doesn't really have support
> > > > > > > for monochrome displays. I'm guessing that is
> > > > > > > because no one really uses them anymore?
> > > > > > >=20
> > > > > >=20
> > > > > > The repaper driver was the first monochrome drm driver and I ch=
ose to
> > > > > > present it to userspace as XRGB8888 and convert it to monochrom=
e.
> > > > > > The reason for this is that everything, libraries, apps,
> > > > > > plymouth (boot
> > > > > > splash, no rgb565) supports it. I didn't see any point in addin=
g a new
> > > > > > monochrome drm format that didn't have, or probably wouldn't get
> > > > > > userspace support (by libraries at least). The application of c=
ourse
> > > > > > needs to know this to get a good result.
> > > > > >=20
> > > > > > tinydrm_xrgb8888_to_gray8() does the conversion:
> > > > > > https://cgit.freedesktop.org/drm/drm-misc/commit/drivers/gpu/dr=
m/tinydrm?id79ea9a1a59a5a32c8db6f164e80a3fd00cb3781
> > > > > >=20
> > > > > >=20
> > > > > > > The LEGO EV3 display is just an LCD (not the backlit
> > > > > > > kind). It has two modes of operation. It can to 2bbp
> > > > > > > grayscale or it can do 1bpp monochrome. The
> > > > > > > grayscale isn't the best (looks splotchy in places),
> > > > > > > so it would be nice to be able to choose between
> > > > > > > these two modes. How would I implement something
> > > > > > > like that?
> > > > > > >=20
> > > > > >=20
> > > > > > Do you expect anyone to use grayscale if it doesn't look good?
> > > > > > Maybe better to add it later if there's a demand for it.
> > > > >=20
> > > > > I don't expect many people to use it at all. The people that
> > > > > do will be hackers like me that want to see what it is
> > > > > capable of, so I think I will keep it grayscale by default.
> > > > >=20
> > > >=20
> > > > It looks like the best way to satisfy your needs is to add
> > > > specific formats.
> > > >=20
> > > > Video for Linux have these:
> > > >=20
> > > > include/uapi/linux/videodev2.h
> > > >=20
> > > > /* Grey formats */
> > > > #define V4L2_PIX_FMT_GREY    v4l2_fourcc('G', 'R', 'E', 'Y') /*
> > > > 8 Greyscale     */
> > > > #define V4L2_PIX_FMT_Y4      v4l2_fourcc('Y', '0', '4', ' ') /*
> > > > 4 Greyscale     */
> > > > #define V4L2_PIX_FMT_Y6      v4l2_fourcc('Y', '0', '6', ' ') /*
> > > > 6 Greyscale     */
> > > > #define V4L2_PIX_FMT_Y10     v4l2_fourcc('Y', '1', '0', ' ') /*
> > > > 10 Greyscale     */
> > > > #define V4L2_PIX_FMT_Y12     v4l2_fourcc('Y', '1', '2', ' ') /*
> > > > 12 Greyscale     */
> > > > #define V4L2_PIX_FMT_Y16     v4l2_fourcc('Y', '1', '6', ' ') /*
> > > > 16 Greyscale     */
> > > > #define V4L2_PIX_FMT_Y16_BE  v4l2_fourcc_be('Y', '1', '6', ' ')
> > > > /* 16 Greyscale BE  */
> > > >=20
> > > >=20
> > > > Maybe we can add formats like these:
> > > >=20
> > > > include/uapi/drm/drm_fourcc.h
> > > >=20
> > > > #define DRM_FORMAT_MONO        fourcc_code('Y', '0', '1', ' ')
> > > > /* [0] Monochrome */
> > > > or
> > > > #define DRM_FORMAT_Y1        fourcc_code('Y', '0', '1', ' ') /*
> > > > [0] Monochrome */
> > > >=20
> > > > #define DRM_FORMAT_Y2        fourcc_code('Y', '0', '2', ' ') /*
> > > > [1:0] Greyscale */
> > > >=20
> > > > Daniel, what do you think?
> > >=20
> > > 2 of the first 3 tinydrm drivers are monochrome (and I would like to
> > > write a driver for the Seeed/Grove I2C OLED displays which are also
> > > monochrome), so I think the 1bpp modes would definitely be useful. I
> > > think there is enough userspace code still around that knows about
> > > FB_VISUAL_MONO01 and FB_VISUAL_MONO10 that could use these.
> > >=20
> >=20
> > Can you elaborate, would you use the display trough monochrome fbdev
> > or through drm?
>=20
> I have a small collection of programs and libraries that work using
> monochrome fbdev. I would like to just keep using them without having to
> convert everything to drm.

That probably means we'd need to extend fbdev emulation helpers in drm to
support Monochrome modes better. Shouldn't be that much work really.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
