From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 13 Dec 2011 10:47:02 +0000
Subject: Re: [PATCH v4 0/3] fbdev: Add FOURCC-based format configuration API
Message-Id: <CAMuHMdVggt5wqKjBFjHYT4GH5M8rFUG_sOMB2aH5YrzEGH_VSA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1322562419-9934-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<201112121708.30839.laurent.pinchart@ideasonboard.com>
	<4EE64CC2.5090906@gmx.de>
	<201112130140.45045.laurent.pinchart@ideasonboard.com>
In-Reply-To: <201112130140.45045.laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org

On Tue, Dec 13, 2011 at 01:40, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> I think you also want to do something with red, green, blue, transp when
>> entering FOURCC mode, at least setting them to zero or maybe even requiring
>> that they are zero to enter FOURCC mode (as additional safety barrier).
>
> Agreed. The FOURCC mode documentation already requires those fields to be set
> to 0 by applications.
>
> I'll enforce this in fb_set_var() if info->fix has the FB_CAP_FOURCC
> capability flag set.

So when info->fix has the FB_CAP_FOURCC capability flag set, you can no longer
enter legacy mode?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
