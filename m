From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 18 Feb 2011 16:43:54 +0000
Subject: Re: [PATCH 2/2] omap3: devkit8000: Add and use 4.3 inch display
Message-Id: <1298047434.17624.24.camel@deskari>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297530130-10355-1-git-send-email-daniel.morsing@gmail.com>
	 <1297530130-10355-3-git-send-email-daniel.morsing@gmail.com>
	 <4D5E67E7.7040603@gmail.com>  <1298033744.2323.9.camel@morsing>
	 <1298034466.24062.99.camel@deskari>  <1298045888.6421.6.camel@morsing>
In-Reply-To: <1298045888.6421.6.camel@morsing>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Morsing <daniel.morsing@gmail.com>
Cc: Thomas Weber <thomas.weber.linux@googlemail.com>, Tony Lindgren <tony@atomide.com>, Bryan Wu <bryan.wu@canonical.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 2011-02-18 at 10:18 -0600, Daniel Morsing wrote:
> On Fri, 2011-02-18 at 15:07 +0200, Tomi Valkeinen wrote:
> > On Fri, 2011-02-18 at 06:55 -0600, Daniel Morsing wrote:
> > > On Fri, 2011-02-18 at 13:36 +0100, Thomas Weber wrote:
> > > > Hello Daniel,
> > > > 
> > > > Am 12.02.2011 18:02, schrieb Daniel Morsing:
> > > > > This patch adds a generic panel entry for the 4.3 inch display that is
> > > > > sold with the devkit8000 and modifies the board file to use this
> > > > > display.
> > > > > 
> > > > > 
> > > > 
> > > > So only the 4.3 inch display can be used with the devkit8000?
> > > > There are also Devkit8000 with 5.6 and 7 inch displays.
> > > > 
> > > > Regards,
> > > > Thomas
> > > > 
> > > 
> > > Yeah, I'll admit that the patch is a bit one-sided. I couldn't find a
> > > way to specify a board using a class of displays with separate timing
> > > settings.
> > > 
> > > One way to do it would be to add the settings to modedb, but modedb is
> > > really only for standardized display settings. The other way to do it
> > > would be to add a kernel config for which display you have connected to
> > > the board, but I think that is a bad idea, because it makes everything
> > > more complicated and switching out displays would require recompiling
> > > the kernel.
> > > 
> > > Maybe Tomi or the fbdev guys have some input on how to best do this?
> > 
> > There's no proper way for this currently. And I'm not even sure what
> > would be a good way to do this.
> > 
> > Optimally the board code could read some configuration value from eeprom
> > or where-ever, which would tell the configuration of the board. And the
> > board file could then configure the correct display.
> > 
> > Another way would be to add a devkit8000 specific kernel parameter,
> > given from bootloader, which would tell the configuration. The board
> > file would use this parameter to configure the correct display.
> > 
> >  Tomi
> > 
> > 
> 
> How about making it possible to give a generic panel name to the
> omapfb.mode boot parameter? This would also solve the problem for any
> future boards with different non-standard displays.

No, that wouldn't work. omapfb driver would need to somehow know about
the generic panel driver, to be able to set it up in a special way.

 Tomi


