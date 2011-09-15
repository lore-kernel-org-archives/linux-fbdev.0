From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Sep 2011 17:56:52 +0000
Subject: Re: Proposal for a low-level Linux display framework
Message-Id: <CAMuHMdUoYi5xTQz=v1rCycS23vFgQzeZFbNZGnrRN+qkBCrSRA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316088425.11294.78.camel@lappyti>
	<yunboul7sx7.fsf@aiko.keithp.com>
	<1316100594.23214.65.camel@deskari>
	<yun8vpp7qk7.fsf@aiko.keithp.com>
	<4E72320B.6020000@gmx.de>
	<CADnq5_NnzLtJmSzOgyppnBtv96DRTJ71u6ZSrs56KJ-F5CC-mw@mail.gmail.com>
In-Reply-To: <CADnq5_NnzLtJmSzOgyppnBtv96DRTJ71u6ZSrs56KJ-F5CC-mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Keith Packard <keithp@keithp.com>, linux-fbdev@vger.kernel.org, linaro-dev@lists.linaro.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Archit Taneja <archit@ti.com>, "Clark, Rob" <rob@ti.com>

On Thu, Sep 15, 2011 at 19:52, Alex Deucher <alexdeucher@gmail.com> wrote:
> While the DRM has historically targeted 3D acceleration, that is not a
> requirement to use the DRM KMS modesetting API.  The current fb API
> has no concept of display controllers or connectors or overlays, etc.
> To match it to modern hardware, it needs a major overhaul.  Why create
> a new modern fb interface that's largely the same as DRM KMS?  What if
> we just consider the KMS API as the new fb API?  If there are any
> inadequacies in the DRM KMS API we would be happy to work out any
> changes.

I admit I didn't look for it, but does there exist a sample DRM KMS driver
for dumb frame buffer hardware with one fixed video mode?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
