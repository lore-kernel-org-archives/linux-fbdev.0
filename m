From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] fbdev broken in current bk for PPC
Date: Sat, 11 Sep 2004 11:00:19 +1000
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1094864419.2578.154.camel@gaston>
References: <1094783022.2667.106.camel@gaston>
	 <200409110504.09812.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268010AbUIKBCT@vger.kernel.org>
In-Reply-To: <200409110504.09812.adaplas@hotpop.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: adaplas@pol.net
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>

On Sat, 2004-09-11 at 07:04, Antonino A. Daplas wrote:
> Hi Ben,
> 
> How about this patch?  This brings back the old way of setting up the
> drivers, supports:
> 
> video=xxxfb:off
> video=ofonly
> 
> Your patch that brings offb to the very last of the Makefile is needed.

Looks good !

Ben.
