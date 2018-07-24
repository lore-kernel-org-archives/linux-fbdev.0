From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 24 Jul 2018 16:50:45 +0000
Subject: Re: [PATCH] video: fbdev: tridentfb: remove deadcode on unreachable case statement
Message-Id: <2543058.xq6agm5N8h@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180716134504epcas5p2138ba82f2293c27750d4794f0152aad8@epcas5p2.samsung.com>
 <20180716134458.8654-1-colin.king@canonical.com>
In-Reply-To: <20180716134458.8654-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Colin King <colin.king@canonical.com>
Cc: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Monday, July 16, 2018 02:44:58 PM Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The value of tmp being used in the switch statement has the range of
> just 0..3 hence the case 4 statement can never be reached and is
> deadcode and can be removed.
> 
> Detected by CoverityScan, CID#744384 ("Logically dead code")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

