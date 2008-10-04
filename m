From: "Michal Januszewski" <michalj@gmail.com>
Subject: Re: [PATCH v3] fbdev: ignore VESA modes if framebuffer does not support them
Date: Sat, 4 Oct 2008 21:45:31 +0200
Message-ID: <5d9b736f0810041245g4f05326sdf98e9d86472f874@mail.gmail.com>
References: <20080928125414.GA27703@spock.one.pl>
	 <20081002234011.51ad28b1.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754725AbYJDTpr@vger.kernel.org>
In-Reply-To: <20081002234011.51ad28b1.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, krzysztof.h1@poczta.fm, bonbons@linux-vserver.org, hpa@zytor.com

On Fri, Oct 3, 2008 at 08:40, Andrew Morton <akpm@linux-foundation.org> wrote:

> -mm's efifb-imacfb-consolidation-hardware-support.patch removed FB_IMAC
> and moved it into FB_EDD.  But your patch changes FB_IMAC and not
> FB_EDD, so I don't know what needs to be done here.

I had a look at that patch and it looks like simply dropping the FB_IMAC
part from my patch is correct (i.e. the version of
fbdev-ignore-vesa-modes-if-framebuffer-does-not-support-them
that is currently in -mm is fine).

Best regards,
-- 
Michal Januszewski, Gentoo Linux Developer
http://people.gentoo.org/spock
