From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [2.6 patch] cyber2000fb.c: misc cleanups
Date: Sun, 21 Nov 2004 20:56:13 +0000
Message-ID: <20041121205613.GA12634@infradead.org>
References: <20041121153614.GR2829@stusta.de> <20041121204752.A23300@flint.arm.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261789AbUKUU4T@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20041121204752.A23300@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@stusta.de>, Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Sun, Nov 21, 2004 at 08:47:52PM +0000, Russell King wrote:
> On Sun, Nov 21, 2004 at 04:36:14PM +0100, Adrian Bunk wrote:
> > The patch below ncludes the following cleanups for 
> > drivers/video/cyber2000fb.c:
> > - remove five EXPORT_SYMBOL'ed but completely unused functions
> > - make some needlessly global code static
> 
> These are used by the video capture code which isn't merged, but is
> used by people.  Rejected.

If people use the code it should get merged or Adrian has all reasons to
remove or #if 0 the code.
