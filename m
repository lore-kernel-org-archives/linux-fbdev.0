From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 02 Feb 2011 09:51:01 +0000
Subject: Re: [PATCH] radeonfb: Let hwmon driver probe the "monid" I2C bus
Message-Id: <1296640261.2349.683.camel@pasglop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110111162352.5a634e9e@endymion.delvare>
In-Reply-To: <20110111162352.5a634e9e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, 2011-02-02 at 09:12 +0100, Jean Delvare wrote:
> > If this is a concern to you, I'd be fine excluding CONFIG_PPC from
> the
> > change. Or are you worried about Intel Mac machines too? If there's
> an
> > easy way to spot all powermac machines, we can use that too, just
> let
> > me know how.
> > 
> > > Haven't had a chance to look much yet.
> 
> Ben, any progress on this?

Sorry, too swamped. Go on with CONFIG_PPC excluded for now.

Cheers,
Ben.


