From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 29 Feb 2012 09:56:06 +0000
Subject: Re: [PATCH 0/2] OMAPDSS: small fixes for 3.3 rc
Message-Id: <4F4DF636.1040303@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1330505302-8258-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1330505302-8258-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

Hi Tomi,

On 02/29/2012 08:48 AM, Tomi Valkeinen wrote:
> Hi,
> 
> Two small fixes for omapdss.
> 
> Florian, if the patches are ok, I guess it's easier if you just apply these
> patches from email, instead of me sending a pull request?

Yes, that's correct as those are only a few patches and as we are already in
late -rc's (and therefore I guess, I should take a better look at what I apply).
I'll add some comments to your patches in separate mails.


Best regards,

Florian Tobias Schandinat

> 
>  Tomi
> 
> Tomi Valkeinen (2):
>   OMAPDSS: panel-dvi: Add Kconfig dependency on I2C
>   OMAPDSS: APPLY: make ovl_enable/disable synchronous
> 
>  drivers/video/omap2/displays/Kconfig |    2 +-
>  drivers/video/omap2/dss/apply.c      |    6 ++++++
>  2 files changed, 7 insertions(+), 1 deletions(-)
> 

