From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 01 Mar 2010 03:45:20 +0000
Subject: Re: [PATCH 1/3] video: add support for getting video mode from
Message-Id: <1267415120.23523.1898.camel@pasglop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <fa686aa41002161006l3b301febt94fe990df4bddfe9@mail.gmail.com>
	<1267307902-31939-2-git-send-email-agust@denx.de>
	<fa686aa41002272230s7f900c0fv1aabf0e26ccbf84c@mail.gmail.com>
	<4B8A2CD7.7070305@firmworks.com>
In-Reply-To: <4B8A2CD7.7070305-D5eQfiDGL7eakBO8gow8eQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mitch Bradley <wmb-D5eQfiDGL7eakBO8gow8eQ@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wd-ynQEQJNshbs@public.gmane.org, dzu-ynQEQJNshbs@public.gmane.org, jrigby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org

At some stage, Grant wrote:

> > First off, I did a tiny amount of research, and I didn't find any
> > existing OpenFirmware bindings for describing video displays.
> > Otherwise, I'd suggest considering that.

There's a binding for framebuffers but it sucks big time :-) It doesn't
provide a reliable way for the OS to get to the physical address of the
fb, doesn't define outputs and mode setting, doesn't really deal with
>8bpp, etc....

On Sat, 2010-02-27 at 22:44 -1000, Mitch Bradley wrote:

> As it turns out, I'm doing exactly that - exporting verbatim EDID
> data 
> as the value of the "edid" property - for the display node on the Via 
> version of the OLPC machine.  The kernel driver uses it instead of 
> trying to obtain the EDID data from the monitor, because the builtin 
> OLPC display cannot supply EDID data through the usual hardware
> interfaces.

This is actually a common practice (though EDID is most often in
uppercase) on Apple hardware too. It has issues though in the sense that
it doesn't carry proper connector information and falls over in many
multi-head cases.

I think passing the EDID data, when available, is thus the right thing
to do indeed, however that doesn't solve two problems:

 - Where to put that property ? This is a complicated problem and we
might argue on a binding for weeks because video cards typically support
multiple outputs, etc. etc... I think the best for now is to stick as
closely as possible to the existing OF fb binding, and have "display"
nodes for each output, which can eventually contain an EDID. We might
also want to add a string that indicate the connector type. Specific
drivers might want to define additional properties here where it makes
sense such as binding of those outputs to CRTCs or such, up to you.

 - We -also- want a way to specify the "default" mode as set by the
firmware, at least on some devices. The EDID gives capabilities, and
often for LCDs also the "preferred" mode which is almost always the
"default" mode ... but could be different. In order to avoid "flicking",
the driver might wants to know what is the currently programmed mode.
For that, having split out properties makes sense, though I would like
to either prefix them all with "mode," or stick them in a sub-node of
the display@.

Cheers,
Ben.


