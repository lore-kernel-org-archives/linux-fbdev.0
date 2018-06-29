From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 29 Jun 2018 10:06:11 +0000
Subject: Re: [PATCH] console: dummycon: export dummycon_[un]register_output_notifier
Message-Id: <2122931.M7oWVmMZAv@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180629093647epcas5p4753328d494b7926e40e4a7d403f0677f@epcas5p4.samsung.com>
 <20180629093627.14620-1-hdegoede@redhat.com>
In-Reply-To: <20180629093627.14620-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Friday, June 29, 2018 11:36:27 AM Hans de Goede wrote:
> Export dummycon_[un]register_output_notifier, the fbcon code needs this
> and may be build as a module.
> 
> Fixes: 83d83bebf401 ("console/fbcon: Add support for deferred console takeover")
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to fbdev-for-next, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

