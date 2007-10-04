From: Andrei Konovalov <akonovalov@ru.mvista.com>
Subject: Re: [PATCH 4/6] xilinxfb: Split device setup from bus binding
Date: Thu, 04 Oct 2007 16:07:05 +0400
Message-ID: <4704D769.8090207@ru.mvista.com>
References: <20071001155024.6114.47993.stgit@trillian.cg.shawcable.net> <20071001155748.6114.39929.stgit@trillian.cg.shawcable.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761431AbXJDMCj@vger.kernel.org>
In-Reply-To: <20071001155748.6114.39929.stgit@trillian.cg.shawcable.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, linuxppc@ozlabs.org, adaplas@gmail.com

Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> Split the device setup code away from the platform bus binding.  This is
> in preparation for adding the of_platform bus binding to this driver and
> most of the setup code is common between the two busses.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---

Acked-by: Andrei Konovalov <akonovalov@ru.mvista.com>

>  drivers/video/xilinxfb.c |  133 ++++++++++++++++++++++++++++------------------
>  1 files changed, 80 insertions(+), 53 deletions(-)
