From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Sun, 17 Jul 2016 15:20:12 +0000
Subject: Re: [patch] video: fbdev: pxafb: potential NULL dereference on error
Message-Id: <87bn1w1ec3.fsf@belgarion.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160715110732.GC9258@mwanda>
In-Reply-To: <20160715110732.GC9258@mwanda> (Dan Carpenter's message of "Fri,
	15 Jul 2016 14:07:32 +0300")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> writes:

> If we "goto out;" then it calls display_timings_release(timings);
> Since "timings" is NULL, that's going to oops.  Just return directly.
>
> Fixes: 420a488278e8 ('video: fbdev: pxafb: initial devicetree conversion')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
