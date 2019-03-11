From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 11 Mar 2019 21:40:04 +0000
Subject: Re: [PATCH] FBTFT: fbtft-bus: Fix code style problems
Message-Id: <20190311214004.GA9670@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190309214852.12233-1-dante.paz@gmail.com>
 <20190311162527.GA20652@ravnborg.org>
 <CAJdeGOTPLoSwQ9hb7Tk_cZ+VmT-xvEtGU_pbSUXoxcB20d3rcw@mail.gmail.com>
 <CAAEAJfAcdFZO_h9dr_hBBh=Rqogg78UOnAOQWNCW-A7ndPMCQA@mail.gmail.com>
In-Reply-To: <CAAEAJfAcdFZO_h9dr_hBBh=Rqogg78UOnAOQWNCW-A7ndPMCQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: devel@driverdev.osuosl.org, DANTE JAVIER PAZ <dpaz@unc.edu.ar>, linux-fbdev@vger.kernel.org, nishadkamdar@gmail.com, leobras.c@gmail.com, Greg KH <gregkh@linuxfoundation.org>, Dante Paz <dante.paz@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, renatoys08@gmail.com

Hi Eze
> 
> Why is this driver still here? I thought we migrated everyhing to
> tinydrm already.
Some have been ported, some are waiting for a user to do the port.
If you looks at tinydrm you will see:
ili9225.c  ili9341.c

And we also have under panel:
panel-ilitek-ili9881c.c
panel-ilitek-ili9322.c

But in staging there are more panels than just these.

So we have not yet ported all.
And there is today no list of what is missing.

	Sam
