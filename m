From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 17 Oct 2017 13:10:59 +0000
Subject: Re: [PATCH 1/1] drivers:video: use setup_timer
Message-Id: <15879603.v8aXiaZcPX@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170921110539epcas2p303a5bbfd69d03cfe4e79a0833027eb2f@epcas2p3.samsung.com>
        <1505991931-30437-1-git-send-email-allen.lkml@gmail.com>
In-Reply-To: <1505991931-30437-1-git-send-email-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Allen Pais <allen.lkml@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org


Hi,

On Thursday, September 21, 2017 04:35:31 PM Allen Pais wrote:
>     Use setup_timer function instead of initializing timer with the
>     function and data fields.
> 
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>

Thanks for the patch but I've ended applying a bit more complete one
from Himanshu Jha:

https://lkml.org/lkml/2017/9/28/695

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

