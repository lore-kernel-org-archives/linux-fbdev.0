From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 06 Oct 2015 07:18:13 +0000
Subject: Re: [PATCH 2/2] staging: fbtft: fix sparse warning in call to vfree()
Message-Id: <20151006071813.GT7289@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1444114926-18000-1-git-send-email-lars1.svensson@sonymobile.com>
 <1444114926-18000-2-git-send-email-lars1.svensson@sonymobile.com>
In-Reply-To: <1444114926-18000-2-git-send-email-lars1.svensson@sonymobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lars Svensson <lars1.svensson@sonymobile.com>
Cc: thomas.petazzoni@free-electrons.com, noralf@tronnes.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

Could you update everything in that directory all at once instead?

grep screen_base drivers/staging/fbtft/*c

regards,
dan carpenter

