From: Alex Courbot <acourbot@nvidia.com>
Date: Mon, 19 Nov 2012 02:29:05 +0000
Subject: Re: [PATCHv9 1/3] Runtime Interpreted Power Sequences
Message-Id: <8058793.mIXgB85Mso@percival>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353149747-31871-1-git-send-email-acourbot@nvidia.com>
 <1353149747-31871-2-git-send-email-acourbot@nvidia.com>
 <20121117113849.GA5228@lizard>
In-Reply-To: <20121117113849.GA5228@lizard>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Saturday 17 November 2012 19:38:50 Anton Vorontsov wrote:
> > +++ b/drivers/power/power_seq/Kconfig
> > @@ -0,0 +1,2 @@
> > +config POWER_SEQ
> > +	tristate
> 
> This really needs a proper Kconfig description and a help text, shortly
> describing the purpose of the subsystem.

Does it? The current state makes power seqs automatically selected by drivers 
that need it, and they do not appear in the configuration menu. If we add a 
description they will then become a visible item, so the logic would be to 
make it user-selectable.

If that approach is preferred, I will also have to change pwm-backlight so 
that it compiles without power sequences. Not that I mind, but I liked the 
idea of not adding yet-another-option to the config menu.

Fixed the code according to all your other comments, thanks!

Alex.

