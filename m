From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCH] fbcon: replace mono_col macro with static inline
Date: Tue, 26 Feb 2008 12:51:14 -0800
Message-ID: <1204059074.5582.35.camel@brick>
References: <1203963237.5582.4.camel@brick>
	 <Pine.LNX.4.64.0802260917410.5158@anakin>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765547AbYBZUvz@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0802260917410.5158@anakin>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Antonino Daplas <adaplas@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2008-02-26 at 09:18 +0100, Geert Uytterhoeven wrote:
> On Mon, 25 Feb 2008, Harvey Harrison wrote:
> > +static inline int mono_col(struct fb_info *info)
>                               ^^^^^^^^^^^^^^^^^^^^
> const struct fb_info *info?
> 

I suppose, but seeing as it's an inline, does it really matter?

Harvey
