From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 20 Nov 2019 13:50:12 +0000
Subject: Re: [PATCH] video: Fix Kconfig indentation
Message-Id: <20191120135012.GA17348@kozik-lap>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191120133838.13132-1-krzk@kernel.org>
 <20191120134546.GA2654@pine>
In-Reply-To: <20191120134546.GA2654@pine>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

On Wed, Nov 20, 2019 at 08:45:46AM -0500, Daniel Thompson wrote:
> On Wed, Nov 20, 2019 at 09:38:38PM +0800, Krzysztof Kozlowski wrote:
> > Adjust indentation from spaces to tab (+optional two spaces) as in
> > coding style with command like:
> > 	$ sed -e 's/^        /\t/' -i */Kconfig
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> No particular objections but I wonder if this would be better sent to
> trivial@kernel.org .

Thanks for feedback.

I sent to trivial and kernel-janitors my previous version of this
patchset which was not split per-subsystem and there was no feedback.
Few other patches already came through maintainers. If there will be no
reply, I'll send next version through trivial.

Best regards,
Krzysztof
