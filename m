From: "Cousson, Benoit" <b-cousson@ti.com>
Date: Tue, 14 Feb 2012 12:38:22 +0000
Subject: Re: OMAP DSS warning in apply.c
Message-Id: <4F3A55BE.9090109@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120214120643.GH15338@n2100.arm.linux.org.uk>
In-Reply-To: <20120214120643.GH15338@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>

+ Tomi

On 2/14/2012 1:06 PM, Russell King - ARM Linux wrote:
> kautobuildv2 discovered this in its omap4430sdp oldconfig build:
>
> drivers/video/omap2/dss/apply.c:350: warning: 'wait_pending_extra_info_updates' defined but not used
>
> This looks like a valid warning, because wait_pending_extra_info_updates()
> seems to be completely unreferenced.  Should the function be removed?
> It looks like extra_updated_completion can also be removed as well, as
> that function is the only place it gets initialized and waited for.
>
> The function also looks weird - it calls extra_info_update_ongoing() first
> under a lock, and then outside the lock.  It's not particularly nice API
> wise to have stuff sometimes called under a lock and sometimes not.

