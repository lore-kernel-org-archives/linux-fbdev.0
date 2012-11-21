From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Wed, 21 Nov 2012 12:00:40 +0000
Subject: Re: [PATCH 298/493] video: remove use of __devinitdata
Message-Id: <20121121120040.GJ3290@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-298-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-298-git-send-email-wfp5p@virginia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Nov 19, 2012 at 01:24:07PM -0500, Bill Pemberton wrote:
>  drivers/video/acornfb.c                |  8 +++---
>  drivers/video/cyber2000fb.c            |  2 +-
>  drivers/video/sa1100fb.c               |  2 +-

For these three,

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
