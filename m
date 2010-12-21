From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Date: Tue, 21 Dec 2010 07:29:03 +0000
Subject: Re: [PATCH 1/3] fb: fix overlapping test off-by-one.
Message-Id: <1292916543.19556.46.camel@thor.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1292895677-4242-1-git-send-email-airlied@gmail.com>
	 <1292895677-4242-2-git-send-email-airlied@gmail.com>
In-Reply-To: <1292895677-4242-2-git-send-email-airlied@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Dave Airlie <airlied@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Dave Airlie <airlied@redhat.com>, linux-kernel@vger.kernel.org, dri-devel@lists.sf.net

On Die, 2010-12-21 at 11:41 +1000, Dave Airlie wrote: 
> From: Dave Airlie <airlied@redhat.com>
> 
> On my system with a radeon x2, the first GPU was not overlapping vesa
> but the test decided it was.
> 
> Signed-off-by: Dave Airlie <airlied@redhat.com>
> ---
>  drivers/video/fbmem.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> index 0e6aa3d..4ac1201 100644
> --- a/drivers/video/fbmem.c
> +++ b/drivers/video/fbmem.c
> @@ -1458,7 +1458,7 @@ static bool apertures_overlap(struct aperture *gen, struct aperture *hw)
>  	if (gen->base = hw->base)
>  		return true;
>  	/* is the generic aperture base inside the hw base->hw base+size */
> -	if (gen->base > hw->base && gen->base <= hw->base + hw->size)
> +	if (gen->base > hw->base && gen->base < hw->base + hw->size)

Good catch.

Reviewed-by: Michel Dänzer <michel@daenzer.net>


-- 
Earthling Michel Dänzer           |                http://www.vmware.com
Libre software enthusiast         |          Debian, X and DRI developer
