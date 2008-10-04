From: krzysztof.h1@poczta.fm
Subject: Re: [PATCH -mm] fb: fix NULL pointer BUG dereference in fb_open()
Date: 04 Oct 2008 12:20:02 +0200
Message-ID: <20081004102002.36184141A442@f15.poczta.interia.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753322AbYJDKUW@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/plain; charset="us-ascii"
To: "righi.andrea@gmail.com" <righi.andrea@gmail.com>, Krzysztof Helt <krzysztof.h1@poczta.fm>, Andrew Morton <akpm@linux-foundation.org>, "adaplas@gmail.com" <adaplas@gmail.com>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>

> Accessing to an unregistered fb device raises the following bug, because
> mutex_unlock() is called on fb_info->lock, but fb_info is NULL.
> 
> Also use a better coding style.
> 

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

----------------------------------------------------------------------
Dzwon taniej na zagraniczne komorki!
Sprawdz >> http://link.interia.pl/f1f26 
