From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [Linux-fbdev-devel] [PATCH] sisfb: fix color component length
 for pseudocolor modes
Date: Wed, 1 Apr 2009 19:05:50 +0200
Message-ID: <20090401190550.fe7b98c7.krzysztof.h1@poczta.fm>
References: <20090330221340.GF6993@spock.one.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933254AbZDASEx@vger.kernel.org>
In-Reply-To: <20090330221340.GF6993@spock.one.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: spock@gentoo.org
Cc: linux-kernel@vger.kernel.org, thomas@winischhofer.net, linux-fbdev-devel@lists.sourceforge.net

On Tue, 31 Mar 2009 00:13:40 +0200
Michal Januszewski <spock@gentoo.org> wrote:

> sisfb incorrectly sets the length of the color fields to 6 bits
> for PSEUDOCOLOR modes, even though 8 bits are always used per pixel.
> Fix this by setting the length to 8.
> 
> Signed-off-by: Michal Januszewski <spock@gentoo.org>
> Cc: Thomas Winischhofer <thomas@winischhofer.net>
> ---

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>


----------------------------------------------------------------------
Twoj znajomy gwiazda filmu XXX? Wkrec go! ;) 
Kliknij >>> http://link.interia.pl/f20f1
