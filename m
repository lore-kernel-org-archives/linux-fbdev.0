From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 15 Nov 2010 04:48:57 +0000
Subject: Re: [PATCH] fsl-diu-fb: drop dead ioctl define
Message-Id: <20101115044856.GB8489@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1289631987-5854-1-git-send-email-vapier@gentoo.org>
In-Reply-To: <1289631987-5854-1-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-fbdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Anatolij Gustschin <agust@denx.de>

On Sat, Nov 13, 2010 at 02:06:27AM -0500, Mike Frysinger wrote:
> The fsl-diu-fb driver no longer uses this define, and we have a common one
> to cover this already (FBIO_WAITFORVSYNC).
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>

Queued for .37.
