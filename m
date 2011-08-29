From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Aug 2011 11:20:44 +0000
Subject: Re: [PATCH/RFC v2 1/3] fbdev: Add FOURCC-based format configuration API
Message-Id: <CAMuHMdUheemZVb7cPAsyPrC9LLowr+XV_5A+H1EfWWbWHeCVFw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1313746626-23845-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<201108291209.08349.laurent.pinchart@ideasonboard.com>
	<CAMuHMdU3eO34zmGVejUj4B7Z5JWiwM_pieoycfinSspSiL1reQ@mail.gmail.com>
	<201108291308.50244.laurent.pinchart@ideasonboard.com>
In-Reply-To: <201108291308.50244.laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org, magnus.damm@gmail.com

On Mon, Aug 29, 2011 at 13:08, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Monday 29 August 2011 13:04:15 Geert Uytterhoeven wrote:
>> On Mon, Aug 29, 2011 at 12:09, Laurent Pinchart wrote:
>> > On Monday 29 August 2011 11:36:07 Geert Uytterhoeven wrote:
>> >> On Mon, Aug 29, 2011 at 10:50, Laurent Pinchart wrote:
>> [...]
>>
>> > If my understanding is now correct, a V4L2 planar YUV type where Y, U and
>> > V components are stored in separate byte-oriented planes, with each
>> > plane storing Y, U or V components packed (such as
>> > http://linuxtv.org/downloads/v4l- dvb-apis/V4L2-PIX-FMT-YUV422P.html),
>> > would be of neither FB_TYPE_PLANES nor FB_TYPE_PACKED. The same would be
>> > true for an RGB format where each component is stored in a separate
>> > plane with each plane sotring R, G or B packed.
>>
>> Indeed. Currently this cannot be represented.
>
> Good, at least I now understand the situation :-)
>
>> For ideas from the past, see e.g.
>> http://comments.gmane.org/gmane.linux.fbdev.devel/10951.
>>
>> > If the above is correct, what FB_TYPE_* should a driver report when using
>> > FB_VISUAL_FOURCC with V4L2_PIX_FMT_YUV422P
>> > (http://linuxtv.org/downloads/v4l- dvb-apis/V4L2-PIX-FMT-YUV422P.html)
>> > or V4L2_PIX_FMT_NV12
>> > (http://linuxtv.org/downloads/v4l-dvb-apis/re25.html) for instance ?
>>
>> We need new types for those. Or always use FOURCC for them.
>
> My proposal currently defined FB_VISUAL_FOURCC. What about adding
> FB_TYPE_FOURCC as well ?

That may make sense.
When will the driver report FB_{TYPE,VISUAL}_FOURCC?
  - When using a mode that cannot be represented in the legacy way,
  - But what with modes that can be represented? Legacy software cannot
    handle FB_{TYPE,VISUAL}_FOURCC.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
