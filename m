From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 08 Oct 2019 10:43:11 +0000
Subject: Re: [PATCH 3/5] backlight: pwm_bl: drop use of int_pow()
Message-Id: <20191008104311.s4k5syr7gd7tb55w@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190919140620.32407-1-linux@rasmusvillemoes.dk>
 <20190919140620.32407-3-linux@rasmusvillemoes.dk>
 <20191007152800.3nhbf7h7knumriz4@holly.lan>
 <5f19e307-29c4-f077-568d-b2bd6ae74608@rasmusvillemoes.dk>
 <20191008093145.kgx6ytkbycmmkist@holly.lan>
 <9bf6baf9-46be-771c-7e26-527b117c998a@rasmusvillemoes.dk>
In-Reply-To: <9bf6baf9-46be-771c-7e26-527b117c998a@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>

On Tue, Oct 08, 2019 at 12:02:07PM +0200, Rasmus Villemoes wrote:
> On 08/10/2019 11.31, Daniel Thompson wrote:
> > On Mon, Oct 07, 2019 at 08:43:31PM +0200, Rasmus Villemoes wrote:
> >> On 07/10/2019 17.28, Daniel Thompson wrote:
> >>> On Thu, Sep 19, 2019 at 04:06:18PM +0200, Rasmus Villemoes wrote:
> >>>
> >>> It feels like there is some rationale missing in the description here.
> >>>
> >>
> >> Apart from the function call overhead (and resulting register pressure
> >> etc.), using int_pow is less efficient (for an exponent of 3, it ends up
> >> doing four 64x64 multiplications instead of just two). But feel free to
> >> drop it, I'm not going to pursue it further - it just seemed like a
> >> sensible thing to do while I was optimizing the code anyway.
> >>
> >> [At the time I wrote the patch, this was also the only user of int_pow
> >> in the tree, so it also allowed removing int_pow altogether.]
> > 
> > To be honest the change is fine but the patch description doesn't make
> > sense if the only current purpose of the patch is as a optimization.
> 
> Agreed. Do you want me to resend the series with patch 3 updated to read
> 
> "For a fixed small exponent of 3, it is more efficient to simply use two
> explicit multiplications rather than calling the int_pow() library
> function: Aside from the function call overhead, its implementation
> using repeated squaring means it ends up doing four 64x64 multiplications."
> 
> (and obviously patch 5 dropped)?

Yes, please.

When you resend you can add my R-B: to all patches:

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.


PS Don't mind either way but I wondered the following is clearer than
   the slightly funky multiply-and-assign expression (which isn't wrong
   but isn't very common either so my brain won't speed read it):

		retval = DIV_ROUND_CLOSEST_ULL(retval * retval * retval,
		 			       scale * scale);
