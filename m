From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 04 Jul 2018 17:07:31 +0000
Subject: Re: [PATCH] fbdev: Distinguish between interlaced and progressive modes
Message-Id: <1828178.vF6XXv5T2I@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180622183754.GB17701@localhost.localdomain>
In-Reply-To: <20180622183754.GB17701@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Hi,

On Friday, June 22, 2018 08:37:54 PM Fredrik Noring wrote:
> With this change fb_find_mode can match interlaced and progressive
> modes equally well, and distinguish between for example 1920x1080i
> and 1920x1080p.
> 
> Signed-off-by: Fredrik Noring <noring@nocrew.org>

Could you please give some examples of use cases that need this change
(i.e. which fbdev drivers need it for which modes etc.)?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

