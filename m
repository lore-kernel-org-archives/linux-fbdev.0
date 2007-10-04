From: Andrei Konovalov <akonovalov@ru.mvista.com>
Subject: Re: [PATCH 3/6] Xilinxfb: rename failout labels to reflect failure
Date: Thu, 04 Oct 2007 16:06:40 +0400
Message-ID: <4704D750.6010207@ru.mvista.com>
References: <20071001155024.6114.47993.stgit@trillian.cg.shawcable.net> <20071001155743.6114.558.stgit@trillian.cg.shawcable.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761175AbXJDMCT@vger.kernel.org>
In-Reply-To: <20071001155743.6114.558.stgit@trillian.cg.shawcable.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, linuxppc@ozlabs.org, adaplas@gmail.com

Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> Labels and gotos are used in xilinxfb_assign to unwind allocations
> on device registration failures.  Rename the labels to reflect the
> error which occured.  This change is being made to make it easier
> to add new failout paths (which occurs in a subsuquent patch) and
> to make reviewing the failout path easier.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---

Acked-by: Andrei Konovalov <akonovalov@ru.mvista.com>

>  drivers/video/xilinxfb.c |   18 +++++++++---------
>  1 files changed, 9 insertions(+), 9 deletions(-)
