From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 08 Feb 2019 17:27:27 +0000
Subject: Re: [PATCH] fbdev: mbx: fix up debugfs file creation
Message-Id: <0d953f69-f112-6e1b-0ba3-02ce56e8d1c5@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190122152306epcas1p4b57a2364aab23e4963f8c578ca73a197@epcas1p4.samsung.com>
        <20190122152151.16139-16-gregkh@linuxfoundation.org>
In-Reply-To: <20190122152151.16139-16-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org


On 01/22/2019 04:21 PM, Greg Kroah-Hartman wrote:
> There is no need to keep the dentries around for the individual debugfs
> files, just delete the whole directory all at once at shutdown instead.
> 
> This also fixes a tiny memory leak where the memory for the pointers to
> the file dentries was never freed when the device shut down, as well as
> making the logic of the code a lot simpler.
> 
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Patch queued for v5.1, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
