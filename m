From: Tony Prisk <linux@prisktech.co.nz>
Date: Thu, 28 Mar 2013 05:04:41 +0000
Subject: Re: [PATCH 6/6] video: fb: vt8500: Convert framebuffer drivers to standardized binding
Message-Id: <1364447081.15039.5.camel@gitbox>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1364374021-10844-1-git-send-email-linux@prisktech.co.nz>
 <1364374021-10844-7-git-send-email-linux@prisktech.co.nz>
 <5152D39F.1090104@ti.com>
In-Reply-To: <5152D39F.1090104@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, 2013-03-27 at 13:10 +0200, Tomi Valkeinen wrote:
> Hi,
> 
> On 2013-03-27 10:47, Tony Prisk wrote:
> > Now that a display timing binding is available, convert our almost identical
> > binding to use the standard binding.
> > 
> > This patch converts the vt8500 and wm8505 framebuffer drivers and
> > associated dts/dtsi files to use the standard binding as defined in
> > bindings/video/display-timing.txt.
> > 
> > There are two side-effects of making this conversion:
> > 
> > 1) The fb node should now be in the board file, rather than the soc file as
> > the display-timing node is a child of the fb node.
> > 
> > 2) We still require a bits per pixel property to initialize the framebuffer
> > for the different lcd panels. Rather than including this as part of the
> > display timing, it is moved into the framebuffer node.
> > 
> > I have also taken the opportunity to alphabetise the includes of each
> > driver to avoid double-ups.
> 
> I don't think this is correct. I don't have that much experience with
> DT, but I think you should have, for example:
> 
> wm8850.dtsi:
> 
> 	fb: fb@d8051700 {
> 		compatible = "wm,wm8505-fb";
> 		reg = <0xd8051700 0x200>;
> 	};
> 
> wm8850-w70v2.dts:
> 
> &fb {
> 	bits-per-pixel = <16>;
> 
> 	display-timings {
> 		native-mode = <&timing0>;
> 		timing0: 800x480 {
> 			clock-frequency = <0>;
> 			...
> 		};
> 	};
> };
> 
> So, the core fb part should be in the SoC's file, as it's part of the
> SoC. And the stuff that tells what kind of display is attached is in the
> board dts file.
> 
> Also, just a word of warning, I think the videomode series I've sent for
> review will cause some breakage with this series if the videomode series
> is accepted. Nothing difficult to fix, though, but we'll need some extra
> management to avoid compilation failures.
> 
>  Tomi
> 
> 

Thanks for the feedback and the heads-up.

I believe you are correct about the DT info - it looks right when
described the way you did, so I have changed it.

If there is no other feedback, I will post a version 2 after Easter.

Regards
Tony P

