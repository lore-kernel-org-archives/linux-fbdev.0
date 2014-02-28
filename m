From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Fri, 28 Feb 2014 16:13:43 +0000
Subject: Re: [PATCH 9/9] Doc/DT: Add DT binding documentation for tpd12s015 encoder
Message-Id: <20140228161343.GS21483@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com> <1393590016-9361-10-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1393590016-9361-10-git-send-email-tomi.valkeinen-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On Fri, Feb 28, 2014 at 02:20:16PM +0200, Tomi Valkeinen wrote:
> Add DT binding documentation for tpd12s015 encoder
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Reviewed-by: Archit Taneja <archit@ti.com>
> ---
>  .../devicetree/bindings/video/ti,tpd12s015.txt     | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/ti,tpd12s015.txt
> 
> diff --git a/Documentation/devicetree/bindings/video/ti,tpd12s015.txt b/Documentation/devicetree/bindings/video/ti,tpd12s015.txt
> new file mode 100644
> index 000000000000..26e6d32e3f20
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/ti,tpd12s015.txt
> @@ -0,0 +1,44 @@
> +TPD12S015 HDMI level shifter and ESD protection chip
> +==========================
> +
> +Required properties:
> +- compatible: "ti,tpd12s015"
> +
> +Optional properties:
> +- gpios: CT CP HPD, LS OE and HPD gpios

If this is supposed to give people a clue about what these GPIOs are,
it completely fails to do this.  CT CP?  HPD is obviously the hotplug
detect signal, but why are there two - HDMI only has a single detect
pin on the connector.

While it makes sense to stick all three into one property, is it
possible that not all of these may be routed to a GPIO?  If so, how
do you specify that one (or more) of these does not exist?

Another issue here is that other HDMI encoders are available - should
every encoder define its own set of bindings, or should there be a
base set of bindings which all encoders should conform to - such as
always having a HDMI output port?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
