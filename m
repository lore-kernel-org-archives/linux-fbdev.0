From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 14 Aug 2017 13:42:26 +0000
Subject: Re: [PATCH 2/2] video: fbdev: Enable Xilinx FB for ZynqMP
Message-Id: <CACRpkdZkppxer7KBdnb+G=7j1tK4EkQjT8ZDf7iPt7AgvQ_hCA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <b07b143769ed5dccf44e9de4cb0d5c6203b3eca0.1502179820.git.michal.simek@xilinx.com>
 <b10c4df7c5ac10d9290c3b9d2f113fb2f337b110.1502179820.git.michal.simek@xilinx.com>
In-Reply-To: <b10c4df7c5ac10d9290c3b9d2f113fb2f337b110.1502179820.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Simek <michal.simek@xilinx.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "monstr@monstr.eu" <monstr@monstr.eu>, Daniel Vetter <daniel.vetter@ffwll.ch>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Arnd Bergmann <arnd@arndb.de>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Paul Burton <paul.burton@imgtec.com>

On Tue, Aug 8, 2017 at 10:10 AM, Michal Simek <michal.simek@xilinx.com> wrote:

> Enable this driver for Xilinx ZynqMP.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Not a comment on the patch per se, but I would advice you to look into
migrating the Xilinx frame buffer to DRI/DRM/KMS.

The recent CMA helpers has made it very simple and focused to write
DRM drivers. See for example drivers/gpu/drm/pl111

Yours,
Linus Walleij
