From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RESEND] vgacon: remember scrollback buffer on console
 switch
Date: Sat, 25 Oct 2008 16:14:56 -0700
Message-ID: <20081025161456.643b36c6.akpm@linux-foundation.org>
References: <20081025195814.GD10932@joi>
	<20081025134615.36f7285f.akpm@linux-foundation.org>
	<20081025224247.GA25497@joi>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755023AbYJYXPi@vger.kernel.org>
In-Reply-To: <20081025224247.GA25497@joi>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Marcin Slusarz <marcin.slusarz@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Antonino Daplas <adaplas@gmail.com>, Krzysztof Helt <krzysztof.h1@wp.pl>, linux-fbdev-devel@lists.sourceforge.net

On Sun, 26 Oct 2008 00:43:01 +0200 Marcin Slusarz <marcin.slusarz@gmail.com> wrote:

> PS: why DECLARE_MUTEX _defines_ _semaphore_?

The kernel gets definition-vs-declaration confused in several places.

> there are only 8 uses of this
> macro so it's not a big problem to rename it to e.g. DEFINE_SEMAPHORE (I can
> provide a patch)

I'd say that s/declare/define/ at such a late stage in the semaphore's
lifetime would be of dubious value.  But getting "MUTEX" out of that
macro's name would be a very good thing - it's a bad overlap with struct
mutex.  Send patch :)
