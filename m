From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 10 Jan 2011 19:10:08 +0000
Subject: Re: [PATCH v2] video: imx: Update the manufacturer's name
Message-Id: <20110110191008.GD3760@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1294660061-4141-1-git-send-email-fabio.estevam@freescale.com>
In-Reply-To: <1294660061-4141-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Jan 10, 2011 at 09:47:41AM -0200, Fabio Estevam wrote:
> i.MX processors are currently manufactured by Freescale, not Motorola.
> 
> Make the manufacturer's name consistent.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

This is of course fine with me, but it's also a good reminder of why we
traditionally avoid having this sort of information in the option text.

Most of these sorts of drivers already have their own platform or
architecture dependencies that effectively restrict the driver to a
specific SoC or architecture where folks are likely already going to have
a pretty good idea of who the manufacturer of a given driver is and
whether they are interested in this particular driver or not.

While it's probably not an issue in your case, it can also be confusing
when legacy parts from one company are attributed to a newer incarnation
of the same company, specifically when those parts where never
manufactured under the new corporate entity. While an IP transfer does
invariably take place, parts that are already on life support from the
old corporate entity are rarely factored in to the new corporate entity's
roadmap, meaning that it's also possible to attribute part/company
relationships that don't actually exist.

While it may seem obvious to you that folks with older Motorola-branded
SoCs enable a freescale-branded driver, one could also easily infer that
the driver only applies to newer freescale-braneded parts. (Admittedly
this is not much of an issue for the SoC space, but it's certainly
something to watch out for with PCI drivers that are less rigidly locked
down in their dependency chain).
