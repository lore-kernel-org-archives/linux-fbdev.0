From: John Bradford <john@grabjohn.com>
Subject: Re: [Linux-fbdev-devel] Re: New logo code [CONFIG OPTIONS]
Date: Mon, 17 Feb 2003 19:32:56 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200302171932.h1HJWuiY011149@darkstar.example.net>
References: <1045509708.1209.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1045509708.1209.22.camel@localhost.localdomain> from "Antonino Daplas" at Feb 18, 2003 03:23:11 AM
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Antonino Daplas <adaplas@pol.net>
Cc: geert@linux-m68k.org, schottelius@wdt.de, thoffman@arnor.net, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

> So how about making the logo "float" above/obscure the text (ie,
> overlay)?  It's not difficult to implement since fbcon.c has "redraw"
> versions of fbcon_bmove() and fbcon_clear().  All that needs to be done
> is do a "scissors" test before an fb_imageblit().  

On the subject of the new logo code, would it be worth making it do
something, (change colour, move, or animate), during a console bell?

John.
