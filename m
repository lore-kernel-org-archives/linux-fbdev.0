From: David Brown <davidb@codeaurora.org>
Date: Thu, 09 Aug 2012 17:38:53 +0000
Subject: Re: [PATCH 5/5] drivers/video/msm/mddi_client_nt35399.c: use devm_ functions
Message-Id: <20120809173853.GB23447@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344008414-2894-1-git-send-email-damien.cassou@lifl.fr>
 <1344008414-2894-5-git-send-email-damien.cassou@lifl.fr>
In-Reply-To: <1344008414-2894-5-git-send-email-damien.cassou@lifl.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Damien Cassou <damien.cassou@lifl.fr>
Cc: kernel-janitors@vger.kernel.org, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Aug 03, 2012 at 05:40:13PM +0200, Damien Cassou wrote:
> From: Damien Cassou <damien.cassou@lifl.fr>
> 
> The various devm_ functions allocate memory that is released when a driver
> detaches. This patch replaces the use of kzalloc by devm_kzalloc.
> 
> Additionally, this patch fixes a memory leak: some memory was allocated for
> 'panel' but not released when the subsequent call to setup_vsync fails.
> 
> Signed-off-by: Damien Cassou <damien.cassou@lifl.fr>

Acked-by: David Brown <davidb@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
