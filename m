From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 7/7] [ARM] s3c-fb: Added color key blending.
Date: Sat, 3 Oct 2009 07:42:49 +0200
Message-ID: <20091003074249.2a8ae03d.krzysztof.h1@poczta.fm>
References: <E4D3F24EA6C9E54F817833EAE0D912AC0771185D5E@bssrvexch01.BS.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <E4D3F24EA6C9E54F817833EAE0D912AC0771185D5E@bssrvexch01.BS.local>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pawel Osciak <p.osciak@samsung.com>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "adaplas@gmail.com" <adaplas@gmail.com>, =?UTF-8?Q?=EB=B0=95=EA=B2=BD?= =?UTF-8?Q?=EB=AF=BC?= <kyungmin.park@samsung.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>

On Fri, 11 Sep 2009 20:05:04 +0200
Pawel Osciak <p.osciak@samsung.com> wrote:

> This feature allows blending based on color key value.
> Pixels with key value get blended with alpha1, while the rest
> gets blended with alpha0.
> 
> Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Pawel Osciak <p.osciak@samsung.com>
> 
> ---
>  arch/arm/plat-s3c/include/plat/s3c-fb.h |    2 ++
>  drivers/video/s3c-fb.c                  |   27 ++++++++++++++++++++++++++-
>  2 files changed, 28 insertions(+), 1 deletions(-)
> 

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>




----------------------------------------------------------------------
Zobacz najwiekszy samolot na swiecie!  
Kliknij >>> http://link.interia.pl/f238f
