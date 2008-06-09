From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [Linux-fbdev-devel] [PATCH 3/4] drivers/video/fsl-diu-fb.c: add
 missing of_node_put
Date: Mon, 9 Jun 2008 20:06:41 +0200
Message-ID: <20080609200641.9544b500.krzysztof.h1@poczta.fm>
References: <Pine.LNX.4.64.0806091420450.16009@ask.diku.dk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758774AbYFISEW@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0806091420450.16009@ask.diku.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Julia Lawall <julia@diku.dk>
Cc: adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Mon, 9 Jun 2008 14:21:18 +0200 (CEST)
Julia Lawall <julia@diku.dk> wrote:

> From: Julia Lawall <julia@diku.dk>
> 
> of_node_put is needed before discarding a value received from
> of_find_node_by_type, eg in error handling code.
> 
(...)
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>
> 

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---------------------------------------------------------------
Sprawdz jak zdobyc zdrowy usmiech!
Kliknij >> http://link.interia.pl/f1e26
