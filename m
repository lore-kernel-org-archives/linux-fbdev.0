From: Archit Taneja <archit@ti.com>
Date: Mon, 11 Mar 2013 06:36:21 +0000
Subject: Re: [PATCH 14/20] OMAPDSS: remove dssdev->channel assignments
Message-Id: <513D7895.2030307@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com> <1362743515-10152-15-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1362743515-10152-15-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Friday 08 March 2013 05:21 PM, Tomi Valkeinen wrote:
> Now that the driver uses ooutput->recommended_channel, we can remove the

Typo above for 'output'. We could discard this patch if we don't add 
dssdev->channel assignments in patch # 10.

Archit
