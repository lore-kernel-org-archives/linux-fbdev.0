From: Timur Tabi <timur@tabi.org>
Date: Mon, 16 Mar 2015 19:29:43 +0000
Subject: Re: [PATCH 16/35 linux-next] video: constify of_device_id array
Message-Id: <55072F27.80003@tabi.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426533651-25586-1-git-send-email-fabf@skynet.be>
 <1426533651-25586-7-git-send-email-fabf@skynet.be>
In-Reply-To: <1426533651-25586-7-git-send-email-fabf@skynet.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 03/16/2015 02:20 PM, Fabian Frederick wrote:
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)
>
> Signed-off-by: Fabian Frederick<fabf@skynet.be>

...

>   drivers/video/fbdev/fsl-diu-fb.c           | 2 +-

For this driver:

Acked-by: Timur Tabi <timur@tabi.org>
