From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Fri, 21 May 2010 08:33:20 +0000
Subject: Re: [PATCH 1/4 v3] fbdev: add a MIPI DSI header
Message-Id: <1274430800.4246.87.camel@tubuntu.research.nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1005201829260.26000@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1005201829260.26000@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ext Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "linux-fbdev, @vger.kernel.org" <linux-fbdev@vger.kernel.org>, "lin, ux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Syrjala Ville (Nokia-D/Helsinki)" <ville.syrjala@nokia.com>

On Thu, 2010-05-20 at 18:31 +0200, ext Guennadi Liakhovetski wrote:
> This header adds defines for MIPI DSI and DCS commands and data formats. See
> http://www.mipi.org/ for details.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> v2 -> v3:
> 
> 1. added peripheral-to-processor transaction types
> 
> v1 -> v2:
> 
> 1. renamed mpi_dsi.h to mipi_display.h
> 2. improved introductory comment
> 3. changed < 10 enum values to match others as "0x0N"
> 4. changed "command" to "transaction"
> 5. added a couple of missing transaction types
> 6. enums are now unnamed

Looks good to me.

Acked-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>

 Tomi


