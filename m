From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Mon, 23 Sep 2013 20:29:26 +0000
Subject: Re: [PATCH v3 1/2] video: ARM CLCD: Add DT support
Message-Id: <20130923202926.GX12758@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1379351934-25415-1-git-send-email-pawel.moll@arm.com>
 <52376180.1090001@wwwdotorg.org> <1379435799.9205.16.camel@hornet>
 <5238CBE9.2060800@wwwdotorg.org> <1379522363.9244.12.camel@hornet>
 <52406646.709@wwwdotorg.org> <20130923160640.GT12758@n2100.arm.linux.org.uk>
 <52406C97.3010800@wwwdotorg.org>
 <20130923164302.GW12758@n2100.arm.linux.org.uk>
 <52409C0C.1000406@wwwdotorg.org>
In-Reply-To: <52409C0C.1000406@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Sep 23, 2013 at 01:52:44PM -0600, Stephen Warren wrote:
> On 09/23/2013 10:43 AM, Russell King - ARM Linux wrote:
> > On Mon, Sep 23, 2013 at 10:30:15AM -0600, Stephen Warren wrote:
> >> On 09/23/2013 10:06 AM, Russell King - ARM Linux wrote:
> >>> On Mon, Sep 23, 2013 at 10:03:18AM -0600, Stephen Warren wrote:
> >>>> It sounds like you could just put LCDControl & 0x2e in the DT rather
> >>>> than using values such as 0x100..0x107, which don't appear to match the
> >>>> register format you mentioned above.
> >>>
> >>> No.  Platforms which route the outputs to something like VGA or HDMI can
> >>> change the framebuffer format.  Your suggestions is far too restrictive.
> >>
> >> Surely the DT should describe the HW setup only. Usually, a particular
> >> HW setup can support multiple different framebuffer formats. Hence, the
> >> DT wouldn't/shouldn't imply anything about the framebuffer format, but
> >> simply which wires are connected to the LCD.
> > 
> > Quite, and putting the contents of the LCDControl register - even just
> > bits 5 and 3-1 results in you having to modify the DT and reboot the
> > kernel just to change the framebuffer format.  That's why I'm objecting
> > to your comment.
> 
> Oh, so these particular registers define both the output signal muxing
> for the pins and the FB data format? If so, yes it's not correct to put
> the register values into DT. I assumed that the HW would have a separate
> representation of those two concepts, in different registers or at least
> different fields in the same register. If not, there is indeed no choice
> but to make up some arbitrary values to represent just the pinmuxing :-(

Unfortunately not.  Parameters such as TFT, and dual can be specified by
DT, but the difficulty comes with the pixel wiring.

With a PL110 in TFT mode, the representation of which signals represent
what are a function of the selected BPP:

Panel:
24bpp: Blue[7:0]=CLD[23:16] Green[7:0]=CLD[15:8] Red[7:0]=CLD[7:0]
18bpp: Blue[4:0]=CLD[17:13] Green[4:0]=CLD[11:7] Red[4:0]=CLD[5:1]
       Intensity = CLD[12], CLD[6], CLD[0]

24bpp signalling is used when a framebuffer format of 24bpp mode is
selected, otherwise the 18bpp signalling is used.

The PL110 in 16bpp does not support for anything but 1555 mode when wired
up as above, but some people want 565 mode.  That's achievable (and is
used on Versatile) by adjusting the wiring via a FPGA:

       Blue = CLD[12,17:14] Green = [13,11:7] Blue = CLD[5:1]

This gives us the RGB565 mode on PL110.  Now, consider a platform which
wants to use this - if the panel is wired up directly to the CLCD like
that, then it will only support RGB565.

If you were connecting a 4:4:4 panel, a similar thing is possible, and
may be preferable to have the standard framebuffer format in memory to
do this.

So, the supportable framebuffer foramts depends entirely on how the
display is wired up to the controller.

Now, for PL111, things are simpler - it supports 5551, 565 and 444 modes
natively, so supports all the standard framebuffer formats.  The output
wiring is different and more sane.  In this case, CLD[23] is always the
MSB blue bit, CLD[15] is always the MSB green bit, and CLD[7] is always
the MSB red bit.  So here, the wiring matters very much less.

However, even here the "capabilities" play a role.  Does driving a TFT
444 panel being driven in 24-bit mode make sense?  Yes, it'll work but
the least significant four bits are lost.  What about the other way
around?  A TFT 888 panel in 12bpp mode?  Well, in that case the least
sigificant four bits are marked up as "reserved" - and even if they are
held at zero, you're going to lose some colour range on the panel because
white will be equivalent to colour f0f0f0 not ffffff.

Hence, we probably want to have even here some way to say "I want this
hardware to only support framebuffer formats of X".

My feeling is that even though these capabilities are not part of the
actual hardware spec, they're well worth implementing directly in DT as
they're describing what the *hardware* as a whole is capable of.

Moreover, I created the capabilities purely as a way to describe what
the hardware and panel are capable of.  Isn't that what DT is all about
too?
