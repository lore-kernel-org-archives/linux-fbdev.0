From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 24 Apr 2014 08:27:18 +0000
Subject: Re: [PATCH] fbdev: Fix tmiofb driver dependencies
Message-Id: <20140424102718.1ce11183@endymion.delvare>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140423135104.2974008f@endymion.delvare>
In-Reply-To: <20140423135104.2974008f@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Geert,

On Wed, 23 Apr 2014 21:45:45 +0200, Geert Uytterhoeven wrote:
> On Wed, Apr 23, 2014 at 1:51 PM, Jean Delvare <jdelvare@suse.de> wrote:
> > The tmiofb driver should not depend on MFD_CORE but on MFD_TMIO.
> > Without the tmio_core driver, tmiofb has no platform device to bind
> > to and is thus useless.
> 
> What about COMPILE_TEST?

I could add that, yes, good point.

> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > ---
> > I suspect that MFD_TMIO was originally intended and MFD_CORE was a
> > typo.
> 
> Does it compile with MFD_CORE=n?

I tried and yes, it does.

> If no: depends on FB && MDF_CORE && (MFD_TMIO || COMPILE_TEST)
> If yes: depends on FB && (MFD_TMIO || COMPILE_TEST)

I'll send an updated patch doing the latter.

Thanks for the review,
-- 
Jean Delvare
SUSE L3 Support
