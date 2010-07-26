From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Mon, 26 Jul 2010 08:21:24 +0000
Subject: Re: [PATCH] OMAP2: OMAPFB: Fix invalid bpp for PAL and NTSC modes
Message-Id: <1280132484.2427.14.camel@tubuntu.research.nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4c477948.cf7d0e0a.2929.ffffaefe@mx.google.com>
In-Reply-To: <4c477948.cf7d0e0a.2929.ffffaefe@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ext Maurus Cuelenaere <mcuelenaere@gmail.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Syrjala Ville (Nokia-MS/Helsinki)" <ville.syrjala@nokia.com>, "tj@kernel.org" <tj@kernel.org>

On Thu, 2010-07-22 at 00:40 +0200, ext Maurus Cuelenaere wrote:
> omapfb_mode_to_timings() sets the bpp to 0 when bootarg omapfb.mode is set to
> either "pal" or "ntsc". This patch corrects this by setting the bpp to 24, as
> would be done if omapdss_default_get_recommended_bpp() would be called

Thanks, applied to my tree.

 Tomi


