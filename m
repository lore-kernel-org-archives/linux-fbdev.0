From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 0/4] Cell SPE logos
Date: Fri, 13 Jul 2007 02:06:21 -0700
Message-ID: <20070713020621.e8f2e4ce.akpm@linux-foundation.org>
References: <20070710122702.765654000@pademelon.sonytel.be>
	<20070712160621.644d78d2.akpm@linux-foundation.org>
	<Pine.LNX.4.62.0707131051190.18802@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933910AbXGMJH2@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0707131051190.18802@pademelon.sonytel.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Arnd Bergmann <arnd@arndb.de>, James Simmons <jsimmons@infradead.org>, linux-fbdev-devel@lists.sourceforge.net, cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Fri, 13 Jul 2007 10:52:10 +0200 (CEST) Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:

> > > Summaries:
> > >   [1] fbdev: extract fb_show_logo_line()
> > >   [2] fbdev: Add fb_append_extra_logo()
> > 
> > This one does give additional code and data to all fbdev users while only
> > being useful to cell machines.  Should we fix that?
> 
> I can protect it by #ifdef CONFIG_PPC_CELL (as long as there are no other
> users). Would that be OK?

umm, your call.  If that makes sense, sure.
