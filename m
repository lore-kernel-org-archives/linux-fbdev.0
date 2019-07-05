From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 05 Jul 2019 15:00:54 +0000
Subject: Re: [PATCH 07/11] video: fbdev: wm8505fb: convert platform driver to use dev_groups
Message-Id: <3331c596-8150-3113-fc92-ffc72d7565c1@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190704084617.3602-1-gregkh@linuxfoundation.org>
        <CGME20190704142610epcas2p1f2dcbf38ea660bc26d306f2c0e1c71ca@epcas2p1.samsung.com>
        <20190704142602.GB6281@kroah.com>
In-Reply-To: <20190704142602.GB6281@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Tony Prisk <linux@prisktech.co.nz>, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, platform-driver-x86@vger.kernel.org


On 7/4/19 4:26 PM, Greg Kroah-Hartman wrote:
> Platform drivers now have the option to have the platform core create
> and remove any needed sysfs attribute files.  So take advantage of that
> and do not register "by hand" a sysfs file.
> 
> Cc: Tony Prisk <linux@prisktech.co.nz>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
