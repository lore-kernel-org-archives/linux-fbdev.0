From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Mon, 26 Jul 2010 08:03:25 +0000
Subject: Re: [PATCH] [ARM] video/omap2/tdo35s: fix visual artefacts
Message-Id: <1280131405.2427.11.camel@tubuntu.research.nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1278931370-19912-1-git-send-email-grinberg@compulab.co.il>
	 <4C4705DB.4000402@compulab.co.il>
In-Reply-To: <4C4705DB.4000402@compulab.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ext Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Mike Rapoport <mike@compulab.co.il>

On Wed, 2010-07-21 at 16:36 +0200, ext Igor Grinberg wrote:
> ping!

Man has to have his vacation!

> > TDO35S samples the data on the falling adge of the pixel clock,
> > therefore the data strobe should be on the raising edge.

Looks fine to me, except I'd like the patch subject to be in line with
the other patches (ie. prefixed by OMAP: DSS2: ...), and I think it
should describe the change more precisely, perhaps something like "fix
the video signal".

I can make those changes as I apply it to my tree, if it's ok to you.

 Tomi


