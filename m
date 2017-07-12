From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 12 Jul 2017 16:32:04 +0000
Subject: Re: [PATCH v2] fbdev: make get_fb_unmapped_area depends of !MMU
Message-Id: <1601047.VjR1LebSsk@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170712074407epcas2p1a2d7d15f28f9183d20e7919bb25be8fd@epcas2p1.samsung.com>
        <1499845387-10394-1-git-send-email-benjamin.gaignard@linaro.org>
In-Reply-To: <1499845387-10394-1-git-send-email-benjamin.gaignard@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: daniel.vetter@ffwll.ch, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, noralf@tronnes.org, dri-devel@lists.freedesktop.org, emil.l.velikov@gmail.com, yannick.fertre@st.com, eric.engestrom@imgtec.com

On Wednesday, July 12, 2017 09:43:07 AM Benjamin Gaignard wrote:
> Even if CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA flag is selected
> do not compile and use get_fb_unmapped_area() if CONFIG_MMU is
> also set. This will avoid mmap errors when compiling multi
> architectures at same time.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

Patch queued for 4.13, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

