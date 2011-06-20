From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Mon, 20 Jun 2011 12:20:32 +0000
Subject: Re: [PATCH 1/2] config: omap2+: force fb and dss support as
Message-Id: <20110620122032.GJ2082@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308566761-2850-1-git-send-email-tushar.behera@linaro.org>
	<1308566761-2850-2-git-send-email-tushar.behera@linaro.org>
	<B85A65D85D7EB246BE421B3FB0FBB593024D625A5C@dbde02.ent.ti.com>
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D625A5C@dbde02.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jun 20, 2011 at 05:37:07PM +0530, Premi, Sanjeev wrote:
> [sp] Instead of changing the omap2plus_defconfig, shouldn't the
>      board specific file be fixed instead?

The board specific configuration files in the mainline kernel are
deprecated and are gradually being removed.
