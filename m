From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 12 Mar 2018 15:48:16 +0000
Subject: Re: [PATCH] video: of: display_timing: Remove of_display_timings_exist() function
Message-Id: <1973667.1SDMdWEojW@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180219214747epcas2p2a8a8599ec940693141b8dcc358211a15@epcas2p2.samsung.com>
 <20180219214736.9447-1-vz@mleia.com>
In-Reply-To: <20180219214736.9447-1-vz@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Monday, February 19, 2018 11:47:36 PM Vladimir Zapolskiy wrote:
> Since introduction of of_display_timings_exist() function in commit
> cc3f414cf2e40 ("video: add of helper for display timings/videomode") it
> didn't attract any users, and the function has no potential, because
> of_get_display_timings() covers its functionality and does more.
> 
> Drop the unused exported function from the kernel.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

