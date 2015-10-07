From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 07 Oct 2015 06:04:37 +0000
Subject: Re: [PATCH v2 2/2] staging: fbtft: use alternate screen pointer
Message-Id: <20151007060437.GY7289@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1444196732-27841-1-git-send-email-lars1.svensson@sonymobile.com>
 <1444196732-27841-2-git-send-email-lars1.svensson@sonymobile.com>
In-Reply-To: <1444196732-27841-2-git-send-email-lars1.svensson@sonymobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lars Svensson <lars1.svensson@sonymobile.com>
Cc: thomas.petazzoni@free-electrons.com, noralf@tronnes.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

The change to fbtft_write_vmem16_bus9() is a bugfix, which is great, but
it's not mentioned in the changelog.  Really it should be a separate
commit.

Fixes: 02eb884f4e26 ('drivers: staging: fbtft: fbtft-bus.c: Fix different address space warning on I/O mem')

So it looks like this:
[patch 1] fb.h: Provide alternate screen_base pointer
[patch 2] sed /screen_base/screen_buffer/
[patch 3] fix a bug in fbtft_write_vmem16_bus9()

regards,
dan carpenter

