From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date: Mon, 11 Mar 2019 21:43:43 +0000
Subject: Re: [PATCH] FBTFT: fbtft-bus: Fix code style problems
Message-Id: <CAAEAJfCNhtGwpZWMDv2nQJcK7nsY6onKLd0DhNFcSJNN+8ZLag@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190309214852.12233-1-dante.paz@gmail.com>
 <20190311162527.GA20652@ravnborg.org>
 <CAJdeGOTPLoSwQ9hb7Tk_cZ+VmT-xvEtGU_pbSUXoxcB20d3rcw@mail.gmail.com>
 <CAAEAJfAcdFZO_h9dr_hBBh=Rqogg78UOnAOQWNCW-A7ndPMCQA@mail.gmail.com>
 <20190311214004.GA9670@ravnborg.org>
In-Reply-To: <20190311214004.GA9670@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: devel@driverdev.osuosl.org, DANTE JAVIER PAZ <dpaz@unc.edu.ar>, linux-fbdev@vger.kernel.org, nishadkamdar@gmail.com, leobras.c@gmail.com, Greg KH <gregkh@linuxfoundation.org>, Dante Paz <dante.paz@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, renatoys08@gmail.com

On Mon, 11 Mar 2019 at 18:40, Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Eze
> >
> > Why is this driver still here? I thought we migrated everyhing to
> > tinydrm already.
> Some have been ported, some are waiting for a user to do the port.
> If you looks at tinydrm you will see:
> ili9225.c  ili9341.c
>
> And we also have under panel:
> panel-ilitek-ili9881c.c
> panel-ilitek-ili9322.c
>
> But in staging there are more panels than just these.
>
> So we have not yet ported all.
> And there is today no list of what is missing.
>

Right.

Perhaps the TODO file on fbtft should be updated stating clearly that
we don't care about cleaning this one.
This is important given staging is used for Outreachy and other
introductory programs.

We can also add some big fat warning message (in case there isn't one
already) asking users of staging/fbtft to help porting/testing the
port to tinydrm.

Thanks,
Eze
