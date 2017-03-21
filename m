From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 21 Mar 2017 15:17:19 +0000
Subject: Re: [PATCH 32/35] drivers/video: Convert remaining uses of pr_warning to pr_warn
Message-Id: <1984841.FWX9diQjjK@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1487314666.git.joe@perches.com>
 <CGME20170217071321epcas1p4117d349f33feb99c5e0f9a3288ef5a0e@epcas1p4.samsung.com>
 <e216f8cba5b81587b0c8300e9384e8efc12aa22b.1487314667.git.joe@perches.com>
In-Reply-To: <e216f8cba5b81587b0c8300e9384e8efc12aa22b.1487314667.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday, February 16, 2017 11:11:45 PM Joe Perches wrote:
> To enable eventual removal of pr_warning
> 
> This makes pr_warn use consistent for drivers/video
> 
> Prior to this patch, there were 6 uses of pr_warning and
> 25 uses of pr_warn in drivers/video
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Patch queued for 4.12, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

