From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH 02/17] OMAP: Add TI OMAP1610 accelerator entry.
Date: Wed, 27 Jun 2007 17:00:49 +0530
Message-ID: <5d5443650706270430s4c7e97dfxfc375d2ff4e4ce37@mail.gmail.com>
References: <5d5443650706260534k5d6aca34k9f574b6ffddf85b2@mail.gmail.com>
	 <20070626165205.GB22389@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758590AbXF0La7@vger.kernel.org>
In-Reply-To: <20070626165205.GB22389@uranus.ravnborg.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, akpm@linux-foundation.org, Tony Lindgren <tony@atomide.com>, imre.deak@solidboot.com, juha.yrjola@solidboot.com, linux-kernel@vger.kernel.org

On 6/26/07, Sam Ravnborg <sam@ravnborg.org> wrote:
> Your patch ordering is bad.
> Patch 1 uses the symbol: FB_ACCEL_OMAP1610
> but it is defined by patch 2.
>
> Please reorder patches so the module compiles for each
> and every patch being applied.
>
> In this way you do not break git bisect for example.
>

Yes, in this case I will merge 1st and 2nd patch.

-- 
--Trilok Soni
