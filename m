From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] [patch] 2.6.9-rc1-mm4: atyfb_base.c gcc 2.95 compile error
Date: Wed, 8 Sep 2004 08:38:12 +0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200409080838.12496.adaplas@hotpop.com>
References: <20040907020831.62390588.akpm@osdl.org> <20040907192616.GC2454@fs.tum.de>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268819AbUIHAiZ@vger.kernel.org>
In-Reply-To: <20040907192616.GC2454@fs.tum.de>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, jsimmons@infradead.org, geert@linux-m68k.org, linux-fbdev-devel@lists.sourceforge.net

On Wednesday 08 September 2004 03:26, Adrian Bunk wrote:
> On Tue, Sep 07, 2004 at 02:08:31AM -0700, Andrew Morton wrote:
> >...
> > +fbdev-add-module_init-and-fb_get_options-per-driver.patch
> >
> >  fbdev update
> >...
>
> gcc 2.95 doesn't support code mixed with variable declarations:
>
> <--  snip  -->
>

My fault, I did not look more closely, thanks for the fix.

Tony
