From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Aug 2011 13:09:04 +0000
Subject: Re: [PATCH/RFC v2 1/3] fbdev: Add FOURCC-based format configuration API
Message-Id: <CAMuHMdVGV6dYW+szHyD30=HvAnSh92rRp=PMauwZZLw6H7DhYw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1313746626-23845-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<201108291308.50244.laurent.pinchart@ideasonboard.com>
	<CAMuHMdUheemZVb7cPAsyPrC9LLowr+XV_5A+H1EfWWbWHeCVFw@mail.gmail.com>
	<201108291455.36145.laurent.pinchart@ideasonboard.com>
In-Reply-To: <201108291455.36145.laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org, magnus.damm@gmail.com

Hi Laurent,

On Mon, Aug 29, 2011 at 14:55, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> When will the driver report FB_{TYPE,VISUAL}_FOURCC?
>>   - When using a mode that cannot be represented in the legacy way,
>
> Definitely.
>
>>   - But what with modes that can be represented? Legacy software cannot
>>     handle FB_{TYPE,VISUAL}_FOURCC.
>
> My idea was to use FB_{TYPE,VISUAL}_FOURCC only when the mode is configured
> using the FOURCC API. If FBIOPUT_VSCREENINFO is called with a non-FOURCC
> format, the driver will report non-FOURCC types and visuals.

Hmm, two use cases:
  - The video mode is configured using a FOURCC-aware tool ("fbset on
steroids").
    Later the user runs a legacy application.
      => Do not retain FOURCC across opening of /dev/fb*.
  - Is there an easy way to force FOURCC reporting, so new apps don't have to
    support parsing the legacy formats? This is useful for new apps that want to
    support (a subset of) FOURCC modes only.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
