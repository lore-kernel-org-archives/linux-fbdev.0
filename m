From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] Re: rotation.
Date: Thu, 9 Jan 2003 19:45:54 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0301091944540.5660-100000@phoenix.infradead.org>
References: <20030108104817.GA10165@iliana>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20030108104817.GA10165@iliana>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> > Fbcon has the advantage that it'll work for all frame buffer devices.
> 
> But you could also provide driver hooks for the chips which have such a
> rotation feature included (don't know if such exist, but i suppose they
> do, or may in the future).

Hooks already exist in struct fb_ops.

> So, we also support fbcon for not left to righ locales ?

That will happen in the core console code.
