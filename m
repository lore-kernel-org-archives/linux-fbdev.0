From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86: replace a magic number with a named constant in
	the VESA boot code
Date: Sun, 5 Oct 2008 18:39:49 +0200
Message-ID: <20081005163949.GA18181@elte.hu>
References: <20081005101604.GA1995@spock.one.pl>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762021AbYJEQoo@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20081005101604.GA1995@spock.one.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Januszewski <spock@gentoo.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>


* Michal Januszewski <spock@gentoo.org> wrote:

> Replace a magic number with a named constant in the VESA boot code.
> 
> Signed-off-by: Michal Januszewski <spock@gentoo.org>
> ---
> diff --git a/arch/x86/boot/video-vesa.c b/arch/x86/boot/video-vesa.c

applied to tip/x86/setup, thanks Michal!

	Ingo
