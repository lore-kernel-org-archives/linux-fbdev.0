From: Steve Sakoman <sakoman@gmail.com>
Date: Fri, 15 Apr 2011 17:32:37 +0000
Subject: Re: [PATCH 0/5] OMAP: DSS: fixes for rc
Message-Id: <BANLkTim0J5dHLq_U_yMEZ=nn_qxdUXjt_g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1302855071-5510-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1302855071-5510-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

On Fri, Apr 15, 2011 at 1:11 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> Some small fixes to OMAP DSS for the next rc.
>
> I will send a pull request to Paul Mundt soon if there are no problems with the
> patches.

Tested on Overo (both 35XX and 37XX versions).

This patch series fixes the earlier issue of no video output on 37XX boards.

Tested-by: Steve Sakoman <steve@sakoman.com>
