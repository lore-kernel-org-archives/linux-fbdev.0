From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 16 Sep 2011 14:17:19 +0000
Subject: Re: Proposal for a low-level Linux display framework
Message-Id: <20110916141719.GD2873@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316088425.11294.78.camel@lappyti>
 <yunboul7sx7.fsf@aiko.keithp.com>
 <1316100594.23214.65.camel@deskari>
 <yun8vpp7qk7.fsf@aiko.keithp.com>
 <1316107275.23214.99.camel@deskari>
 <yunfwjxwbjq.fsf@aiko.keithp.com>
In-Reply-To: <yunfwjxwbjq.fsf@aiko.keithp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Keith Packard <keithp@keithp.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linaro-dev@lists.linaro.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Archit Taneja <archit@ti.com>, "Clark, Rob" <rob@ti.com>

On Thu, Sep 15, 2011 at 07:55:37PM -0500, Keith Packard wrote:
> I suspect helper functions would be a good model to follow, rather than
> trying to create a whole new device infrastructure; some of the
> communication paths aren't easily separable from the underlying output
> devices.

This. Helper functions make the driver writers life so much easier - if
your hw doesn't quite fit the model, you can usually extend functionality
with much less fuzz than if there's a full framework. This is also pretty
much the reason, why I don't like ttm.
-Daniel
-- 
Daniel Vetter
Mail: daniel@ffwll.ch
Mobile: +41 (0)79 365 57 48
