From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Fri, 28 Feb 2020 16:45:53 +0000
Subject: Re: [PATCH][V2] backlight: sky81452: insure while loop does not allow negative array indexing
Message-Id: <20200228164553.eojh3hbrymq3tw2d@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200226195826.6567-1-colin.king@canonical.com>
 <20200227114623.vaevrdwiduxa2mqs@holly.lan>
 <b0e21719-3a7c-099a-292d-c3fa65a84fe8@canonical.com>
In-Reply-To: <b0e21719-3a7c-099a-292d-c3fa65a84fe8@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Colin Ian King <colin.king@canonical.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, kernel-janitors@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>, Bryan Wu <cooloney@gmail.com>, Gyungoh Yoo <jack.yoo@skyworksinc.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Lee Jones <lee.jones@linaro.org>

On Thu, Feb 27, 2020 at 03:10:43PM +0000, Colin Ian King wrote:
> On 27/02/2020 11:46, Daniel Thompson wrote:
> > On Wed, Feb 26, 2020 at 07:58:26PM +0000, Colin King wrote:
> >> From: Colin Ian King <colin.king@canonical.com>
> >>
> >> In the unlikely event that num_entry is zero, the while loop
> >> pre-decrements num_entry to cause negative array indexing into the
> >> array sources. Fix this by iterating only if num_entry >= 0.
> >>
> >> Addresses-Coverity: ("Out-of-bounds read")
> >> Fixes: f705806c9f35 ("backlight: Add support Skyworks SKY81452 backlight driver")
> >> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> >> ---
> >>
> >> V2: fix typo in commit subject line
> > 
> > Isn't the correct spelling "ensure"?
> 
> It is. V1 is correct after all. Doh.

It wasn't spelt "ensure" in v1... 


Daniel.
