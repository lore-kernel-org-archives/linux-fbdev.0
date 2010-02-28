From: Mitch Bradley <wmb@firmworks.com>
Date: Sun, 28 Feb 2010 08:44:07 +0000
Subject: Re: [PATCH 1/3] video: add support for getting video mode from device
Message-Id: <4B8A2CD7.7070305@firmworks.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <fa686aa41002161006l3b301febt94fe990df4bddfe9@mail.gmail.com>
	<1267307902-31939-2-git-send-email-agust@denx.de>
	<fa686aa41002272230s7f900c0fv1aabf0e26ccbf84c@mail.gmail.com>
In-Reply-To: <fa686aa41002272230s7f900c0fv1aabf0e26ccbf84c-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wd-ynQEQJNshbs@public.gmane.org, dzu-ynQEQJNshbs@public.gmane.org, jrigby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org

>
> Hi Anatolij,
>
> [added cc: to devicetree-discuss@lists.ozlabs.org]
>
> On Sat, Feb 27, 2010 at 2:58 PM, Anatolij Gustschin <agust@denx.de> wrote:
>   
>> > Framebuffer drivers may want to get panel timing info
>> > from the device tree. This patch adds appropriate support.
>> > Subsequent patch for FSL DIU frame buffer driver makes use
>> > of this functionality.
>>     
>
> I think this is moving in the right direction, but there needs to
> debate & review over the binding before committing to anything.
> Please write a patch that documents the new binding in
> Documentation/powerpc/dts-bindings.  All new bindings should be
> documented and reviewed on devicetree-discuss before merging any
> drivers that use them into mainline.
>
> From what I can tell by reading your code, I suspect that the binding
> you've designed will solve your immediate problem, but won't be able
> to handle anything slightly more complex, but it also looks like the
> binding has been designed to be generic, usable by any display device.
>
> First off, I did a tiny amount of research, and I didn't find any
> existing OpenFirmware bindings for describing video displays.
> Otherwise, I'd suggest considering that.
>
> From the little bit that I know, it seems that for most video devices
> (ie. PCs) the video card discovers the capabilities of the screen by
> reading the monitor's EDID data.  However, in your particular case
> embedded case, a fixed flat panel is attached, and there isn't any
> EDID data provided.  Therefore, you need an alternate method of
> describing the display capabilities.  Rather than designing something
> entirely new, you may want to consider using the EDID data format
> directly; or at least cover the same things that EDID describes.  The
> downside to using EDID directly is that it is a packed binary format
> that isn't parseable by mere mortals; but the data contained in it
> seems about right.  The upside is the kernel already knows what to do
> with EDID data.
>
> Otherwise you risk designing something that won't be useful for
> anything much outside of your own use case.  For example, the binding
> I see from the code cannot handle a display with multiple output
> modes.
>
> Also, since you're now in the realm of describing a video display,
> which is separate from the display controller, you should consider
> describing the display in a separate device tree node.  Maybe
> something like this...
>
> video {
>         compatible = "fsl,mpc5121-diu";
>         display {
>                 compatible = "<vendor>,<model>";
>                 edid = [edid-data];
>         };
> };
>   


As it turns out, I'm doing exactly that - exporting verbatim EDID data 
as the value of the "edid" property - for the display node on the Via 
version of the OLPC machine.  The kernel driver uses it instead of 
trying to obtain the EDID data from the monitor, because the builtin 
OLPC display cannot supply EDID data through the usual hardware interfaces.

Mitch


> Cheers,
> g.
>
>   
