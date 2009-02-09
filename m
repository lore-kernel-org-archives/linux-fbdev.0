From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 10/15] sunxvr500: fix cmap memory leaks
Date: Sun, 08 Feb 2009 16:59:25 -0800 (PST)
Message-ID: <20090208.165925.240846008.davem@davemloft.net>
References: <20090207121540.0e618d0f@ephemeral>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754178AbZBIA7m@vger.kernel.org>
In-Reply-To: <20090207121540.0e618d0f@ephemeral>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: Text/Plain; charset="us-ascii"
To: dilinger@queued.net
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com

From: Andres Salomon <dilinger@queued.net>
Date: Sat, 7 Feb 2009 12:15:40 -0500

[ Fixed typo in adaplas's email address ]

>  - fix cmap leak in removal path
>  - fix cmap leak when register_framebuffer fails
> 
> Signed-off-by: Andres Salomon <dilinger@debian.org>

I assume the fbdev folks will pick this up or should I take
it in my sparc tree?

Thanks.
