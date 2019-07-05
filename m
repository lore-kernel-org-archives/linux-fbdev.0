From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 05 Jul 2019 15:01:41 +0000
Subject: Re: [PATCH 09/11] video: fbdev: sm501fb: convert platform driver to use dev_groups
Message-Id: <bf91b478-7b70-1464-fd43-65ae251fa79a@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190704084617.3602-1-gregkh@linuxfoundation.org>
        <CGME20190704084710epcas1p2416255911d43174fc5bbfc9353431648@epcas1p2.samsung.com>
        <20190704084617.3602-10-gregkh@linuxfoundation.org>
In-Reply-To: <20190704084617.3602-10-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org


On 7/4/19 10:46 AM, Greg Kroah-Hartman wrote:
> Platform drivers now have the option to have the platform core create
> and remove any needed sysfs attribute files.  So take advantage of that
> and do not register "by hand" a bunch of sysfs files.
> 
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
