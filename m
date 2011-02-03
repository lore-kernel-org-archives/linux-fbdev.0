From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 03 Feb 2011 08:04:44 +0000
Subject: Re: [PATCH] radeonfb: Let hwmon driver probe the "monid" I2C bus
Message-Id: <20110203090444.6e020981@endymion.delvare>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110111162352.5a634e9e@endymion.delvare>
In-Reply-To: <20110111162352.5a634e9e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, 03 Feb 2011 07:41:01 +0200, Alexander Goomenyuk wrote:
> > I can imagine that sensor support has only been implemented for
> > atom-BIOS based boards and not older com-BIOS based ones. At least
> > searching for "lm63" in the source code has matches in only
> > radeon_atombios.c and not radeon_combios.c. I have no idea if it would
> > be possible to extend this mechanism to older boards or not - I don't
> > know if the com-BIOS included the information already.
>
> I would like to make some clarifications:
> The intention was to check how new radeon is working, or not working :),
> with thermal sensors. I am not competent enough to introduce any fixes
> to radeon driver.

And neither am I.

> The question is: Should I file the bug for radeon driver to implement
> thermal sensor support for com-BIOS based cards or not?

This would obviously be a feature request rather than a bug report.

I don't know if the com-BIOS based cards have the thermal sensor
information in the first place, so I don't know if the feature can be
implemented. If they don't, then auto-detection is the way to go, and
we can do it ourselves. If they do, the radeon driver maintainers would
have to work on it, if they are able and willing to do so.

So the next step is the radeon driver maintainers telling us whether
com-BIOS based cards have thermal sensor information as atom-BIOS based
ones do. You should ask this question to the right people and list.

-- 
Jean Delvare
