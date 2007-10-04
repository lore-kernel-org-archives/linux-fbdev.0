From: Andrei Konovalov <akonovalov@ru.mvista.com>
Subject: Re: [PATCH 6/6] Xilinxfb: add of_platform bus binding
Date: Thu, 04 Oct 2007 16:11:42 +0400
Message-ID: <4704D87E.30104@ru.mvista.com>
References: <20071001155024.6114.47993.stgit@trillian.cg.shawcable.net> <20071001155759.6114.29143.stgit@trillian.cg.shawcable.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760067AbXJDMAd@vger.kernel.org>
In-Reply-To: <20071001155759.6114.29143.stgit@trillian.cg.shawcable.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, linuxppc@ozlabs.org, adaplas@gmail.com

Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> Adds the of_platform bus binding to the xilinxfb driver.  Needed to
> use framebuffer devices described in the OF device tree (used by
> arch/powerpc).
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---

Acked-by: Andrei Konovalov <akonovalov@ru.mvista.com>

Assuming the issue with error handling in xilinxfb_init() pointed out by
Akinobu Mita is fixed.

>  drivers/video/xilinxfb.c |  101 ++++++++++++++++++++++++++++++++++++++++++----
>  1 files changed, 93 insertions(+), 8 deletions(-)
