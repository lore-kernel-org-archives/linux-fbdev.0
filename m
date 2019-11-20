From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 20 Nov 2019 16:55:33 +0000
Subject: Re: [PATCH] staging: fbtft: Fix Kconfig indentation
Message-Id: <20191120165533.GA3027865@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191120133911.13539-1-krzk@kernel.org>
 <20191120164155.GR30416@phenom.ffwll.local>
In-Reply-To: <20191120164155.GR30416@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Wed, Nov 20, 2019 at 05:41:55PM +0100, Daniel Vetter wrote:
> On Wed, Nov 20, 2019 at 09:39:11PM +0800, Krzysztof Kozlowski wrote:
> > Adjust indentation from spaces to tab (+optional two spaces) as in
> > coding style with command like:
> > 	$ sed -e 's/^        /\t/' -i */Kconfig
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> I expect Greg will pick this up.

Already picked up :)

thanks for the review,

greg k-h
