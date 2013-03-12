From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 12 Mar 2013 13:37:03 +0000
Subject: Re: [PATCH 5/5] videomode: rename fields
Message-Id: <16625567.P7GdYge43z@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363083578-17062-1-git-send-email-tomi.valkeinen@ti.com>
	<1363083578-17062-5-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1363083578-17062-5-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Steffen Trumtrar <s.trumtrar@pengutronix.de>

Hi Tomi,

Thanks for the patch.

On Tuesday 12 March 2013 12:19:38 Tomi Valkeinen wrote:
> Structs videomode and display_timing have rather long field names for
> the timing values. Nothing wrong with that as such, but this patch
> changes them to abbreviations for the following reasons:
> 
> * The timing values often need to be used in calculations, and long
>   field names makes their direct use clumsier.
> 
> * The current names are a bit of a mishmash: some words are used as
>   such, some are shortened, and for some only first letter is used. Some
>   names use underscode, some don't. All this makes it difficult to
>   remember what the field names are.
> 
> * The abbreviations used in this patch are very common, and there
>   shouldn't be any misunderstanding about their meaning.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---

I have no strong opinion on this, but I find the existing names easier to 
read. I might be biased by having read them often though.

-- 
Regards,

Laurent Pinchart

