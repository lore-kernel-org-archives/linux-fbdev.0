From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: Fix IO access in rivafb
Date: Tue, 09 Nov 2004 08:50:17 +1100
Message-ID: <1099950617.3946.163.camel@gaston>
References: <200411080521.iA85LbG6025914@hera.kernel.org>
	 <1099893447.10262.154.camel@gaston> <200411081633.00645.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261257AbUKHVwN@vger.kernel.org>
In-Reply-To: <200411081633.00645.adaplas@hotpop.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: adaplas@pol.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Mon, 2004-11-08 at 16:33 +0800, Antonino A. Daplas wrote:

> Hmm, I'll ask Guido Guenther if he can test the changes. I think a different
> set of access macros for PPC might be a more preferrable solution. 

Well, I'd rather leave the registers Little Endian, but then, it will
clash with X which does put them into Big Endian mode, so that would
have to be restored all the time.

Ben.
