From: Sasha Levin <sashal@kernel.org>
Date: Tue, 01 Oct 2019 18:38:34 +0000
Subject: Re: [PATCH] video: hyperv_fb: Add the support of hibernation
Message-Id: <20191001183834.GA8171@sasha-vm>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1568244833-66476-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1568244833-66476-1-git-send-email-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dexuan Cui <decui@microsoft.com>
Cc: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Kelley <mikelley@microsoft.com>

On Wed, Sep 11, 2019 at 11:34:10PM +0000, Dexuan Cui wrote:
>This patch depends on the vmbus side change of the definition of
>struct hv_driver.
>
>Signed-off-by: Dexuan Cui <decui@microsoft.com>

Queued up for hyperv-next, thanks!

--
Thanks,
Sasha
