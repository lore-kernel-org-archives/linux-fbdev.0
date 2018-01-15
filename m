From: Nicolas Pitre <nicolas.pitre@linaro.org>
Date: Mon, 15 Jan 2018 16:46:07 +0000
Subject: Re: [PATCH] console/dummy: leave .con_font_get set to NULL
Message-Id: <nycvar.YSQ.7.76.1801151142420.13881@knanqh.ubzr>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180105214302epcas3p1881997414f06e7ff06141318a610ac5b@epcas3p1.samsung.com>
 <nycvar.YSQ.7.76.1801051636340.1528@knanqh.ubzr>
 <2055048.eRiUAMEKEU@amdc3058>
In-Reply-To: <2055048.eRiUAMEKEU@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Mon, 15 Jan 2018, Bartlomiej Zolnierkiewicz wrote:

> On Friday, January 05, 2018 04:42:58 PM Nicolas Pitre wrote:
> > 
> > When this method is set, the caller expects struct console_font fields
> > to be properly initialized when it returns. Leave it unset otherwise
> > nonsensical (leaked kernel stack) values are returned to user space.
> > 
> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > Cc: stable@kernel.org
> 
> Please check your patches with tools/checkpatch.pl script:
> 
> ERROR: The 'stable' address should be 'stable@vger.kernel.org'
> #9: 
> Cc: stable@kernel.org

Oops. I cut and pasted it it from commit ea0ee33988778fb73e4f4.  ;-)


Nicolas
