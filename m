From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Wed, 10 Oct 2012 10:38:38 +0000
Subject: Re: [PATCH V4 0/5] OMAPDSS: Enable dynamic debug printing
Message-Id: <50754D5E.8030206@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1348826106.git.cmahapatra@ti.com>  <cover.1348914940.git.cmahapatra@ti.com> <1349441191.5836.8.camel@deskari>
In-Reply-To: <1349441191.5836.8.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Chandrabhanu Mahapatra <cmahapatra@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

Tomi, Chandrabhanu,

On Friday 05 October 2012 06:16 PM, Tomi Valkeinen wrote:
> On Sat, 2012-09-29 at 16:19 +0530, Chandrabhanu Mahapatra wrote:
>> Hi everyone,
>> this patch series aims at cleaning up of DSS of printk()'s enabled with
>> dss_debug and replace them with generic dynamic debug printing.
>
> Except for the missing debug print conversions in dsi.c this looks good.
> Do you want me to apply the current series and you can send the dsi.c
> patch later, or do you want to fix the dsi.c also before I apply?

With the change for DSI, please feel free to add

Reviewed-by: Sumit Semwal <sumit.semwal@ti.com>

BR,
~Sumit.
>
>   Tomi
>

