From: Grant Likely <grant.likely@linaro.org>
Date: Wed, 12 Nov 2014 09:57:05 +0000
Subject: Re: [PATCH v4 0/5] simplefb: add clock handling code
Message-Id: <CACxGe6sMF2C6hvRNNnB_i6a44fh0WC7JjjisFOh5GMV66mC6Fw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413996311-4287-1-git-send-email-hdegoede@redhat.com>
 <544F737A.7000109@ti.com>
 <CAL_JsqJ2JRg7k21CEVe4-At7enD+y3TN_7wfqhY0OHZm-_j17w@mail.gmail.com>
 <544F7E5D.60104@redhat.com> <5450CAA5.5020205@ti.com>
 <CAL_JsqKWqq+H5ymUW3n8tkmLJHEUGaKDLX5+orJmGUQ3ECQwUQ@mail.gmail.com>
 <20141111214950.7FCABC41610@trevor.secretlab.ca>
 <CAMuHMdUoPK_s7OP1Aop4eOyhec+abFij7ZoAAdA5fqpJJy-Dgg@mail.gmail.com>
In-Reply-To: <CAMuHMdUoPK_s7OP1Aop4eOyhec+abFij7ZoAAdA5fqpJJy-Dgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Wednesday, November 12, 2014, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Grant,
>
> On Tue, Nov 11, 2014 at 10:49 PM, Grant Likely <grant.likely@linaro.org> =
wrote:
> > However, I am concerned about handover. I've lost track over the entire
> > thread on whether the handover mechanism has been resolved, and I would
> > really like to have a proposed solution to this documented in the
> > binding. The fact that there is nothing tying the simple framebuffer to
> > the actual hardware backing the framebuffer is concerning. It means the
> > kernel needs to guess which graphics device is associated with the
> > framebuffer.
>
> We did discuss handover in D=FCsseldorf, and concluded that the simplefb's
> regs property can be used for this.
>
> While on a modern system with unified memory this association cannot be
> derived in a generic way, a device-specific driver for the graphics hardw=
are
> can if the regs property of the simplefb node matches the address the CRTC
> engine is configured for.


???

Right, I'm going to be blunt here: That's just dumb. All the
capability needed is there in the DT to associate a simple FB to a
display controller, and the solution chosen is to use a heuristic?

The association needs to be explicit. I strongly prefer putting the
simple FB directly into the display controller node, but I would
consider phandle linkage also.

g.

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
