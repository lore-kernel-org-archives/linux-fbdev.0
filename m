From: Bernie Thompson <bernie@plugable.com>
Date: Mon, 28 Sep 2015 20:56:30 +0000
Subject: Re: No more new fbdev drivers, please
Message-Id: <CAF1V4O_pDoMAr=f0MTugWf3y3m4DGbtE-qb3O645SkGc2dWfAQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5603EC15.9090605@ti.com>
	<20150924144621.40e26f0a@free-electrons.com>
	<20150924152312.GV3383@phenom.ffwll.local>
	<CAMuHMdVAO8Ua4G1DRMxTKxqJaAb4xBTQie-nvOkYJ7sox-YCYw@mail.gmail.com>
	<CADnq5_NL5p+sRzOvVpr=JnZ-e-vGtDD-69qapQMKawWtfVRnCw@mail.gmail.com>
	<CAMuHMdX0Jg9RSu9rm2-trtMCDpS16Zy8VLEnmjvW_vWVWvHdVQ@mail.gmail.com>
In-Reply-To: <CAMuHMdX0Jg9RSu9rm2-trtMCDpS16Zy8VLEnmjvW_vWVWvHdVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-fbdev <linux-fbdev@vger.kernel.org>

On Sat, Sep 26, 2015 at 11:01 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> The smallest of these (udl) still counts in at ca. 2800 LoC,

Note udlfb.c, the original fbdev driver that I helped write and that
the udl DRM driver was based on, is ~1800 LoC ... so we're actually
talking in the ballpark of 2x (rather than 10x) between fbdev and DRM
in this case. That said, the complexity difference is probably higher
than the LoC difference. I know I personally have struggled in the
shift from understanding fbdev to understanding DRM.

The fact that there's drivers of both types and USB hardware might
make udl may be a good driver to use as a base for any additional
simplification / helper work. David Airlie and David Herrmann both
have this hardware. David Airlie did the port from fbdev to DRM, so
he's made it an exemplary driver.  And if anyone needs any hardware
which works with udlfb and udl, we're happy to send free hardware to
any programmers who are willing to contribute in the form of code or
testing: http://plugable.com/projects/plugable-open-source-hardware-samples-program

More simplification and documentation would be great. In particular,
the optimization for the connector+encoder+crtc combination others
have mentioned seems like it would be worthwhile.

Cheers,
Bernie
