From: Andrei Konovalov <akonovalov@ru.mvista.com>
Subject: Re: [PATCH 5/6] Xilinxfb: cleanup platform_bus binding to use platform
 bus API.
Date: Thu, 04 Oct 2007 16:07:25 +0400
Message-ID: <4704D77D.1040005@ru.mvista.com>
References: <20071001155024.6114.47993.stgit@trillian.cg.shawcable.net> <20071001155754.6114.6830.stgit@trillian.cg.shawcable.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761694AbXJDMC7@vger.kernel.org>
In-Reply-To: <20071001155754.6114.6830.stgit@trillian.cg.shawcable.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, linuxppc@ozlabs.org, adaplas@gmail.com

Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> Change the platform bus binding to make use of the established
> platform_bus API.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---

Acked-by: Andrei Konovalov <akonovalov@ru.mvista.com>

>  drivers/video/xilinxfb.c |   32 ++++++++++++++++----------------
>  1 files changed, 16 insertions(+), 16 deletions(-)
