From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 01 Aug 2017 13:36:01 +0000
Subject: Re: [PATCH] fbdev: uvesafb: remove DRIVER_ATTR() usage
Message-Id: <3613878.J9SAsAfrTp@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170719125131epcas5p4fed9dd550f3b19744e793831a9a2b1db@epcas5p4.samsung.com>
        <20170719125119.GB17776@kroah.com>
In-Reply-To: <20170719125119.GB17776@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Michal Januszewski <spock@gentoo.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, July 19, 2017 02:51:19 PM Greg KH wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> It's better to be explicit and use the DRIVER_ATTR_RW() macro when
> defining a driver's sysfs file.  Bonus is this fixes up a checkpatch.pl
> warning.
> 
> This is part of a series to drop DRIVER_ATTR() from the tree entirely.
> 
> Cc: Michal Januszewski <spock@gentoo.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

I assume that this will go through your tree with other DRIVER_ATTR()
removal patches (please ping me if you want me to merge this patch
through fbdev tree).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

