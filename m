From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 02/17] OMAP: Add TI OMAP1610 accelerator entry.
Date: Tue, 26 Jun 2007 18:52:05 +0200
Message-ID: <20070626165205.GB22389@uranus.ravnborg.org>
References: <5d5443650706260534k5d6aca34k9f574b6ffddf85b2@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758515AbXFZQwT@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5d5443650706260534k5d6aca34k9f574b6ffddf85b2@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Trilok Soni <soni.trilok@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, akpm@linux-foundation.org, Tony Lindgren <tony@atomide.com>, imre.deak@solidboot.com, juha.yrjola@solidboot.com, linux-kernel@vger.kernel.org

Your patch ordering is bad.
Patch 1 uses the symbol: FB_ACCEL_OMAP1610
but it is defined by patch 2.

Please reorder patches so the module compiles for each
and every patch being applied.

In this way you do not break git bisect for example.

	Sam
