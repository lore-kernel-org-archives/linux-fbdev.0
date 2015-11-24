From: Scott Wood <scottwood@freescale.com>
Date: Tue, 24 Nov 2015 17:05:30 +0000
Subject: Re: [PATCH] video: fbdev: fsl: fix kernel crash when diu_ops is not implemented
Message-Id: <1448384730.27264.349.camel@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1448346450-47403-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1448346450-47403-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, 2015-11-24 at 12:02 -0500, Timur Tabi wrote:
> On Tue, Nov 24, 2015 at 11:55 AM, Scott Wood <scottwood@freescale.com>
> wrote:
> 
> > > Well, if you're concern is that there's no platform code, then there
> > > should be a check that says, "see if there's any platform code", not
> > > "let's check this obscure function and abort without explanation if
> > > it's not initialized."
> > 
> > Do you have a *specific* better way to "see if there's any platform code"?
> 
> Well, for one thing, the check should be done in the _init function,
> not the _probe. 

I asked Dongsheng to put it in probe() during internal review because at the
time he was printing an error, and I didn't want the error to be printed if
the device wasn't present.  Again, there's another non-bugfix patch pending
that moves all the rest into probe() where it belongs.

>  Secondly, it should be documented as such, e.g. "/*
> Check to see that we have platform code that initializes diu_ops.  If
> not, then abort. */".

OK.

> Third, you should probably add a boolean field
> to platform_diu_data_ops that gets set to True if/when the platform
> code initializes the rest of the structure.

Why do you want to complicate a simple bugfix with a requirement to modify all
platforms that use the driver, introducing a possible regression if one is
missed?

-Scott

