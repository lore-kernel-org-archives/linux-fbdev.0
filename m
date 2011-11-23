From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 23 Nov 2011 06:52:47 +0000
Subject: Re: [PATCH 4/4] Drivers: video: sbuslib: fixed a brace coding style
Message-Id: <4ECC983F.1080602@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321591138-8334-1-git-send-email-zac.3.14159@gmail.com>
In-Reply-To: <1321591138-8334-1-git-send-email-zac.3.14159@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Zac Storer <zac.3.14159@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/18/2011 04:38 AM, Zac Storer wrote:
> Fixed a brace coding style issue.
> 
> Signed-off-by: Zac Storer <zac.3.14159@gmail.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/sbuslib.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/sbuslib.c b/drivers/video/sbuslib.c
> index 37d764a..3c1de98 100644
> --- a/drivers/video/sbuslib.c
> +++ b/drivers/video/sbuslib.c
> @@ -76,7 +76,7 @@ int sbusfb_mmap_helper(struct sbus_mmap_map *map,
>  				map_offset = (physbase + map[i].poff) & POFF_MASK;
>  				break;
>  			}
> -		if (!map_size){
> +		if (!map_size) {
>  			page += PAGE_SIZE;
>  			continue;
>  		}

