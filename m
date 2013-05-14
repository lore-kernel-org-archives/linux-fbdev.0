From: H Hartley Sweeten <hartleys@visionengravers.com>
Date: Tue, 14 May 2013 00:47:50 +0000
Subject: RE: [PATCH 02/15] video: ep93xx: remove unnecessary platform_set_drvdata()
Message-Id: <ADE657CA350FB648AAC2C43247A983F0021D46AC8643@AUSP01VMBX24.collaborationhost.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000201ce4e45$a5da7330$f18f5990$@samsung.com>
In-Reply-To: <000201ce4e45$a5da7330$f18f5990$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Saturday, May 11, 2013 5:47 AM, Jingoo Han wrote:
> The driver core clears the driver data to NULL after device_release
> or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
> (device-core: Ensure drvdata = NULL when no driver is bound).
> Thus, it is not needed to manually clear the device driver data to NULL.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/video/ep93xx-fb.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)

Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>

