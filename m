From: Pavel Machek <pavel@ucw.cz>
Date: Sat, 20 Dec 2014 21:01:25 +0000
Subject: Re: [GIT PULL] fbdev fixes for 3.19
Message-Id: <20141220210125.GB16705@amd>
List-Id: <linux-fbdev.vger.kernel.org>
References: <54899F0E.4090309@ti.com>
In-Reply-To: <54899F0E.4090309@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Mark Brown <broonie@kernel.org>

Hi!

> Please pull fbdev changes for 3.19.
> 
>  Tomi

v3.19-rc0 breaks video on my n900.

> Archit Taneja (7):
>       OMAPDSS: DPI: Use DPI driver data
>       OMAPDSS: DPI: Allocate driver data
>       OMAPDSS: DPI: Store dpi_data pointer in the DT port's data
>       OMAPDSS: DSS: init dss ports cleanly
>       OMAPDSS: DT: Get source endpoint by matching reg-id
>       OMAPDSS: DPI: Add support for multiple instances
>       OMAPDSS: DSS: add a param to dpi_select_source which specifies
>       it's port number

And I have these in my tree, so I should have latest fixes. Any ideas
what I should try?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
