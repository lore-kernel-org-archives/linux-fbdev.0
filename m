From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Fri, 12 Nov 2010 13:19:40 +0000
Subject: Re: [PATCH v2 0/2] OMAP3: DSS2: Pre-Multiplied Alpha support
Message-Id: <1289567980.3297.275.camel@tubuntu>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1288870122-22836-1-git-send-email-samreen@ti.com>
In-Reply-To: <1288870122-22836-1-git-send-email-samreen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ext Samreen <samreen@ti.com>
Cc: "Syrjala Ville (Nokia-MS/Helsinki)" <ville.syrjala@nokia.com>, Archit Taneja <archit@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Hi,

On Thu, 2010-11-04 at 12:28 +0100, ext Samreen wrote:
> Enable Pre multiplied alpha support on OMAP3630
> 
> The first patch splits the omap3 dss has features for omap3430
> and omap3630 separately
> The second patch adds the support for pre multiplied alpha
> 
> Version2:
>    - Split the patch into dss has feature patch and pre multiplied
>    alpha support
>    - Remove the BUG_ON in functions setting pre multiplied alpha
>    and global alpha 
>    - Uniformly use "pre_mult_alpha" naming convention

Looks good, I'll apply to my tree.

 Tomi


