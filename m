From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] fbdev broken in current bk for PPC
Date: Tue, 21 Sep 2004 03:59:21 +0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200409210359.21424.adaplas@hotpop.com>
References: <1094783022.2667.106.camel@gaston> <20040920085214.0abe33a0.akpm@osdl.org> <200409210338.00863.adaplas@hotpop.com>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267301AbUITT72@vger.kernel.org>
In-Reply-To: <200409210338.00863.adaplas@hotpop.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, adaplas@pol.net

On Tuesday 21 September 2004 03:38, Antonino A. Daplas wrote:

> > fbdev-arrange-driver-order-in-makefile.patch

BTW, you may get rejects with the above patch as it depends on this.

fbdev-initialize-i810fb-after-agpgart.patch

Tony
