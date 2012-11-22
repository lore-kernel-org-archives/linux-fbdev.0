From: Tony Prisk <linux@prisktech.co.nz>
Date: Thu, 22 Nov 2012 18:07:00 +0000
Subject: Re: [PATCH 0/4] video: vt8500: cleanup and use of devm_ apis
Message-Id: <1353607620.12263.2.camel@gitbox>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353566531-31251-1-git-send-email-tushar.behera@linaro.org>
In-Reply-To: <1353566531-31251-1-git-send-email-tushar.behera@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tushar Behera <tushar.behera@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, FlorianSchandinat@gmx.de, patches@linaro.org

On Thu, 2012-11-22 at 12:12 +0530, Tushar Behera wrote:
> Patch 1 fixes a possible memory leak in the driver.
> Rest 3 patches add/update usage of devm_ apis.
> 
> These patches are only build-tested.
> 
> Tushar Behera (4):
>   video: vt8500: Fix memory leak in probe function
>   video: vt8500: Fix invalid free of devm_ allocated data
>   video: vt8500: Convert to use devm_request_mem_region()
>   video: vt8500: Convert to use devm_ioremap()
> 
>  drivers/video/vt8500lcdfb.c |   47 +++++++++++++++---------------------------
>  1 files changed, 17 insertions(+), 30 deletions(-)
> 

Thanks for the tidy up.
All patches Acked-by: Tony Prisk <linux@prisktech.co.nz>


