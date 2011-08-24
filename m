From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 24 Aug 2011 13:59:03 +0000
Subject: Re: [PATCH 4/6] udlfb: Add module option to do without shadow framebuffer
Message-Id: <4E5503A7.9070707@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1313958862-5640-7-git-send-email-bernie@plugable.com>
In-Reply-To: <1313958862-5640-7-git-send-email-bernie@plugable.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 08/21/2011 08:34 PM, bernie@plugable.com wrote:
> From: Stuart Hopkins <stuart@linux-depot.com>
> 
> By default, udlfb allocates a 2nd buffer to shadow what's across
> the bus on the USB device.  It can operate without this shadow,
> but then it cannot tell which pixels have changed, and must send all.
> 
> Saves host memory, but worsens the USB 2.0 bus bottleneck.
> 
> This option allows users in very low memory situations (e.g.
> bifferboard) to optionally turn off this shadow framebuffer.
> 
> Signed-off-by: Bernie Thompson <bernie@plugable.com>
> Signed-off-by: Stuart Hopkins <stuart@linux-depot.com>

The order of the Signed-offs looks a bit strange here so I reordered them.

I applied the ?/6 series.


Thanks,

Florian Tobias Schandinat
