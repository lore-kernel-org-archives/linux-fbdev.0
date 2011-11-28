From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Mon, 28 Nov 2011 11:41:53 +0000
Subject: Re: [PATCH 2/2] video: s3c-fb: Convert to devm style allocation
Message-Id: <20111128114153.GD2934@opensource.wolfsonmicro.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1322434268-25525-2-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1322434268-25525-2-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Nov 28, 2011 at 07:59:27AM +0000, Jingoo Han wrote:

Don't top post!

> Your patch makes build error as follows:
> drivers/video/s3c-fb.c: In function 's3c_fb_probe':
> drivers/video/s3c-fb.c:1385: error: implicit declaration of function 'devm_request_and_ioremap'
> drivers/video/s3c-fb.c:1385: warning: assignment makes pointer from integer without a cast
> make[2]: *** [drivers/video/s3c-fb.o] Error 1
> make[1]: *** [drivers/video] Error 2

This is present in -next.
