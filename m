From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: Fix IO access in rivafb
Date: Tue, 9 Nov 2004 06:18:10 +0800
Message-ID: <200411090618.10418.adaplas@hotpop.com>
References: <200411080521.iA85LbG6025914@hera.kernel.org> <200411081633.00645.adaplas@hotpop.com> <1099950617.3946.163.camel@gaston>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261274AbUKHWSx@vger.kernel.org>
In-Reply-To: <1099950617.3946.163.camel@gaston>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, adaplas@pol.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>, Guido Guenther <agx@sigxcpu.org>

On Tuesday 09 November 2004 05:50, Benjamin Herrenschmidt wrote:
> On Mon, 2004-11-08 at 16:33 +0800, Antonino A. Daplas wrote:
> > Hmm, I'll ask Guido Guenther if he can test the changes. I think a
> > different set of access macros for PPC might be a more preferrable
> > solution.
>
> Well, I'd rather leave the registers Little Endian, but then, it will
> clash with X which does put them into Big Endian mode, so that would
> have to be restored all the time.
>

I also asked Guido if he can test the removal of the code that puts the
hardware in big endian, although I told him that I prefer a new set of
access macros.  But I'll leave this decision to you people. 

Tony
