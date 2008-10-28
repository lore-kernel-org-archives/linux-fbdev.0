From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] macfb: Do not overflow fb_fix_screeninfo.id
Date: Mon, 27 Oct 2008 22:09:57 -0700
Message-ID: <20081027220957.42cac1db.akpm@linux-foundation.org>
References: <Pine.LNX.4.64.0810270822540.15317@anakin>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0810270822540.15317@anakin>
Sender: linux-m68k-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux/m68k <linux-m68k@vger.kernel.org>, Finn Thain <fthain@telegraphics.com.au>, stable@kernel.org

On Mon, 27 Oct 2008 08:23:43 +0100 (CET) Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> From: Finn Thain <fthain@telegraphics.com.au>
> 
> Don't overflow the 16-character fb_fix_screeninfo id string (fixes some 
> console erasing and blanking artifacts). Have the ID default to "Unknown" 
> on machines with no built-in video and no nubus devices. Check for 
> fb_alloc_cmap failure.

The patch applies OK to 2.6.27, 2.6.26 and 2.6.25 (at least).

Should we backport it and if so, how far?

Thanks.
