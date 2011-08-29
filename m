From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 29 Aug 2011 11:08:49 +0000
Subject: Re: [PATCH/RFC v2 1/3] fbdev: Add FOURCC-based format configuration API
Message-Id: <201108291308.50244.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1313746626-23845-1-git-send-email-laurent.pinchart@ideasonboard.com> <201108291209.08349.laurent.pinchart@ideasonboard.com> <CAMuHMdU3eO34zmGVejUj4B7Z5JWiwM_pieoycfinSspSiL1reQ@mail.gmail.com>
In-Reply-To: <CAMuHMdU3eO34zmGVejUj4B7Z5JWiwM_pieoycfinSspSiL1reQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org, magnus.damm@gmail.com

Hi Geert,

On Monday 29 August 2011 13:04:15 Geert Uytterhoeven wrote:
> On Mon, Aug 29, 2011 at 12:09, Laurent Pinchart wrote:
> > On Monday 29 August 2011 11:36:07 Geert Uytterhoeven wrote:
> >> On Mon, Aug 29, 2011 at 10:50, Laurent Pinchart wrote:
> [...]
> 
> > If my understanding is now correct, a V4L2 planar YUV type where Y, U and
> > V components are stored in separate byte-oriented planes, with each
> > plane storing Y, U or V components packed (such as
> > http://linuxtv.org/downloads/v4l- dvb-apis/V4L2-PIX-FMT-YUV422P.html),
> > would be of neither FB_TYPE_PLANES nor FB_TYPE_PACKED. The same would be
> > true for an RGB format where each component is stored in a separate
> > plane with each plane sotring R, G or B packed.
> 
> Indeed. Currently this cannot be represented.

Good, at least I now understand the situation :-)

> For ideas from the past, see e.g.
> http://comments.gmane.org/gmane.linux.fbdev.devel/10951.
> 
> > If the above is correct, what FB_TYPE_* should a driver report when using
> > FB_VISUAL_FOURCC with V4L2_PIX_FMT_YUV422P
> > (http://linuxtv.org/downloads/v4l- dvb-apis/V4L2-PIX-FMT-YUV422P.html)
> > or V4L2_PIX_FMT_NV12
> > (http://linuxtv.org/downloads/v4l-dvb-apis/re25.html) for instance ?
> 
> We need new types for those. Or always use FOURCC for them.

My proposal currently defined FB_VISUAL_FOURCC. What about adding 
FB_TYPE_FOURCC as well ?

-- 
Regards,

Laurent Pinchart
