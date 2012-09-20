From: Rob Herring <robherring2@gmail.com>
Date: Thu, 20 Sep 2012 23:13:42 +0000
Subject: Re: [PATCHv4 7/9] arm: vt8500: doc: Add device tree bindings for arch-vt8500 devices
Message-Id: <505BA326.1030909@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345707346-9035-1-git-send-email-linux@prisktech.co.nz>
 <1345707346-9035-8-git-send-email-linux@prisktech.co.nz>
In-Reply-To: <1345707346-9035-8-git-send-email-linux@prisktech.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 08/23/2012 02:35 AM, Tony Prisk wrote:
> Bindings for gpio, interrupt controller, power management controller,
> timer, realtime clock, serial uart, ehci and uhci controllers and
> framebuffer controllers used on the arch-vt8500 platform.
> 
> Framebuffer binding also specifies a 'display' node which is required
> for determining the lcd panel data.

Overall, these bindings look okay, but there is some effort to
standardize a binding for displays:

http://comments.gmane.org/gmane.linux.drivers.devicetree/21386

I would like to see that used rather than something custom.

Rob

