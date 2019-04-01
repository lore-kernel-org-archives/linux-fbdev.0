From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 01 Apr 2019 14:00:36 +0000
Subject: Re: [PATCH] fbdev: list all pci memory bars as conflicting apertures
Message-Id: <33cf37dc-8456-0316-0b48-fca7c92caa28@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190314114511epcas2p2a9669714177b00989bd3195300f7d3a6@epcas2p2.samsung.com>
        <20190314114500.8336-1-kraxel@redhat.com>
In-Reply-To: <20190314114500.8336-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@ffwll.ch>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>


On 03/14/2019 12:45 PM, Gerd Hoffmann wrote:
> Simply add all pci memory bars to struct apertures_struct in
> remove_conflicting_pci_framebuffers(), without depending on the
> res_id parameter.
> 
> The plan is to drop the res_id parameter later on.  For now keep the
> parameter, use it for sanity-checking and warn on inconsistencies.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Patch queued for v5.2, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
