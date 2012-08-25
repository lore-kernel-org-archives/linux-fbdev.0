From: Stephen Warren <swarren@nvidia.com>
Date: Sat, 25 Aug 2012 03:32:02 +0000
Subject: Re: [PATCHv4 0/9] *** ARM: Update arch-vt8500 to Devicetree ***
Message-Id: <50384732.9060304@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345707346-9035-1-git-send-email-linux@prisktech.co.nz>
In-Reply-To: <1345707346-9035-1-git-send-email-linux@prisktech.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 08/23/2012 01:35 AM, Tony Prisk wrote:
> This patchset updates arch-vt8500 to devicetree and removes all the old-style
> code. Support for WM8650 has also been added.
> 
> Example dts/dtsi files are given for the three currently supported models.
> 
> Major changes:
> 
> GPIO code has been converted to a platform_device and rewritten as WM8505
> support was broken. Add support for WM8650 gpio controller.
> 
> UHCI support was missing. Added this as a generic non-pci uhci controller as
> it doesn't require anything special. Should be usable by any system that doesn't
> have special requirements to get the UHCI controller working.
> 
> Framebuffer code patched to support WM8650. The bindings for this are of concern
> but there doesn't seem to be a formalized binding yet. This patch is based off
> Sascha Hauer's current patch on the dri-devel mailing list and should be easily
> patched out when its finalized.
> 
> Patchset based on Arnd's arm-soc/for-next branch.

I believe all the issues I pointed out are fixed in this series. I'm not
sure I reviewed it in enough detail to ack it, but I'm fine with what I saw.
