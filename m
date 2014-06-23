From: Julia Lawall <julia.lawall@lip6.fr>
Date: Mon, 23 Jun 2014 14:12:41 +0000
Subject: Re: [PATCH 3/10] video: use safer test on the result of find_first_zero_bit
Message-Id: <alpine.DEB.2.10.1406231612030.3905@hadrien>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1401872880-23685-1-git-send-email-Julia.Lawall@lip6.fr> <1401872880-23685-4-git-send-email-Julia.Lawall@lip6.fr> <53A81470.5030606@ti.com>
In-Reply-To: <53A81470.5030606@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 23 Jun 2014, Tomi Valkeinen wrote:

> On 04/06/14 12:07, Julia Lawall wrote:
> > From: Julia Lawall <Julia.Lawall@lip6.fr>
> >
> > Find_first_zero_bit considers BITS_PER_LONG bits at a time, and thus may
> > return a larger number than the maximum position argument if that position
> > is not a multiple of BITS_PER_LONG.
>
> Thanks, queued for 3.17.

No, sorry you can drop it.  It doesn't hurt anything, but it is not
necessary either.  Returning a larger number is actually not possible.

julia
