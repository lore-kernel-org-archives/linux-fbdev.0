From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 20 Nov 2011 01:50:33 +0000
Subject: Re: [PATCH 5/5] Drivers: video: riva: riva_hw: fixed a brace coding
Message-Id: <4EC85CE9.6060706@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321591537-8475-1-git-send-email-zac.3.14159@gmail.com>
In-Reply-To: <1321591537-8475-1-git-send-email-zac.3.14159@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Zac Storer <zac.3.14159@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/18/2011 04:45 AM, Zac Storer wrote:
> Fixed a brace coding style issue.

*sigh* You are fixing coding style, but I still get lots of warnings for the
single line you are changing. IF you are fixing coding style, at least do it
right. Or do you really expect me to be happy if you send me 3 patches that all
touch the same line?
Really, if you want to fix it, at least fix it in a way that checkpatch.pl does
no longer complain about your patch, at least regarding coding style issues. And
for such patches I think a per file patch or similar would be appropriate.


Regards,

Florian Tobias Schandinat

> 
> Signed-off-by: Zac Storer <zac.3.14159@gmail.com>
> ---
>  drivers/video/riva/riva_hw.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/riva/riva_hw.c b/drivers/video/riva/riva_hw.c
> index 78fdbf5..c4b8a6f 100644
> --- a/drivers/video/riva/riva_hw.c
> +++ b/drivers/video/riva/riva_hw.c
> @@ -994,7 +994,7 @@ static void nv10CalcArbitration
>                clwm = clwm_mt;
>    */
>            /* Finally, a heuristic check when width = 64 bits */
> -          if(width = 1){
> +          if(width = 1) {
>                nvclk_fill = nvclk_freq * 8;
>                if(crtc_drain_rate * 100 >= nvclk_fill * 102)
>                        clwm = 0xfff; /*Large number to fail */

