From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] fbdev: Fix usage of blank value passed to fb_blank
Date: Sun, 29 Jan 2006 18:40:06 +0800
Message-ID: <43DC9B86.2000200@gmail.com>
References: <20060127231314.GA28324@hansmi.ch>	<20060127.204645.96477793.davem@davemloft.net>	<43DB0839.6010703@gmail.com>	<200601282106.21664.ioe-lkml@rameria.de>	<43DC25EB.1040005@gmail.com> <20060129001832.4fe6fd7f.akpm@osdl.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750905AbWA2Kk1@vger.kernel.org>
In-Reply-To: <20060129001832.4fe6fd7f.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, ioe-lkml@rameria.de, linux-kernel@vger.kernel.org, davem@davemloft.net, benh@kernel.crashing.org, linux-kernel@hansmi.ch

Andrew Morton wrote:
> "Antonino A. Daplas" <adaplas@gmail.com> wrote:
>> Unfortunately, this may cause some userland breakage.  X should work.
>>  However, some apps may have been developed that uses the FB_BLANK constants
>>  (DirectFB?).  In these cases, they'll get a deeper blank level instead, so it
>>  probably won't affect them significantly.  A follow up patch that hides the 
>>  FB_BLANK constants may be worthwhile.
> 
> Would prefer to avoid any userland breakage.  Is this followup patch
> happening?

I'm still doing research on which major fb apps depend on the FB_BLANK constants, but
my guess is that the follow up patch is inevitable. We cannot avoid bending over
backwards for X :(

Tony
