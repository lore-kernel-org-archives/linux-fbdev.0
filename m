From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 20 Dec 2010 15:58:47 +0000
Subject: Re: [PATCH] s3c-fb: add support for runtime pm
Message-Id: <20101220155847.GB26766@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1292571946-13595-1-git-send-email-jg1.han@samsung.com>
In-Reply-To: <1292571946-13595-1-git-send-email-jg1.han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, Ilho Lee <ilho215.lee@samsung.com>

On Fri, Dec 17, 2010 at 04:45:46PM +0900, Jingoo Han wrote:
> This patch adds support for runtime pm using the functions.
>  - pm_runtime_get_sync()
>  - pm_runtime_put_sync()
> 
> pm_runtime_get_sync() and pm_runtime_put_sync() are called when
> open or release function of framebufer driver is called to inform
> the system if hardware is idle or not.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Barring any objections, I'll apply it, thanks.
