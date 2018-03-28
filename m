From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 28 Mar 2018 13:29:23 +0000
Subject: Re: [PATCH] video: fbdev: aty128fb: use true and false for boolean values
Message-Id: <3978155.69BmuUMc09@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180322201504epcas5p329c931766457a81d6dbf4ed70127cf9f@epcas5p3.samsung.com>
        <20180322201332.GA28960@embeddedgus>
In-Reply-To: <20180322201332.GA28960@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Paul Mackerras <paulus@samba.org>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

On Thursday, March 22, 2018 03:13:32 PM Gustavo A. R. Silva wrote:
> Assign true or false to boolean variables instead of an integer value.
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

