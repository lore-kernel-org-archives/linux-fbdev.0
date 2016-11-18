From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Date: Fri, 18 Nov 2016 14:15:47 +0000
Subject: Re: [PATCHv0 1/1] fbdev: add Intel FPGA FRAME BUFFER driver
Message-Id: <20161118141547.465c431e@lxorguk.ukuu.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479287278-5192-1-git-send-email-hean.loong.ong@intel.com>
        <20161118140903.q33zx7bk5nergq45@rob-hp-laptop>
In-Reply-To: <20161118140903.q33zx7bk5nergq45@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: "Ong, Hean Loong" <hean.loong.ong@intel.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

> AIUI, we're not taking new FB drivers. This should be a DRM driver 
> instead.

Yes - clone one of the dumb DRM drivers, or if you've got any little bits
of acceleration (even rolling the display) then it's possibly worth
accelerating for text mode.

> > +- max-width: The width of the framebuffer in pixels.
> > +- max-height: The height of the framebuffer in pixels.
> > +- bits-per-color: only "8" is currently supported  
> 
> These are not h/w properties.

How are the max ones not hardware properties ?

Alan
